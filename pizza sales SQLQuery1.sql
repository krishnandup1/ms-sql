select * from [PROJ PORT].dbo.pizza_sales

select round(SUM(total_price),2) as total_revenue from [PROJ PORT].dbo.pizza_sales


select count( distinct order_id) as Avg_ord from [PROJ PORT].dbo.pizza_sales
select round(SUM(total_price),2) as total_revenue from [PROJ PORT].dbo.pizza_sales


select (SUM(total_price)/count( distinct order_id)) as Avg_ord_value from [PROJ PORT].dbo.pizza_sales


select sum( quantity) as_ord from [PROJ PORT].dbo.pizza_sales


select count( distinct order_id) as sum_ord from [PROJ PORT].dbo.pizza_sales



select DATENAME(dw,order_date) as day_, COUNT(distinct order_id) as total_order from [PROJ PORT].dbo.pizza_sales
group by DATENAME(dw,order_date)
order by COUNT(distinct order_id)


select DATENAME(HOUR,order_time)  as hour_, COUNT(distinct order_id) as total_order 
from [PROJ PORT].dbo.pizza_sales
group by DATENAME(HOUR,order_time) 
order by COUNT(distinct order_id)

select DATENAME(YEAR,order_date) as Year_, DATENAME(MONTH,order_date)  as month_, 
COUNT(distinct order_id) as total_order from [PROJ PORT].dbo.pizza_sales
group by DATENAME(YEAR,order_date), DATENAME(MONTH,order_date) 
order by COUNT(distinct order_id)

select pizza_category,
(Sum(total_price)/( select SUM(total_price) from [PROJ PORT].dbo.pizza_sales))*100 as pct_sale
from [PROJ PORT].dbo.pizza_sales
group by pizza_category


select pizza_size,
cast(((Sum(total_price)/( select SUM(total_price) from [PROJ PORT].dbo.pizza_sales))*100) as decimal (4,2)) as pct_sale
from [PROJ PORT].dbo.pizza_sales
group by pizza_size

print 'top 5 pizza name,total quantity, total order'
select  top 5 pizza_name, round(SUM(total_price),2) as total_revenue,SUM(quantity) as total_quan,
count(distinct order_id) as no_of_people from [PROJ PORT].dbo.pizza_sales
group by pizza_name
order by SUM(total_price) desc,SUM(quantity) desc ,count(distinct order_id) desc

print 'Bottom 5 pizza name by revenue , total quantity, total order'

select top 5  pizza_name, round(SUM(total_price),2) as total_revenue,SUM(quantity) as total_quan,
count(distinct order_id) as no_of_people from [PROJ PORT].dbo.pizza_sales
group by pizza_name
order by SUM(total_price) ,SUM(quantity)  ,count(distinct order_id) 



