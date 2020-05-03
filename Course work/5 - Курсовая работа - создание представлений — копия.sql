use geekbrain;

-- Создание представления 'информация о пользователе'
CREATE OR REPLACE VIEW user_full_info AS
	SELECT u.login, u.email, p.name, p.surname, p.city, p.phone
		FROM users u
	JOIN profiles p
		ON u.id = p.user_id;

-- Создание представления 'информация о курсе обучения'
CREATE OR REPLACE VIEW course_full_info AS	
	SELECT c.name, v.name AS video_name, v.description, v.storage
		FROM course c
			JOIN course_video cv
		ON c.id = cv.video_id
			JOIN video v
		ON v.id = cv.video_id;