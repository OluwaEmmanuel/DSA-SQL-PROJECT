SELECT * from [dbo].[Kultra_MS]

-----QUESTION O1 PRODUCT CATEGORY HIGHEST SALES-------
SELECT TOP 1 Product_Category,
	SUM(Sales) AS TotalSales
FROM [dbo].[Kultra_MS]
GROUP BY Product_Category
ORDER BY TotalSales DESC;

-----QUESTION 02 TOP 3 AND BOTTOM 3 REGIONS IN TERMS OF SALES------
SELECT TOP 3 Region,
	sum(Sales) AS TotalSales, 'Top 3' AS Category
FROM [dbo].[Kultra_MS]
GROUP BY Region
ORDER BY TotalSales Desc

SELECT TOP 3 Region,
	sum(Sales) AS TotalSales, 'Bottom 3' AS Category
FROM [dbo].[Kultra_MS]
GROUP BY Region
ORDER BY TotalSales Asc;

WITH TOP3 AS (SELECT TOP 3 * FROM [dbo].[Kultra_MS]
	SUM(Sales) AS Totalsales
GROUP BY Region
ORDER BY TotalSales),
BOTTOM3 AS (SELECT TOP 3 * FROM [dbo].[Kultra_MS]
	SUM(Sales) AS TotalSales
GROUP BY Region
ORDER BY TotalSales Desc)
SELECT * FROM TOP3
UNION ALL
SELECT * FROM BOTTOM3;

-------QUESTION 03 TOTAL SALES OF APPLAINCES IN ONTARIO---------
SELECT 
	SUM(Sales) AS TotalSales
FROM [dbo].[Kultra_MS]
WHERE Product_Sub_Category = 'Appliances' AND Province = 'Ontario';

-------QUESTION 04 BOTTOM 10 CUSTOMERS-------
SELECT TOP 10
	Customer_Name AS CustomerName, 
	SUM(Sales) AS TotalSales,
	COUNT(DISTINCT[Order_ID]) AS OrderID,
	AVG(Sales) AS Avgordervalue
FROM [dbo].[Kultra_MS]
GROUP BY Customer_Name
ORDER BY TotalSales ASC;

WITH CustomerTotals AS (
    SELECT 
        Customer_Name AS CustomerName,
        SUM(Sales) AS TotalSales
    FROM 
        [dbo].[Kultra_MS]
    GROUP BY 
        Customer_Name
),
Bottom10 AS (
    SELECT TOP 10 *
    FROM CustomerTotals
    ORDER BY TotalSales ASC
)
SELECT 
    b.CustomerName,
    MAX(k.Region) AS Region,
    MAX(k.Province) AS Province,
    b.TotalSales,
    COUNT(DISTINCT k.Order_ID) AS TotalOrders,
    AVG(k.Sales) AS AvgOrderValue
FROM 
    Bottom10 b
JOIN 
   [dbo].[Kultra_MS] k ON k.Customer_Name = b.CustomerName
GROUP BY 
    b.CustomerName, b.TotalSales;

SELECT 
    k.Customer_Name AS CustomerName,
    MAX(k.Region) AS Region,
    MAX(k.Province) AS Province,
    SUM(k.Sales) AS TotalSales,
    COUNT(DISTINCT k.Order_ID) AS TotalOrders,
    AVG(k.Sales) AS AvgOrderValue
FROM 
   [dbo].[Kultra_MS] k
GROUP BY 
    k.Customer_Name
HAVING 
    SUM(k.Sales) IN (
        SELECT TOP 10 SUM(Sales)
        FROM [dbo].[Kultra_MS]
        GROUP BY Customer_Name
        ORDER BY SUM(Sales) ASC
    )
ORDER BY 
    TotalSales ASC;

----------QUESTION 05 HIGHEST SHIPPING METHOD--------
SELECT Ship_Mode AS Shippingmethod,
SUM(Shipping_Cost) AS TotalShippingCost
FROM [dbo].[Kultra_MS]
GROUP BY Ship_Mode
ORDER BY TotalShippingCost Desc;

---ANSWER IS THE DELIVERY TRUCK WHICH IS COST 51971.94---------


-----QUESTION 06 MOST VALUABLE CUSTOMERS, AND THE PRODUCTS OR SERVICE THEY TYPICALLY PURCHASE------
SELECT TOP 10
	Customer_Name AS CustomerName,
	SUM(Sales) AS TotalSales,
	COUNT(DISTINCT [Order_ID]) AS TotalOrders,
	AVG(Sales) as AvgOrderValue
FROM [dbo].[Kultra_MS]
GROUP BY Customer_Name
ORDER BY TotalSales Desc;

SELECT 
    k.Customer_Name,
    k.Product_Name,
    k.Product_Category,
	Region,
    COUNT(*) AS TimesPurchased,
    SUM(k.Sales) AS TotalSpent
FROM 
    [dbo].[Kultra_MS] k
WHERE 
    k.Customer_Name IN (
        SELECT TOP 10 Customer_Name
        FROM [dbo].[Kultra_MS]
        GROUP BY Customer_Name
        ORDER BY SUM(Sales) DESC
    )
GROUP BY 
    k.Customer_Name, k.Product_Name, k.Product_Category, k.region
ORDER BY 
    k.Customer_Name, TotalSpent DESC;

---------QUESTION 07 HIGHEST SALES OF SMALL BUSINESS CUSTOMER--------
SELECT TOP 3 Customer_Name AS CustomerName,
	SUM(Sales) AS TotalSales
FROM [dbo].[Kultra_MS]
WHERE Customer_Segment = 'Small business'
GROUP BY Customer_Name
ORDER BY TotalSales DESC;

-------QUESTION 08 MOST NUMBER OF ORDERS MADE BY CORPORATE COMPANIES BETWEEN 2009-2012-------
SELECT TOP 3 Customer_Name AS CustomerName,
	COUNT(DISTINCT[Order_ID]) AS TotalOrders,
	SUM(Sales) AS TotalSales
FROM [dbo].[Kultra_MS]
WHERE Customer_Segment = 'Corporate' AND YEAR(Order_Date) BETWEEN 2009 AND 2012
GROUP BY Customer_Name
ORDER BY TotalOrders DESC;

------QUESTION 09 MOST PROFITABLE CONSUMER CUSTOMER--------
SELECT TOP 3 Customer_Name AS CustomerName,
	SUM(Profit) AS Totalprofit
FROM [dbo].[Kultra_MS]
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Totalprofit DESC;


------QUESTION 10 CUSTOMER RETURNED ITEMS AND SEGMENT------
ALTER TABLE [dbo].[Kultra_MS]
ADD Returned_Item VARCHAR(10);

UPDATE [dbo].[Kultra_MS]
SET Returned_Item = 'None';


SELECT 
    Customer_Name,
    Customer_Segment,
    COUNT(*) AS TotalReturns
FROM 
	[dbo].[Kultra_MS]
WHERE 
    Returned_Item = 'Yes'
GROUP BY 
    Customer_Name, Customer_Segment
ORDER BY 
    TotalReturns DESC;


-----QUESTION 11------

SELECT TOP 5 *
FROM [dbo].[Kultra_MS];
