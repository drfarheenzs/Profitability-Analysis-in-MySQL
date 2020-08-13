use market_star_schema2;

/* PROBLEM STATEMENT-
Growth team wants to understand sustainable (profitable) product categories.*/

/* METRICS-
1. Profits per product category.
2. Profits per product sub category.
3. Average profit per order.
4. Average profit percentage per order.*/

/* TABLES USED-
1. market_fact_full
2. prod_dimen
3. orders_dimen*/

-- The first metric result which is profits per product category.
SELECT p.Product_Category,
		SUM(m.Profit) as Profits
FROM 
	market_fact_full m
INNER JOIN
	prod_dimen p
ON m.prod_id = p.prod_id
GROUP BY p.Product_Category
ORDER BY SUM(m.Profit);

-- Second metric result for profit per product sub category.
SELECT p.Product_Category, p.Product_Sub_Category,
		SUM(m.Profit) as Profits
FROM 
	market_fact_full m
INNER JOIN
	prod_dimen p
ON m.prod_id = p.prod_id
GROUP BY p.Product_Category, p.Product_Sub_Category
ORDER BY SUM(m.Profit);

-- Third metric Average profit per order.
-- Exploring order table.
SELECT ord_id, Order_Number
FROM orders_dimen
GROUP BY ord_id, Order_Number
ORDER BY ord_id, Order_Number;

SELECT COUNT(*) AS rec_count,
	COUNT(DISTINCT Ord_id) AS order_id_count,
	COUNT(DISTINCT order_number) AS order_number_count
FROM orders_dimen;

-- Checking the order Id which have more than 1 record.
SELECT Order_Number,
	COUNT(Ord_id) AS order_count
FROM orders_dimen
GROUP BY Order_Number
HAVING COUNT(Ord_id) > 1;

SELECT * 
FROM orders_dimen
WHERE Order_Number IN
(SELECT Order_Number
FROM orders_dimen
GROUP BY Order_Number
HAVING COUNT(Ord_id) > 1
);