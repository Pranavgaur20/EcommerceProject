--TOTAL Order
SELECT COUNT(*) as TotalOrders 
FROM OrderTable

--Total Sales
select cast(sum(sales) as decimal(10,2)) as Totalsales
from OrderTable

--Total Profit
select cast(sum(profit) as decimal(10,2)) as TotalProfit 
from OrderTable

--sales by region

select Region ,cast(sum(sales) as decimal(10,2)) as Totalsales
from OrderTable o
join CustomerTable c
on 
o.Customer_ID = c.Customer_ID
group by region 
order by sum(sales)

--sales by category 

select p.Category ,cast(sum(sales) as decimal(10,2)) as Totalsales
from OrderTable o
join ProductTable p
on 
p.Product_ID = o.Product_ID
group by p.Category
order by sum(sales)

--Profit  by category 

select p.Category ,cast(sum(profit) as decimal(10,2)) as TotalProfit 
from OrderTable o
join ProductTable p
on 
p.Product_ID = o.Product_ID
group by p.Category
order by sum(profit)

--Top 10 Customers

select top 10 c.Customer_name,cast(sum(sales) as decimal(10,2)) as Revenue
from OrderTable o
join CustomerTable c
on 
c.Customer_ID = o.Customer_ID
group by c.Customer_name
order by sum(sales) desc

--Top ten product 

select top 10 c.Customer_name,cast(sum(sales) as decimal(10,2)) as Revenue
from OrderTable o
join CustomerTable c
on 
c.Customer_ID = o.Customer_ID
group by c.Customer_name
order by sum(sales) desc

--Monthly Sales Trend

Select datename(year,Order_Date) as Year  ,  datename(month,Order_Date) as Month,
cast(sum(sales) as decimal(10,2)) as Revenue
from OrderTable
group by datename(year,Order_Date) ,datename(month,Order_Date)
order by Year,Month desc

-- Customer Ranking 
select c.Customer_Name ,cast(sum(sales) as Decimal(10,2)) as Revenue ,
Rank() over  ( order by sum(sales) desc) as Rank
from OrderTable o
join CustomerTable c
on 
c.Customer_ID=o.Customer_ID
group by Customer_Name

--Running Total sales

select order_date ,sales ,sum(sales) 
over ( order by order_date desc) as Running_total
from ordertable
group by order_date,sales

--Most profitable category 

select Top 1 p.category ,sum(profit) as TaotalProfit
from OrderTable o
join ProductTable p
on 
p.Product_ID=o.Product_ID
group by p.category
order by sum(profit) desc

--Customer Lifetime Value

select c.Customer_Name ,Count(o.order_id) as OrderCount,
sum(o.sales) as LifeTimeValue
from OrderTable o
join CustomerTable c
on 
o.Customer_ID = c.Customer_ID
group by c.Customer_Name
Order by sum(o.sales) desc