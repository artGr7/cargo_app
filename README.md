# CargoApp

CargoApp — это небольшое веб-приложение для оформления, расчёта и отслеживания заявок на грузоперевозки.

## Возможности

- Регистрация и аутентификация пользователей (Devise)
- Создание, просмотр, сортировка и фильтрация заявок на перевозку
- Автоматический расчёт стоимости и расстояния (CargoCalculator)
- Email-уведомления о создании и смене статуса заявки (через Sidekiq и ActiveJob)
- Админ-панель (ActiveAdmin)
- Фоновые задачи (Sidekiq)
- Загрузка файлов (CarrierWave)

## Требования

- Ruby 3.2+
- Rails 8.x
- PostgreSQL
- Redis (для фоновых задач)
- Node.js и Yarn (для фронтенда)
- Sidekiq (фоновые задачи)

## Установка и запуск

1. Клонируйте репозиторий:
   sh
   git clone https://github.com/your-username/cargo_app.git
   cd cargo_app

2. Установите зависимости:

    bundle install
    yarn install

3. Настройте переменные окружения:

    Добавьте переменные DISTANCE_API_KEY и CARGO_APP_DATABASE_PASSWORD в .env

4. Создайте и заполните базу данных:

    rails db:create db:migrate db:seed

5. Запустите Redis

    redis-server

6. Запустите Sidekiq:

    bundle exec sidekiq

7. Запустите сервер:

    rails server

## Тестирование
    Для запуска тестов:
    rails test

