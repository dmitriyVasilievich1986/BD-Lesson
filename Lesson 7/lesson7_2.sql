--Задание 2

SELECT 
	p.id ,
	c.name ,
	p.name,
	p.desription ,
	p.price 
FROM catalogs c 
JOIN products p
ON p.catalog_id =c.id ;