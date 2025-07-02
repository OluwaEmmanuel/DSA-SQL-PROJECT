# DSA-SQL-PROJECT
## Project Description:
This project aims to explore and analyze the Kultra Mega Stores (KMS) sales dataset using SQL to derive insights into customer behavior, sales performance, product categories, shipping efficiency, and profitability. By performing structured queries on a cleaned dataset, the aim is to generate actionable recommendations to help KMS increase revenue, reduce shipping inefficiencies, and retain valuable customers.

## 🎯 Objectives:
  - Identify the most and least profitable customers
  - Analyze regional and product category performance
  - Evaluate shipping costs in relation to order priority
  - Understand purchasing behaviors across customer segments
  - Provide business recommendations based on analysis

## 🧰 Tools & Technologies:
  - SQL Server;
    - querying and data analysis
  - GitHub
    - project documentation
  - CSV dataset for structured input

## 🧮 Key SQL Analyses Performed:
  - **Customer Profitability**
    - Top 3 and bottom 3 customers by total sales and Profit
   ``` SQL
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

SELECT TOP 3 Customer_Name AS CustomerName,
	SUM(Profit) AS Totalprofit
FROM [dbo].[Kultra_MS]
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Totalprofit DESC;
```

  - **Shipping Cost Efficiency**
    - Total shipping cost by shipping mode
   ```SQL
SELECT Ship_Mode AS Shippingmethod,
SUM(Shipping_Cost) AS TotalShippingCost
FROM [dbo].[Kultra_MS]
GROUP BY Ship_Mode
ORDER BY TotalShippingCost Desc;
```

  - **Sales Performance**
    - Sales and profit by product category and Region
   ```SQL
SELECT TOP 1 
    Region,
    YEAR(Order_Date) AS OrderYear,
    Product_Category,
    SUM(Sales) AS TotalSales
FROM 
    [dbo].[Kultra_MS]
GROUP BY 
    [Region],
    YEAR(Order_Date),
    Product_Category
ORDER BY 
    [Region], 
    OrderYear, 
    TotalSales DESC;
```
  - Total Sales of Appliances in Ontario
```SQL
SELECT 
	SUM(Sales) AS TotalSales
FROM [dbo].[Kultra_MS]
WHERE Product_Sub_Category = 'Appliances' AND Province = 'Ontario';
```

## ✅ Key Insights:
- Ontario leads in sales volume but not in profitability.
- Corporate customers generate higher sales, but Consumer customers are more profitable.
- Delivery Truck is cost-effective but underused for low-priority orders.
- Simulated returns show small businesses have slightly higher return rates.
