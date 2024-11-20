-- 1. получить все продажи произведенные в городе 'town1' за 2019 год

SELECT c.time, c.cost
FROM sales c, dep b 
WHERE b.id=c.dep_id 
AND b.city='town1'
AND date_part('year', c.time) = '2019';


-- 2. показать все отделы, где в марте 2020 года были продажи товаров с ценой (sales.cost) меньше 500.

SELECT b.name, c.cost
FROM dep b JOIN sales c ON b.id=c.dep_id
WHERE c.time BETWEEN '2020-03-01 00:00' AND '2020-04-01 00:00'
AND c.cost<'500';

-- 3. увеличить значение цены (prod.price)  в таблице в два раза у всех товаров, 
-- которые продавались в 2018 году в отделе 'dep10'

UPDATE prod 
  SET price=price*2 
  WHERE id = 
  (
     SELECT DISTINCT c.prod_id 
     FROM sales c JOIN dep b ON b.id = c.dep_id
     WHERE date_part('year', c.time) = '2018' AND b.name='dep10'
  )
  RETURNING price;

/*4. составить сводный отчет по суммарной стоимости товаров проданных в городе 'town1'
в период с 2018 года по текущий включительно в следующем виде
Это должен быть просто запрос к текущим таблицам, делать промежуточные таблицы, 
заполненные pl/pgsql кодом не нужно (при очень большом желании это можно сделать дополнительно).
(Должно быть 13 столбцов и 3 строки) :
----------------------------------------
год \ месяц 1 2 3 4 5 6 7 8 9 10 11 12
----------------------------------------
2018        x x x x x x x x x x  x  x
2019        x x x x x x x x x x  x  x
2020        x x x x x x x x x x  x  x */

SELECT 
  date_part('year', c.time) as "год\месяц",
  SUM (case when date_part('month', c.time) = '01' then c.cost end) as "1",
  SUM (case when date_part('month', c.time) = '02' then c.cost end) as "2",
  SUM (case when date_part('month', c.time) = '03' then c.cost end) as "3",
  SUM (case when date_part('month', c.time) = '04' then c.cost end) as "4",  
  SUM (case when date_part('month', c.time) = '05' then c.cost end) as "5",
  SUM (case when date_part('month', c.time) = '06' then c.cost end) as "6",
  SUM (case when date_part('month', c.time) = '07' then c.cost end) as "7",
  SUM (case when date_part('month', c.time) = '08' then c.cost end) as "8", 
  SUM (case when date_part('month', c.time) = '09' then c.cost end) as "9",
  SUM (case when date_part('month', c.time) = '10' then c.cost end) as "10",
  SUM (case when date_part('month', c.time) = '11' then c.cost end) as "11",
  SUM (case when date_part('month', c.time) = '12' then c.cost end) as "12"
FROM sales c JOIN dep b ON c.dep_id = b.id 
WHERE b.city = 'town1'
GROUP BY date_part('year', c.time)