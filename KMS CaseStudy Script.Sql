--CASE SCENERIO 1

-- 1.Which product Category has the highest sales?
SELECT
     Product_Category,
     SUM(Sales) AS totalsales
FROM Orders
GROUP BY Product_Category
ORDER BY totalsales DESC;

-- 2. What are the top 3 and bottom 3 regions in terms of sale?
-- Top 3
SELECT TOP 3 
    Region, 
    SUM(Sales) AS total_sales
FROM Orders
GROUP BY Region
ORDER BY total_sales DESC;

-- Bottom 3
SELECT TOP 3 
    Region, 
    SUM(Sales) AS total_sales
FROM Orders
GROUP BY Region
ORDER BY total_sales ASC;

-- 3. What were the total sales of appliances in Ontario?
SELECT 
	Product_SubCategory,
	Region,
    SUM(Sales) AS total_sales
FROM Orders
WHERE 
    Region = 'Ontario' AND 
    Product_SubCategory = 'Appliances'
GROUP BY Region,Product_SubCategory;

-- 4. Advise the management of KMS on what to do to increase the revenue from 
--the bottom 10 customers
SELECT TOP 10 
    Customer_Name,
    SUM(sales) AS total_sales
FROM Orders
GROUP BY customer_name
ORDER BY total_sales ASC;


--AnalysE the bottom 10 customer details and orders to know what actions to take



--CASE SCENERIO 2
-- 5. KMS incured the most shipping cost using which shipping method
SELECT 
    Ship_Mode, 
    SUM(Shipping_Cost) AS total_shipping_cost
FROM Orders
GROUP BY Ship_Mode
ORDER BY total_shipping_cost DESC;

--6. Who are the most valuabe customers and what products do they typically purchased
--Top 5 Customers by Sales
WITH ValuableCustomers AS(
SELECT TOP 5 
    Customer_Name,
    SUM(Sales) AS total_sales
FROM Orders
GROUP BY Customer_Name
ORDER BY total_sales DESC
)
--Joining to get the Products Purchased
SELECT
    O.Customer_Name,
	O.Product_Name,
	O.Sales
FROM Orders O
JOIN ValuableCustomers VC
ON O.Customer_Name =VC.Customer_Name
ORDER BY VC.total_sales DESC, O.Customer_Name, O.Sales DESC;


-- 7.Which small business customer had the highest sales
SELECT TOP 1 
    customer_name, 
    SUM(sales) AS total_sales
FROM Orders
WHERE Customer_Segment = 'Small Business'
GROUP BY customer_name
ORDER BY total_sales DESC;

-- 8.Which coperate business customer placed the most number of orders in 2009-2012
SELECT TOP 1 
    customer_name, 
    SUM(Order_Quantity) AS total_orders
FROM Orders
WHERE Customer_Segment = 'Corporate'
  AND YEAR(order_date) BETWEEN 2009 AND 2012
GROUP BY customer_name
ORDER BY total_orders DESC;

-- 9. Which consumer customer was the most profitable one
SELECT TOP 1 
    customer_name, 
    SUM(profit) AS total_profit
FROM Orders
WHERE Customer_Segment = 'Consumer'
GROUP BY customer_name
ORDER BY total_profit DESC;


--11.Did shipping method match the Order Priority? 
SELECT 
    order_priority, 
    ship_mode, 
    SUM(shipping_cost) AS total_shipping_cost,
	SUM(Order_Quantity) AS total_orders
FROM Orders
GROUP BY order_priority, ship_mode
ORDER BY order_priority, ship_mode;
