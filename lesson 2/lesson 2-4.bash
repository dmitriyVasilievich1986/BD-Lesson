# создаем дамп БД из одной таблицы, первых 100 строк
mysqldump -u root example users --where="true limit 100" > lesson2.4.bddump

# все