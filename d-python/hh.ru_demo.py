import requests
import json

# Функция для получения ID города (района)
def get_citycode(city_name):
    response = requests.get('https://api.hh.ru/areas')
    city_data = response.json()
    
    # Ищем в каждом регионе города
    for region in city_data:
        # Если город найден в регионе, возвращаем его ID
        for area in region.get('areas', []):
            if area['name'] == city_name:
                return area['id']
    return None

# Функция для получения списка вакансий по ключевым словам и городу
def get_job_list(keywords, city_name):
    city_code = get_citycode(city_name)
    if city_code is None:
        print(f"Город '{city_name}' не найден.")
        return []

    url = "https://api.hh.ru/vacancies"
    params = {
        'text': keywords,  # Ключевые слова для поиска вакансий
        'area': city_code,  # ID города
        'page': 0,  # Стартовая страница
        'per_page': 10,  # Количество вакансий на странице
    }

    response = requests.get(url, params=params)
    data = response.json()

    return data['items']

# Пример использования: поиск вакансий в Москве (центр) по ключевым словам
keywords = "разработчик, кибербезопасность, IT"
city_name = "Москва"  # Можно указать 'Москва' или 'Москва и МО'

job_listings = get_job_list(keywords, city_name)

# Выводим информацию о найденных вакансиях
if job_listings:
    for job in job_listings:
        job_name = job['name']
        salary = job['salary']
        employer_name = job['employer']['name']
        area_name = job['area']['name']
        job_url = job['alternate_url']  # URL вакансии

        # Зарплата (если указана)
        salary_from = salary.get('from', 'Не указано') if salary else 'Не указано'
        salary_to = salary.get('to', 'Не указано') if salary else 'Не указано'
        salary_currency = salary.get('currency', 'Не указана') if salary else 'Не указана'

        # Другие дополнительные данные
        employment_type = job['employment']['name'] if 'employment' in job else 'Не указано'
        experience_required = job['experience']['name'] if 'experience' in job else 'Не указано'
        skills = ', '.join(job['key_skills']) if 'key_skills' in job else 'Не указаны'

        # Выводим все найденные детали вакансии
        print(f"Вакансия: {job_name}")
        print(f"Зарплата: от {salary_from} до {salary_to} {salary_currency}")
        print(f"Компания: {employer_name}")
        print(f"Город: {area_name}")
        print(f"Тип занятости: {employment_type}")
        print(f"Требуемый опыт: {experience_required}")
        print(f"Навыки: {skills}")
        print(f"Ссылка на вакансию: {job_url}")
        print("-" * 40)
else:
    print("По вашему запросу вакансии не найдены.")
