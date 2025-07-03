# DSA-SQL-PROJECT
## Project Description:
This project aims to explore and analyze the Kultra Mega Stores (KMS) sales dataset using SQL to derive insights into customer behavior, sales performance, product categories, shipping efficiency, and profitability. By performing structured queries on a cleaned dataset, the aim is to generate actionable recommendations to help KMS increase revenue, reduce shipping inefficiencies, and retain valuable customers.

## 🎯 Objectives:
  - Identify the most and least profitable customers
  - Analyze regional and product category performance
  - Evaluate shipping costs in relation to order priority
  - Understand purchasing behaviors across customer segments
  - Provide business recommendations based on analysis

## 📊 Dataset
The dataset used for this project is a cleaned version of the Kultra Mega Stores (KMS) Sales dataset. It includes transactional data such as:

- Customer Name, Segment, and Region
- Product Category and Subcategory
- Order Date and Ship Date
- Sales, Quantity, Discount, and Profit
- Shipping Method and Cost

The data spans from the years 2009 to 2012.

## ⚙️ Methodology
The analysis followed these major steps:
1. **Data Importation**:
   - Loaded the CSV into SQL Server and created a base table named `Kultra_MS`.

3. **Data Preparation**:
   - Added a simulated column for product returns (`Returned_Item`)
   - Ensured data types and formats were consistent

4. **Exploratory SQL Analysis**:
   - Identified top and bottom customers by sales and profit
   - Analyzed sales performance by region and product category
   - Evaluated shipping method usage relative to order priority
   - Shipping cost by ship mode
   - Top sales of Appliances in Ontario

5. **Query Organization**:
   - Saved reusable SQL scripts for clarity and documentation.

6. **Business Recommendations**:
   - Based on data insights, strategic suggestions were provided

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
	SUM(Sales) AS TotalSales, 'Top 3' AS Category
FROM [dbo].[Kultra_MS]
GROUP BY Region
ORDER BY TotalSales Desc

SELECT TOP 3 Region,
	SUM(Sales) AS TotalSales, 'Bottom 3' AS Category
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
    
``` 	SQL
SELECT Ship_Mode AS Shippingmethod,
	SUM(Shipping_Cost) AS TotalShippingCost
FROM [dbo].[Kultra_MS]
GROUP BY Ship_Mode
ORDER BY TotalShippingCost Desc;

```

  - Shipping method vs. order priority
``` 	SQL
SELECT
    Order_Priority,
    Ship_Mode,
    COUNT(*) AS NumOrders,
    SUM(Shipping_Cost) AS TotalShippingCost
FROM
    [dbo].[Kultra_MS]
GROUP BY
    Order_Priority,
    Ship_Mode
ORDER BY
    Order_Priority,
    Ship_Mode;

```

  - **Sales Performance**
    - Sales and profit by product category and Region
``` SQL
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
``` SQL
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

## ✅ Strategic Recommendations for KMS
 - Offer loyalty incentives and upselling promotions to bottom 10 customers.
 - Optimize use of shipping methods based on order priority.
 - Evaluate product pricing and promotional strategies for low-margin categories.
 - Track and reduce product returns by identifying high-return items and customers.

## ⚠️ Limitations
- The returns column was simulated due to lack of real return data.
- Dataset covers only 2009–2012 and may not reflect current trends.

## 📚 Next Steps:
- Use BI tools like Power BI or Tableau to visualize findings.
- Link CRM data to evaluate customer real-time value.
