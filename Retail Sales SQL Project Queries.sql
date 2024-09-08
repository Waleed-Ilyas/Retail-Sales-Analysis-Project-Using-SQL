-- Create Table

Create Table Retail_Sales(
transactions_id INT Primary Key,
sale_date Date,
sale_time Time,
customer_id Int,
gender Varchar(15),
age Int,
category varchar(15),
quantiy Int,
price_per_unit Float,
cogs Float,
total_sale Float
);

Select * from Retail_Sales;

Select count(*) from retail_sales;

Select * from retail_sales where transactions_id is null

Select * from retail_sales where sale_date is null

Select * from retail_sales where sale_time is null

-- Data Cleaning

Select * from retail_sales 
where
transactions_id is null
OR
sale_date is null
OR 
sale_time is null
OR 
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR 
price_per_unit is null
OR
cogs is null
OR 
total_sale is null;


Delete from retail_sales
where
transactions_id is null
OR
sale_date is null
OR 
sale_time is null
OR 
customer_id is null
OR
gender is null
OR
age is null
OR
category is null
OR
quantiy is null
OR 
price_per_unit is null
OR
cogs is null
OR 
total_sale is null;

-- Data Exploration

-- How many Sales we have?

Select COUNT(*) AS Total_Sale FROM Retail_Sales;
	
-- How many Unique Customers we have?

Select COUNT(DISTINCT customer_id) AS Total_Customers FROM Retail_Sales;

-- How many Categories we have?

Select DISTINCT category FROM retail_sales;

-- Data Analysis & Business Key Problems 

-- Q # 1: Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

Select * from retail_sales
where sale_date = '2022-11-05';

-- Q # 2: Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

Select * from retail_sales
where 
category = 'Clothing'
AND 
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND
quantiy > 3;

-- Q # 3: Write a SQL query to calculate the total sales (total_sale) for each category

Select category,
SUM(total_sale) as Net_Sale,
Count(*) as Total_Orders
From retail_sales
Group by 1;

-- Q # 4: Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

Select
Round(AVG(age),2) as AVG_Age
from retail_sales
where category = 'Beauty';

-- Q # 5: Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select * from retail_sales
where total_sale > 1000;

-- Q # 6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

Select category, gender,
Count(*) as Total_Trans
From retail_sales
Group By
category, gender
Order by 1

-- Q # 7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

Select year, month, avg_sale
FROM(
Select
EXTRACT(YEAR from sale_date) as year,
EXTRACT(MONTH from sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER(PARTITION BY EXTRACT(YEAR from sale_date) Order BY AVG(total_sale) DESC ) as Rank
from retail_sales
Group By 1,2
) as t1
where rank = 1

-- Q # 8: Write a SQL query to find the top 5 customers based on the highest total sales

Select customer_id,
SUM (total_sale) as Total_Sale
from retail_sales
group by customer_id
Order by total_sale DESC
Limit 5

-- Q # 9: Write a SQL query to find the number of unique customers who purchased items from each category

Select category,
COUNT(DISTINCT customer_id) as cnt_unique_cs
From retail_sales
Group BY category;

-- Q # 10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

With hourly_sale
As
(Select *,
case 
	WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'MORNING'
	WHEN EXTRACT (HOUR From sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	ELSE 'Evening'
	END as Shift
From retail_sales
)
Select Shift,
COUNT(*) as total_orders
From hourly_sale
Group By Shift

