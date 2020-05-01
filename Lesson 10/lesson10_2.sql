--- Задание 2
	
SELECT DISTINCT c.name AS name,
	COUNT(cu.user_id ) OVER w AS count_users_in_group,
	COUNT(*) OVER() / (SELECT COUNT(communities.id ) FROM communities) AS average_users_in_group,
	min(pr.birthday ) OVER w AS youngest,
	max(pr.birthday ) OVER w AS older,
	(SELECT COUNT(*) FROM users) AS overall_users,
	COUNT(cu.user_id ) OVER w /  (SELECT COUNT(*) FROM users) * 100 AS average_users_in_group_at_all_users_procentege
		FROM (communities_users cu 
			JOIN communities c
				ON c.id = cu.community_id
			JOIN profiles pr
				ON pr.user_id = cu.user_id)
			WINDOW w AS (PARTITION BY cu.community_id );