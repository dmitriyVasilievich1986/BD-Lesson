--Задание 2

SELECT
	(SELECT first_name
		FROM users
		WHERE id=profiles.user_id) as name,
	birthday,
	(SELECT COUNT(user_id)
		FROM likes
		WHERE user_id=profiles.user_id) as summary
FROM profiles
ORDER BY birthday DESC
LIMIT 10;