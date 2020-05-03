use geekbrain;

-- Триггер выводит ошибку при попытке поставить лайк к видео если уже был проставлен этим пользователем
DELIMITER //
CREATE TRIGGER validate_user_befor_like BEFORE INSERT ON likes_video
FOR EACH ROW BEGIN
	IF NEW.video_id IN
			(SELECT lv.video_id 
				FROM likes_video lv 
					RIGHT JOIN likes l
				ON lv.likes_id = l.id 
					WHERE lv.likes_id = NEW.likes_id)
	THEN
		SIGNAL SQLSTATE '45000'
    	SET MESSAGE_TEXT = '"Like" to this video file allready exists';
  END IF;
END //

-- Функция
-- Принимает значение: id пользователя
-- Возвращает: id самого популярного курса обучения, отбрасывая те курсы в которых пользователь уже состоит
DROP FUNCTION IF EXISTS friendship_direction;
DELIMITER //
CREATE FUNCTION course_deal(check_user_id INT)
RETURNS INT READS SQL DATA
	BEGIN    
		DECLARE output_id INT;
	SET output_id = 
		(SELECT c.id, COUNT(cu.user_id) AS members
				FROM course c
					RIGHT JOIN course_users cu
						ON c.id = cu.course_id
					WHERE c.name NOT IN
						(SELECT c.name 
							FROM course c 
								JOIN course_users cu
							ON c.id = cu.course_id 
								WHERE cu.user_id = check_user_id)
					GROUP BY c.name
					ORDER BY members DESC
					LIMIT 1);    
    RETURN output_id;
  END//