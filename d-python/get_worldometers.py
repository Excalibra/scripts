from selenium import webdriver
from bs4 import BeautifulSoup
import csv
from datetime import datetime
import pandas as pd
import os


# Справочная информация:
# Документация BS: https://www.crummy.com/software/BeautifulSoup/bs4/doc.ru/bs4ru.html
# Selenium: https://selenium-python-zh.readthedocs.io/en/latest/index.html

# ------------- Инициализация конфигурации webUI ----------------------------

driver = webdriver.Chrome()  
driver.get("https://www.worldometers.info/ru/")  

# Получение исходного кода веб-страницы и его передача в BeautifulSoup для парсинга
soup = BeautifulSoup(driver.page_source, 'html.parser')


# ------------ Извлечение данных из определённых колонок и запись в CSV-файл ------------- #

# Поиск всех <span class=item /> и <span class=rts-counter />
current_population_words = soup.find_all('span', class_='item')
current_population_num = soup.find_all('span', class_='rts-counter')


# ---------- Новое: Добавление текущей даты в качестве суффикса имени файла (2023-04-26) ---------------

# Получение текущего времени
now = datetime.now()

# Форматирование времени в заданный строковый формат
formatted_time = now.strftime('%Y-%m-%d')


# ------------ Извлечение данных из определённых колонок ---------------------------

# Маркер повторяющихся значений
duplicate_value = 1
# Количество элементов берётся из current_population_num
num_elements = len(current_population_num)

# Создание CSV-файла с именем "output.csv" (старый подход)
# {} — это плейсхолдер, который заменяется переданными значениями через .format()
with open("worldometers_{}.csv".format(formatted_time), "w", newline='', encoding='utf-8-sig') as csvfile:
    # Определение названий колонок
    fieldnames = ['Колонка A', 'Колонка B']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # Запись заголовка
    writer.writeheader()

    for i in range(num_elements):
        duplicate_value = duplicate_value + 1
        if duplicate_value == 52:
            continue
        row_data = {'Колонка A': current_population_words[i].text, 'Колонка B': current_population_num[i].text}
        writer.writerow(row_data)

# ------------ Новое: Удаление лишних символов и сохранение в xlsx (2023-4-29) --------------
# 1. CSV-файлы менее удобны для работы, поэтому данные сохраняются как xlsx.
# 2. Конвертация текстовых значений в числовые выполняется удобнее в Excel, поэтому здесь пропущено.

# Чтение CSV-файла
df = pd.read_csv("worldometers_{}.csv".format(formatted_time))

# Нахождение строк 39 и 40 в колонке A и удаление символов "-="
df.loc[38:39, 'Колонка A'] = df.loc[38:39, 'Колонка A'].apply(lambda x: x.replace('-=', ''))

# Сохранение изменённых данных в xlsx-файл, преобразование колонки B в числовой формат
df.to_excel("worldometers_{}.xlsx".format(formatted_time), index=False)

# Удаление исходного CSV-файла
os.remove("worldometers_{}.csv".format(formatted_time))
