--Задание 4
--Запрос по количеству поставленных лайков

SELECT
	(SELECT first_name
		FROM users
		WHERE id=likes.user_id) AS name,
	COUNT(target_id) AS summary
FROM likes
GROUP BY name
ORDER BY summary DESC
LIMIT 10;

--Запрос по количеству дружеских отношений

SELECT
	(SELECT first_name
	FROM users
	WHERE id=friendship.user_id) AS name,
COUNT(*) AS summary
FROM friendship
GROUP BY name
ORDER BY summary DESC
LIMIT 10;

--Запрос по количеству дружеских отношений и кол-ву поставленных лайков

SELECT
	first_name AS name,
	(SELECT
		(SELECT COUNT(*)
			FROM likes
			WHERE user_id=users.id)
		+
		(SELECT COUNT(*)
			FROM friendship
			WHERE user_id=users.id)) AS summary
FROM users
ORDER BY summary DESC
LIMIT 10;