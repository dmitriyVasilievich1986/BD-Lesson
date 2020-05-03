-- ������� ��
DROP DATABASE IF EXISTS geekbrain;
CREATE DATABASE IF NOT EXISTS geekbrain;

-- ���� � ��������� ��
USE geekbrain;

-- ������� �������� ��� �������� �������
-- ������� ������� �������������
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	login VARCHAR(255) NOT NULL UNIQUE COMMENT 'login ������������',
	email VARCHAR(255) NOT NULL UNIQUE COMMENT '����� ������������'
) COMMENT = '������������';

-- C������ ������� �������� �������������
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL COMMENT '��� ������������',
	surname VARCHAR(255) NOT NULL COMMENT '������� ������������',
	city VARCHAR(255) COMMENT '����� ������������',
	birthday DATE COMMENT '���� �������� ������������',
	phone VARCHAR(15) COMMENT '������� ������������'
) COMMENT = '������� �������������';

-- ������� ������� ����� �������
DROP TABLE IF EXISTS video;
CREATE TABLE video (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE COMMENT '�������� ������',
	description VARCHAR(255) COMMENT '�������� ������',
	storage VARCHAR(255) NOT NULL UNIQUE COMMENT '����� �������� ������'
) COMMENT = '����� ������';

-- ������� ������� ������������
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	commentary_text TEXT NOT NULL COMMENT '����� �����������',
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������'
) COMMENT = '��������';

-- ������� ������� ������
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������'
) COMMENT = '�����';

-- ������� ������� ����� ��������
DROP TABLE IF EXISTS course;
CREATE TABLE course (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(150) NOT NULL UNIQUE COMMENT '�������� �����',
	description VARCHAR(255) COMMENT '�������� �����'
) COMMENT = '���� ��������';

-- ������ ������� ������� ������
-- �������� ������� ����� ��������� � �����
DROP TABLE IF EXISTS comments_video;
CREATE TABLE comments_video (
	comment_id INT UNSIGNED NOT NULL COMMENT '������ �� �����������',
	video_id INT UNSIGNED NOT NULL COMMENT '������ �� �����'
) COMMENT = '�������� � �����';

-- �������� ������� ����� ������ � �����
DROP TABLE IF EXISTS likes_video;
CREATE TABLE likes_video (
	likes_id INT UNSIGNED NOT NULL COMMENT '������ �� ����',
	video_id INT UNSIGNED NOT NULL COMMENT '������ �� �����'
) COMMENT = '����� � �����';

-- �������� ������� ����� ����� �������� � �����
DROP TABLE IF EXISTS course_video;
CREATE TABLE course_video (
	course_id INT UNSIGNED NOT NULL COMMENT '������ �� ����',
	video_id INT UNSIGNED NOT NULL COMMENT '������ �� �����'
) COMMENT = '����� � ����� ��������';

-- �������� ������� ����� ����� �������� � ������������
DROP TABLE IF EXISTS course_users;
CREATE TABLE course_users (
	course_id INT UNSIGNED NOT NULL COMMENT '������ �� ����',
	user_id INT UNSIGNED NOT NULL COMMENT '������ �� ������������'
) COMMENT = '����� ������� � ������������';

-- ������ �������� ������� ����� ��� ����� ������
-- �������� ����� ��� ������������ � �������
ALTER TABLE profiles
	ADD CONSTRAINT profiles_user_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
-- �������� ����� ��� ������������ � ���������
ALTER TABLE comments
	ADD CONSTRAINT comments_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
	
-- �������� ����� ��� ������������ � ������
ALTER TABLE likes
	ADD CONSTRAINT likes_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id);
	
-- �������� ����� ��� ������ � �����
ALTER TABLE likes_video
	ADD CONSTRAINT likes_from_likes_fk
		FOREIGN KEY (likes_id) REFERENCES likes(id),
	ADD CONSTRAINT likes_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);
	
-- �������� ����� ��� ��������� � �����
ALTER TABLE comments_video
	ADD CONSTRAINT comments_from_likes_fk
		FOREIGN KEY (comment_id) REFERENCES comments(id),
	ADD CONSTRAINT comments_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);
	
-- �������� ����� ��� ������������ � ����� ��������
ALTER TABLE course_users
	ADD CONSTRAINT course_users_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT course_fk
		FOREIGN KEY (course_id) REFERENCES course(id);
	
-- �������� ����� ��� ����� �������� � �����
ALTER TABLE course_video
	ADD CONSTRAINT course_from_likes_fk
		FOREIGN KEY (course_id) REFERENCES course(id),
	ADD CONSTRAINT course_from_video_fk
		FOREIGN KEY (video_id) REFERENCES video(id);