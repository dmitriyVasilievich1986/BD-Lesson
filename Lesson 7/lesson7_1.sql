--Задание 1

SELECT *
	FROM users u
	JOIN orders o
ON u.id IN
	(SELECT user_id
		FROM orders);