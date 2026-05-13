# Zepto-Data-analysis-project
This project demonstrates end-to-end SQL-based data analysis on an e-commerce dataset (Zepto). It covers database creation, data exploration, cleaning, and business insights generation. The goal is to showcase strong SQL skills and analytical thinking for real-world scenarios.

The dataset contains information about products such as:
- Product name
- Category
- MRP(Maximum Retail Price)
- Discount percentage
- Available quantity
- Selling price
- Weight
- Stock status

### Database & Table Creation
```sql
CREATE DATABASE ZEPTO;
```
Creates a new database named ZEPTO for storing all product-related data.
```sql
  CREATE TABLE zepto (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Category VARCHAR(120),
  name VARCHAR(120),
  mrp NUMERIC(8,2),
  discountPercent INT,
  availableQuantity INT,
  discountedSellingPrice NUMERIC(8,2),
  weightInGms INT,
  outOfStock VARCHAR(20),
  quantity INT
)
```
Defines the main table structure with appropriate data types.


##  Data Exploration

#### Total Records
```sql
SELECT count(*) FROM zepto;
```
Counts total number of records in the dataset.

#### Sample Data Preview
```sql
SELECT * FROM zepto LIMIT 10;
```
Displays first 10 rows to understand structure and values.

#### Checking NULL Values
```sql
SELECT * FROM zepto 
WHERE Category IS NULL
OR name IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR availableQuantity IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;
```
Identifies missing data across all columns.

#### Unique Categories
```sql
SELECT DISTINCT Category FROM zepto;
```
Lists different product categories.

#### Stock Status Distribution
```sql
SELECT outOfStock, count(ID) FROM zepto GROUP BY outOfStock;
```
Shows how many items are in stock vs out of stock.
#### Duplicate Product Names
```sql
SELECT name, count(ID) FROM zepto
GROUP BY name
HAVING count(ID) > 1;
```
Identifies duplicate product entries.


## Data Cleaning
#### Detect Incorrect Pricing
```sql
SELECT * FROM zepto WHERE mrp = 0 OR discountedSellingPrice = 0;
```
Finds invalid price records.
#### Remove Invalid Data
```sql
DELETE FROM zepto WHERE mrp = 0 AND ID > 0;
```
Deletes incorrect entries.
Note: ID > 0 ensures safe deletion.

#### Convert Paise to Rupees
```sql
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0
WHERE ID > 0;
```
Converts values into readable currency format.


##  Business Insights
####  Top 10 Best Discounted Products
```sql
SELECT DISTINCT name, mrp, discountPercent FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```
Identifies products offering highest discounts.


####  High MRP but Out of Stock
```sql
SELECT DISTINCT name, mrp, outOfStock FROM zepto
WHERE outOfStock = 'TRUE'
ORDER BY mrp DESC LIMIT 1;
```
Shows premium products currently unavailable.


####  Revenue by Category
```sql
SELECT Category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY Category
ORDER BY total_revenue DESC;
```
Calculates total revenue contribution per category.



####  Premium Products with Low Discount
```sql
SELECT name, mrp, discountPercent FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;
```
Finds expensive products with minimal discount.


####  Top Discount Categories
```sql
SELECT Category, AVG(discountPercent) AS avg_discount
FROM zepto
GROUP BY Category
ORDER BY avg_discount DESC
LIMIT 5;
```
Highlights categories offering best deals.


####  Best Value Products (Price per Gram)
```sql
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
discountedSellingPrice / weightInGms AS price_per_grams
FROM zepto
WHERE weightInGms > 100
ORDER BY price_per_grams;
```
Finds cost-efficient products.


####  Weight-Based Categorization
```sql
SELECT DISTINCT name, weightInGms,
CASE
WHEN weightInGms < 1000 THEN 'LOW'
WHEN weightInGms < 5000 THEN 'MEDIUM'
ELSE 'BULK'
END AS weight_category
FROM zepto;
```
Classifies products by weight.


####  Inventory Weight by Category
```sql
SELECT Category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY Category
ORDER BY total_weight;
```
Measures inventory distribution.

##  Findings & Insights Report
Based on the SQL analysis performed on the Zepto dataset, the following key insights were identified:

- High Discount Products Drive Visibility :Products with higher discount percentages tend to appear prominently, helping attract customers.
- Revenue Concentration by Category: A few categories contribute significantly to total revenue, indicating strong demand concentration.
- Premium Products Often Under-Discounted: High MRP products typically have lower discounts, suggesting premium positioning.
- Stock Availability Issues: Some high-value products are out of stock, which may result in missed revenue opportunities.
- Best Value Products Identified: Price-per-gram analysis revealed products that offer better value for money, useful for pricing strategies.
- Inventory Imbalance: Certain categories hold higher inventory weight, indicating potential overstock or demand mismatch.


##  Conclusion
This project demonstrates how SQL can be effectively used to transform raw data into meaningful business insights. Through structured querying and analysis:

- Data quality issues were identified and resolved.
- Actionable insights were generated for pricing, inventory, and sales.
- Business decisions can be driven using data-backed evidence.

Overall, the analysis highlights the importance of data-driven decision making in e-commerce platforms like Zepto. This project showcases not only technical SQL skills but also the ability to interpret data and derive strategic insights.


### Author
Rajat Prakash Madyapgol




