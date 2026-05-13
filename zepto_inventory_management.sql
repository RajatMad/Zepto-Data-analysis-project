CREATE DATABASE ZEPTO;

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

-- Data Exploration
SELECT count(*) FROM zepto;

-- sample data 
SELECT * FROM zepto
LIMIT 10;

-- NULL VALUES
 SELECT * FROM zepto 
 WHERE 
 Category IS NULL
 or name IS NULL
 or mrp IS NULL
 or discountPercent IS NULL
 or availableQuantity IS NULL
 or discountedSellingPrice IS NULL
 or weightInGms IS NULL
 or outOfStock IS NULL
 or quantity IS NULL;
 
 -- different product category
 SELECT DISTINCT Category FROM zepto;
 
 -- product in stock or out of stock 
 SELECT outOfStock ,count(ID) FROM zepto
 GROUP BY outOfStock;
 
 -- product names present multiple times 
 SELECT name,count(ID) FROM zepto
GROUP BY name
HAVING count(ID) >1;

-- data cleaning 
SELECT * FROM zepto
WHERE mrp=0 or discountedSellingPrice=0;

delete from zepto
WHERE mrp=0 and ID>0;

-- convert paise to rupees
UPDATE zepto
SET mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0
WHERE ID>0;
 
 -- Find top 10 bast value products based on discount percentage
 SELECT DISTINCT name, mrp,discountPercent FROM zepto
 ORDER BY discountPercent DESC
 LIMIT 10;
 
 -- What are the products with high mrp but out of stock 
 SELECT DISTINCT name,mrp,outOfStock FROM zepto
 WHERE outOfStock=OutOfStock
 ORDER BY mrp DESC LIMIT 1;
 
 -- Calculate revenue for each category
 SELECT Category,SUM(discountedSellingPrice * availableQuantity) AS total_revenue FROM zepto
 GROUP BY Category
 ORDER BY total_revenue DESC;
 
 -- Find all products where mrp is greater than 500 and discount is less than 10%
 SELECT name,mrp,discountPercent FROM zepto
 WHERE mrp>500 and discountPercent<10
 ORDER BY mrp DESC,discountPercent DESC;
 
 -- Identify top 5 categories offering highest average discount 
 SELECT Category , AVG(discountPercent) AS avg_discount FROM zepto
 GROUP BY Category
 ORDER BY avg_discount DESC
 LIMIT 5;
 
 -- Find price per gram for product above 100g and sort by best valuee
 SELECT DISTINCT name, weightINGms, discountedSellingPrice, 
 discountedSellingPrice/weightInGms AS price_per_grams 
 FROM zepto
 WHERE weightInGms>100
 ORDER BY price_per_grams;
 
 -- Group product based on their weight
 SELECT DISTINCT name, weightINGms,
 CASE WHEN weightInGms<1000 THEN 'LOW'
	  WHEN weightInGms<5000 THEN 'Medium'
      ELSE 'Bulk'
      END as weight_category
From zepto;

-- what is total inventory weight per category
SELECT Category, SUM(weightInGms*availableQuantity) AS total_weight FROM zepto
GROUP BY Category
ORDER BY total_weight;
