require 'httparty'
require 'nokogiri'
require 'spreadsheet'
require 'date'

# Получаем текущее время
now = DateTime.now
# Форматируем дату
formatted_time = now.strftime('%Y-%m-%d')

# Путь к рабочему столу
desktop_path = File.expand_path("~/Desktop")

# Создаем новый объект Workbook для работы с Excel
book = Spreadsheet::Workbook.new

# Добавляем новый лист в книгу и задаем его название
sheet = book.create_worksheet(name: 'Новости')

# Начальная строка для записи
row = 0

# Добавляем заголовки таблицы
sheet.row(row).concat ['Категория', 'Заголовок', 'Время']
row += 1

# Проходим по страницам сайта (например, с 1 по 9)
(1..9).each do |page_num|
  url = "https://www.chita.ru/text/?page=#{page_num}"

  # Заголовки для обхода блокировки
  headers = {
    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
  }

  response = HTTParty.get(url, headers: headers)
  soup = Nokogiri::HTML(response.body)

  # Получаем данные о категориях, заголовках и времени публикации
  categories = soup.css('div.VC1Fb') # Убедитесь, что класс 'VC1Fb' актуален
  titles = soup.css('div.dmp3V')     # Проверьте, что класс 'dmp3V' правильный
  times = soup.css('div.tzxtk')      # Убедитесь, что класс 'tzxtk' правильный

  # Итерация по данным и добавление их в таблицу
  categories.each_with_index do |category, index|
    sheet.row(row).concat [
      category.content.strip,       # Категория
      titles[index]&.content.strip, # Заголовок (проверяем на nil)
      times[index]&.content.strip   # Время публикации (проверяем на nil)
    ]
    row += 1
  end
end

# Генерация пути для сохранения файла
file_path = File.join(desktop_path, "chita_news_#{formatted_time}.xls")

# Сохраняем Excel-файл
book.write(file_path)

puts "Файл успешно сохранен по пути: #{file_path}"
