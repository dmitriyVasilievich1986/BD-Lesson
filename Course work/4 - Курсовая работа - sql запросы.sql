USE geekbrain;

-- Запрос на самый популярный курс обучения				
SELECT c.name, COUNT(cu.user_id) AS members
		FROM course c
			RIGHT JOIN course_users cu
				ON c.id = cu.course_id
			GROUP BY c.name
			ORDER BY members DESC
			LIMIT 5;

-- Выбор курса обучения с самым популярным видео роликом
SELECT c.name, c.description 
	FROM course c 
RIGHT JOIN course_video cv
	ON c.id = cv.video_id 
WHERE cv.video_id  = 
	(SELECT id FROM
		(SELECT id, COUNT(likes_video.likes_id ) OVER (PARTITION BY video.name ) AS likes
			FROM video
				RIGHT JOIN likes_video
			ON video.id = likes_video.video_id 
			ORDER BY likes DESC LIMIT 1) AS asd);

-- Аггрегация данных по курсу обучения: самый молодой, самый возростной ученик, всего участников
SELECT DISTINCT c.name,
	MIN(p.birthday) OVER w AS oldest,
	MAX(p.birthday) OVER w AS youngest,
	COUNT(u.login ) OVER w AS members
FROM (course c
	JOIN course_users cu
ON c.id = cu.course_id
	JOIN users u
ON u.id = cu.user_id
	JOIN profiles p
ON p.user_id = u.id)
	WINDOW w AS (PARTITION BY c.name);
