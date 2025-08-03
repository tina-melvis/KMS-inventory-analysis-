CREATE DATABASE kms_inventory;
USE kms_inventory;


--CREATING THE ORDERS TABLE
CREATE TABLE Orders(
Row_ID INT,	
Order_ID INT,	
Order_Date	DATE,
Order_Priority VARCHAR(50),
Order_Quantity	INT,
Sales DECIMAL(12,2),
Discount DECIMAL(5,2),
Ship_Mode VARCHAR(50),
Profit DECIMAL(12,2),
Unit_Price DECIMAL(12,2),	
Shipping_Cost DECIMAL(12,2),	
Customer_Name VARCHAR(100),
Province VARCHAR(50),
Region VARCHAR(50),
Customer_Segment VARCHAR(50),
Product_Category VARCHAR(50),
Product_SubCategory VARCHAR(50),
Product_Name VARCHAR(200),
Product_Container VARCHAR(50),
Product_Base_Margin	DECIMAL(12,2),
Ship_Date DATE
);

SELECT * FROM Orders;

--Inserting the Dataset
BULK INSERT Orders
FROM 'C:\Users\dell\Documents\Data analysis files\DSA FILES\KMS Sql Case Study.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR ='\n'
);
 
 --Checking for duplicates
 SELECT Row_ID,
 COUNT(*) AS Count
 FROM Orders
 GROUP BY Row_ID
 HAVING COUNT(*) > 1   -- NO Duplicates Found

 
 --Checking for Nulls in some key columns
 SELECT
      SUM (CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END) AS MissingOrderID,
      SUM (CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS MissingSales,
      SUM (CASE WHEN Product_Base_Margin IS NULL THEN 1 ELSE 0 END) AS MissingBaseMargin
 FROM Orders;
 --63 Nulls was foumd in Product Base Margin column


 --Replacing Null in Product Base Margin Column
 --using the average by Product Category

 --First Calculating the Average
 WITH CategoryAverages AS(
     SELECT Product_Category, AVG(Product_Base_Margin) AS Avg_Margin 
	 FROM Orders
	 WHERE Product_Base_Margin IS NOT NULL
	 GROUP BY Product_Category
)
--Then Updating the NULLS 
UPDATE Orders
SET Product_Base_Margin = CA.Avg_Margin
FROM Orders O
JOIN CategoryAverages CA
    ON O.Product_Category =CA.Product_Category
WHERE O.Product_Base_Margin IS NULL;



