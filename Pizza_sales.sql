select * from pizza_sales;

/*Total Revenue*/
select SUM(total_price) as Total_Revenue from pizza_sales;

/*Average Order Value*/
select SUM(total_price) / COUNT(DISTINCT order_id) as Average_Order_Value from pizza_sales;

/*Total Pizzas Sold*/
select SUM(quantity) as Total_Pizza_Sold from pizza_sales;

/*Total_Orders*/
select COUNT(DISTINCT order_id) as Total_Orders from pizza_sales;

/*Average Pizzas per Order*/
select CAST(CAST(SUM(quantity) as decimal(10,2)) / CAST(COUNT(DISTINCT order_id) as decimal(10,2)) as decimal(10,2)) as Average_Pizzas_Per_Order from pizza_sales;

/***CHARTS REQUIREMENT***/
/*Daily Trend for Total Orders*/
select DATENAME(DW, order_date) as Order_Day, COUNT(DISTINCT order_id) as Total_Order
from pizza_sales
GROUP BY DATENAME(DW, order_date);

/*Monthly Trend for Total Orders*/
select DATENAME(MONTH, order_date) as Order_Month, COUNT(DISTINCT order_id) as Total_Order
from pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Order DESC;

/*Percentage of Sales by pizza Category*/
select pizza_category, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales
WHERE MONTH(order_date) = 4) as Percentage_of_sale_by_Category from pizza_sales
WHERE MONTH(order_date) = 4  /*For Month of APRIL*/
GROUP BY pizza_category;

/*Percentage of Sales by Pizza Size*/
select pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) as Total_Sales, 
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales 
WHERE DATEPART(quarter, order_date) = 4 ) AS DECIMAL(10,2)) as Percentage_of_sale_by_Category from pizza_sales
WHERE DATEPART(quarter, order_date) = 4  
GROUP BY pizza_size
ORDER BY  Percentage_of_sale_by_Category DESC;

/*Top 5 Best Sellers by Revenue, Total Quantity and Total Orders*/
SElECT TOP 5 pizza_name, SUM(total_price) as Total_Revenue, SUM(quantity) as Total_Quantity, COUNT(DISTINCT order_id) as Total_Order
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue DESC, Total_Quantity DESC, Total_Order DESC;


/*Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders*/
SElECT TOP 5 pizza_name, SUM(total_price) as Total_Revenue, SUM(quantity) as Total_Quantity, COUNT(DISTINCT order_id) as Total_Order
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY Total_Revenue ASC, Total_Quantity ASC, Total_Order ASC;