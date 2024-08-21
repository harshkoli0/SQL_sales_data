create database sales;
use sales;

create table sales_data (
transactions_id int primary key ,
	sale_date	date ,
    sale_time	time,
    customer_id	int,
    gender	varchar (15),
    age int,
	category varchar(20),
    quantiy	int,
    price_per_unit float,
	cogs	float,
    total_sale float
);
select  *from  sales_data ;
-- data cleaning 

select * from sales_data where
transactions_id is null
or
	sale_date	is null
    or
    sale_time	is null
    or
    customer_id	is null
    or
    gender	is null
    or
	category is null
    or
	quantiy is null	
    or
    price_per_unit is null
    or
	cogs is null
    or
	total_sale is null;
    
-- data exploration
-- how many sales we have?
select count(*) from sales_data;

-- how many unique customer we have?

select count(distinct customer_id) from sales_data;

select distinct (category) from sales_data;

-- data analysis problem 

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select*from sales_data where sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from sales_data where category = 'Clothing'  and TO_CHAR (sale_date ,"yyyy-mm") = 2022-11  ;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category , sum(total_sale) as netsale , count(*) from sales_data group by category ;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category , round (avg(age),2) from sales_data where category = 'Beauty'  group by category ;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from sales_data where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender, count(*) from sales_data group by category,gender
order by category ;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year(sale_date) as year , month(sale_date) as month , round(avg(total_sale),2) from sales_data group by year,month
order by  year ;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id , sum(total_sale) from sales_data  group by       customer_id   order by customer_id desc limit 5 ;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count( distinct customer_id) from  sales_data group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale
as(
select*,
case 
when hour(sale_time) < 12 then "morning"
when hour(sale_time) between 12 and 17 then "afternoon"
else "evening"
end as shift
from sales_data
)
select shift ,count(*)from  hourly_sale
group by  shift;



