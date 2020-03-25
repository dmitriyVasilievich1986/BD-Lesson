# создаем дамп БД
mysqldump -u root example > lesson2_3.bddump

# заливаем дамп в БД sample
mysql -u root sample < lesson2_3.bddump

# все