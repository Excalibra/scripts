import requests
from bs4 import BeautifulSoup
from openpyxl import Workbook
from datetime import datetime

# -----Справочные материалы, три основных-------
# https://docs.python-requests.org/en/latest/
# https://www.crummy.com/software/BeautifulSoup/bs4/doc/
# https://openpyxl.readthedocs.io/en/stable/
# https://docs.python.org/3/library/stdtypes.html#str.strip (срезы)
# -----Справочные материалы, три основных-------

# 5.1 Добавление формата времени для имени файла
# Получаем текущее время
now = datetime.now()
# Форматируем время в строку в заданном формате
# formatted_time = now.strftime('%Y-%-m-%-d')
formatted_time = now.strftime('%Y-%m-%d')

# Создаем объект Workbook для работы с Excel
wb = Workbook()

# Добавляем лист и задаем имя листа
sheet = wb.active
sheet.title = 'Лист1'

# Определяем переменную row для управления позицией записи в процессе обхода
row = 1

# Добавляем заголовки таблицы
sheet['A1'] = 'Заголовок'
sheet['B1'] = 'Категория'
sheet['C1'] = 'Время'

# Проходим по страницам с 1 по 2
for page_num in range(1, 3):
    # f-string
    url = f"https://www.chita.ru/text/?page={page_num}"

    # Общая защита от ботов
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
    }

    r = requests.get(url, headers=headers)
    r.encoding = 'utf-8'
    soup = BeautifulSoup(r.text, 'html.parser')

    # Ищем категории, заголовки и время
    title_elements = soup.find_all('div', class_='dmp3V')
    category_elements = soup.find_all('div', class_='VC1Fb') 
    time_elements = soup.find_all('div', class_='tzxtk')

    # Добавляем конкретные данные, меняя местами категорию и заголовок
    for news_num in range(len(category_elements)):
        sheet.append([category_elements[news_num].text.strip('[]'), title_elements[news_num].text, time_elements[news_num].text])
        row += 1

# Сохраняем Excel файл
wb.save("chita_{}.xlsx".format(formatted_time))
