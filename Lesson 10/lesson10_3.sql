--Задание 3

SELECT users.id,
	COUNT (DISTINCT messages.id),
	COUNT (DISTINCT likes.id),
	COUNT (DISTINCT media.id) AS activity
		FROM users
			LEFT JOIN messages
				ON users.id = messages.from_user_id
			LEFT JOIN likes
				ON users.id = likes.user_id
			LEFT JOIN media
				ON users.id = media.user_id
			GROUP BY users.id
				ORDER BY activity
			LIMIT 10;

-- Мой вариант запроса
		
SELECT DISTINCT users.id,
	COUNT(messages.from_user_id) OVER w AS count_messages,
	COUNT(likes.id) OVER w AS count_likes,
	COUNT(media.id) OVER w AS count_media
		FROM (users
			LEFT JOIN messages 
				ON users.id = messages.from_user_id
			LEFT JOIN likes
				ON likes.user_id = users.id
			LEFT JOIN media
				ON media.user_id = users.id)
			WINDOW w AS (PARTITION BY users.id)
			ORDER BY count_media
				LIMIT 10;