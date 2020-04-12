--Задание 3

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  city_from VARCHAR(255) NOT NULL COMMENT 'город вылета',
  city_to VARCHAR(255) NOT NULL COMMENT 'город прилета'
) COMMENT = 'полеты';

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  city_eng VARCHAR(255) NOT NULL PRIMARY KEY COMMENT 'название города на английском',
  city_ru VARCHAR(255) NOT NULL COMMENT 'название города на руссоком'
) COMMENT = 'города';

--Добавляем данные

INSERT INTO cities 
VALUES
('moscow', 'москва'),
('irkutsk', 'иркутск'),
('novgorod', 'новгород'),
('omsk', 'омск'),
('kazan', 'казань');

INSERT INTO flights 
VALUES
(null, 'moscow', 'omsk'),
(null, 'novgorod', 'kazan'),
(null, 'irkutsk', 'moscow'),
(null, 'omsk', 'irkutsk'),
(null, 'moscow', 'kazan');

--Добавляем ключи

alter table flights 
	drop foreign key flights_city_eng_fk;
alter table flights 
	drop foreign key flights_city_to_fk;

--Делаем выборку

SELECT id,
	(SELECT city_ru
		FROM cities
		WHERE city_eng=f.city_from ),
	(SELECT city_ru
		FROM cities
		WHERE city_eng=f.city_to )
FROM flights f
ORDER BY id ;