# открываем сервер mysql
mysql -u root

# далее
DROP DATABASE IF EXISTS example;
DROP DATABASE IF EXISTS sample;
SELECT 'Создаем DB example и сразу sample';
CREATE DATABASE example;
CREATE DATABASE sample;
USE example;

SELECT 'Создаем таблицу users';
CREATE TABLE users(
        id SERIAL PRIMARY KEY,
        name VARCHAR(255)
);

SELECT 'Добавляем данные в таблицу';
INSERT INTO users VALUES
        (DEFAULT, 'bob'),
        (DEFAULT, 'john');

SELECT * FROM users;

\q