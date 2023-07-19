use test;
drop table if exists sales2;
create table sales2
(
	CustomerSite varchar(20),
	product varchar(20),
    _Key varchar(20),
    Date date,
    quantity decimal(10,2),
    sales decimal(10,2)
);

INSERT INTO sales2 (CustomerSite, product, _key, date, quantity, sales)
VALUES
('M_FRC_0','G0102211','G0102211M_FRC_0','2020-2-01',5,114.5),
('M_FRC_0','G0102211','G0102211M_FRC_0','2021-7-01',50,1195),
('M_BEC_0','G0102211','G0102211M_BEC_0','2021-8-01',45,1090.5),
('M_BEC_0','G0102211','G0102211M_BEC_0','2022-2-01',15,339.3),
('M_EMEA_AE','G0100307','G0100307M_EMEA_AE','2022-6-01',960,16731.2),
('M_EMEA_RU','G0103663','G0103663M_EMEA_RU','2020-8-01',4500,20565),
('M_BEC_0','G0102211','G0102211M_BEC_0','2020-8-01',20,438),
('M_RUS_1','G0100622','G0100622M_RUS_1','2021-12-01',0.5,30.17),
('M_BEC_0','G0102211','G0102211M_BEC_0','2020-3-01',20,430),
('M_FRC_0','G0102211','G0102211M_FRC_0','2021-5-01',5,119.25),
('DC_GWE_0','G0102211','G0102211DC_GWE_0','2022-10-01',20,323.8),
('M_SWE_0','G0102211','G0102211M_SWE_0','2022-11-01',0,300),
('M_EMEA_AE','G0100307','G0100307M_EMEA_AE','2022-7-01',0,0),
('M_BEC_0','G0102211','G0102211M_BEC_0','2022-7-01',35,823.25),
('M_FRC_0','G0102211','G0102211M_FRC_0','2021-9-01',5,127),
('M_BEC_0','G0102211','G0102211M_BEC_0','2021-1-01',40,876),
('M_EMEA_RU','G0103663','G0103663M_EMEA_RU','2021-2-01',3250,11505),
('M_EMEA_RU','G0103663','G0103663M_EMEA_RU','2020-9-01',2000,7080),
('M_RUS_1','G0100622','G0100622M_RUS_1','2020-2-01',3.5,162.76),
('M_BEC_0','G0100307','G0100307M_BEC_0','2022-11-01',130,5135),
('M_BEC_0','G0102211','G0102211M_BEC_0','2021-9-01',40,880.8),
('M_EMEA_RU','G0103663','G0103663M_EMEA_RU','2020-10-01',3000,10620),
('M_BEC_0','G0102211','G0102211M_BEC_0','2020-10-01',25,547.5),
('M_AUS_0','G0103264','G0103264M_AUS_0','2020-3-01',30,574.2),
('M_BEC_0','G0102211','G0102211M_BEC_0','2020-6-01',10,219.5);

select * from sales2;
select * from sales2
order by _key, date desc;

/*
Задача:
Вычислить среднюю стоимость продажи продукта у клиента
только за последние три даты (три даты максимум).
Средняя стоимость считается как сумма продаж за три даты / общее количество за три даты
*/

-- test example
with cte2 as
(
with cte as
(
select *,
dense_rank() over(partition by _key order by date desc) as _rank
from sales2
)
select _key,
sum(sales) over(partition by _key)/sum(quantity) over(partition by _key) as avg_cost
from cte
where _rank <= 3
)
select * from cte2
where avg_cost is not NULL
group by _key;

-- sales
with cte2 as
(
with cte as
(
select *,
dense_rank() over(partition by _key order by date desc) as _rank
from sales
)
select _key,
sum(salestotal) over(partition by _key)/sum(quantity) over(partition by _key) as avg_cost
from cte
where _rank <= 3
)
select * from cte2
where avg_cost is not NULL
group by _key;
