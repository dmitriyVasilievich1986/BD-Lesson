-- Создаем БД
DROP DATABASE IF EXISTS geekbrain;
CREATE DATABASE IF NOT EXISTS geekbrain;

-- Вход в созданную БД
USE geekbrain;

-- Сначала создадим все основные таблицы
-- Создаем таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	login VARCHAR(255) NOT NULL UNIQUE COMMENT 'login пользователя',
	email VARCHAR(255) NOT NULL UNIQUE COMMENT 'почта пользователя'
) COMMENT = 'Пользователи';

-- Cоздаем таблицу профилей пользователей
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL COMMENT 'имя пользователя',
	surname VARCHAR(255) NOT NULL COMMENT 'фамилия пользователя',
	city VARCHAR(255) COMMENT 'город пользователя',
	birthday DATE COMMENT 'дата рождения пользователя',
	phone VARCHAR(15) COMMENT 'телефон пользователя'
) COMMENT = 'Профили пользователей';

-- Создаем таблицу видео роликов
DROP TABLE IF EXISTS video;
CREATE TABLE video (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE COMMENT 'название ролика',
	description VARCHAR(255) COMMENT 'описание ролика',
	storage VARCHAR(255) NOT NULL UNIQUE COMMENT 'место хранения ролика'
) COMMENT = 'Видео ролики';

-- Создаем таблицу комментариев
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	commentary_text TEXT NOT NULL COMMENT 'текст комментария',
	user_id INT UNSIGNED NOT NULL COMMENT 'ссылка на пользователя'
) COMMENT = 'комменты';

-- Создаем таблицу лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL COMMENT 'ссылка на пользователя'
) COMMENT = 'лайки';

-- Создаем таблицу курса обучения
DROP TABLE IF EXISTS course;
CREATE TABLE course (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE COMMENT 'название курса',
	description VARCHAR(255) COMMENT 'описание курса'
) COMMENT = 'курс обучения';

-- Теперь создаем таблицы связей
-- Создадим таблицу связи комментов к видео
DROP TABLE IF EXISTS comments_video;
CREATE TABLE comments_video (
	comment_id INT UNSIGNED NOT NULL COMMENT 'ссылка на комментарий',
	video_id INT UNSIGNED NOT NULL COMMENT 'ссылка на видео'
) COMMENT = 'комменты к видео';

-- Создадим таблицу связи лайков к видео
DROP TABLE IF EXISTS likes_video;
CREATE TABLE likes_video (
	likes_id INT UNSIGNED NOT NULL COMMENT 'ссылка на лайк',
	video_id INT UNSIGNED NOT NULL COMMENT 'ссылка на видео'
) COMMENT = 'лайки к видео';

-- Создадим таблицу связи курса обучения к видео
DROP TABLE IF EXISTS course_video;
CREATE TABLE course_video (
	course_id INT UNSIGNED NOT NULL COMMENT 'ссылка на курс',
	video_id INT UNSIGNED NOT NULL COMMENT 'ссылка на видео'
) COMMENT = 'видео в курсе обучения';

-- Создадим таблицу связи курса обучения к пользователю
DROP TABLE IF EXISTS course_users;
CREATE TABLE course_users (
	course_id INT UNSIGNED NOT NULL COMMENT 'ссылка на курс',
	user_id INT UNSIGNED NOT NULL COMMENT 'ссылка на пользователя'
) COMMENT = 'курсы обуения у пользователя';

-- Теперь создадим внешние ключи для связи таблиц
-- Создадим ключи для пользователя и профиля
ALTER TABLE profiles
	ADD CONSTRAINT profiles_user_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
-- Создадим ключи для пользователя и комментов
ALTER TABLE comments
	ADD CONSTRAINT comments_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
	
-- Создадим ключи для пользователя и лайков
ALTER TABLE likes
	ADD CONSTRAINT likes_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
	
-- Создадим ключи для лайков к видео
ALTER TABLE likes_video
	ADD CONSTRAINT likes_from_likes_fk
		FOREIGN KEY (likes_id) REFERENCES likes(id),
	ADD CONSTRAINT likes_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);
	
-- Создадим ключи для комментов к видео
ALTER TABLE comments_video
	ADD CONSTRAINT comments_from_likes_fk
		FOREIGN KEY (comment_id) REFERENCES comments(id),
	ADD CONSTRAINT comments_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);
	
-- Создадим ключи для пользователя и курса обучения
ALTER TABLE course_users
	ADD CONSTRAINT course_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT course_fk
		FOREIGN KEY (course_id) REFERENCES course(id);
	
-- Создадим ключи для курса обучения к видео
ALTER TABLE course_video
	ADD CONSTRAINT course_from_likes_fk
		FOREIGN KEY (course_id) REFERENCES course(id),
	ADD CONSTRAINT course_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);