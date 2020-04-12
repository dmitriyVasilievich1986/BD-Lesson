--Задание 3

SELECT
	(SELECT gender
		FROM profiles
		WHERE user_id=likes.user_id) AS sex,
	COUNT(*) AS summary
FROM likes
GROUP BY sex
ORDER BY sex
LIMIT 1;