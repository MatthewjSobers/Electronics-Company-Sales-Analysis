-- Analysis

-- Calculate running total of each customer
SELECT customer_id, purchase_date, total_price,
    SUM(total_price) OVER (PARTITION BY customer_id ORDER BY purchase_date) AS running_total
FROM orders;

-- Calculate running total of all orders
SELECT order_id, purchase_date, total_price,
    SUM(total_price) OVER (ORDER BY purchase_date, order_id) AS running_total
FROM orders;

-- Rank customers by the most spending for a given product type
SELECT product_type, customer_id, total_spending,
    RANK() OVER (PARTITION BY product_type ORDER BY total_spending DESC) AS customer_rank
FROM (
    SELECT p.product_type, o.customer_id, SUM(o.total_price) AS total_spending
    FROM product p
    JOIN orders o
    ON p.product_id = o.product_id
    GROUP BY p.product_type, o.customer_id
) 
ORDER BY product_type, customer_rank;

-- Rank products by average rating
WITH product_orders AS (
    SELECT p.product_type, p.product_id, o.rating
    FROM product p
    JOIN orders o
    ON p.product_id = o.product_id
)
SELECT product_type, product_id,
    RANK() OVER (ORDER BY AVG(rating) DESC) AS product_rank,
    AVG(rating) AS avg_rating
FROM product_orders
GROUP BY product_type, product_id;

-- Determine if gender influences product type preference
WITH order_product AS (
    SELECT c.customer_id, c.gender, o.product_id
    FROM customer c
    JOIN orders o
    ON c.customer_id = o.customer_id
) 
SELECT p.product_type, op.gender, COUNT(p.product_type) AS product_gender_count
FROM order_product op
JOIN product p
ON op.product_id = p.product_id
GROUP BY op.gender, p.product_type
ORDER BY p.product_type;

-- Determine if customers with higher shipping standards rate products higher
SELECT s.shipping_type, AVG(o.rating) AS avg_rating
FROM shipping s
JOIN orders o
ON s.order_id = o.order_id
GROUP BY s.shipping_type;

-- Identify which customer spent the most for each product type
SELECT product_type, customer_id, total_spending
FROM (
    SELECT product_type, customer_id, total_spending,
        ROW_NUMBER() OVER (PARTITION BY product_type ORDER BY total_spending DESC) AS customer_rank
    FROM (
        SELECT p.product_type, o.customer_id, SUM(o.total_price) AS total_spending
        FROM product p
        JOIN orders o
        ON p.product_id = o.product_id
        GROUP BY p.product_type, o.customer_id
    )
)
WHERE customer_rank = 1
ORDER BY product_type;

-- In-depth analysis to answer the business question:

-- Main business question: Which factors most significantly impact sales outcomes,
-- and how do various customer, product, and order characteristics influence sales trends in the electronics store?

-- 1. Are there any seasonal peaks in sales?
WITH date_season_order AS (
    SELECT order_id, purchase_date, total_price,
        CASE
            WHEN EXTRACT(MONTH FROM purchase_date) IN (12,1,2) THEN 'Winter'
            WHEN EXTRACT(MONTH FROM purchase_date) IN (3,4,5) THEN 'Spring'
            WHEN EXTRACT(MONTH FROM purchase_date) IN (6,7,8) THEN 'Summer'
            WHEN EXTRACT(MONTH FROM purchase_date) IN (9,10,11) THEN 'Fall'        
        END AS season
    FROM orders
)
SELECT season, AVG(total_price) AS avg_spent
FROM date_season_order
GROUP BY season
ORDER BY avg_spent;

-- 2. What are the top-selling products?
SELECT p.product_id, p.product_type, SUM(o.total_price) AS total_spent
FROM product p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_type
ORDER BY total_spent DESC;

-- 3. Does gender influence spending habits in terms of amount spent?
SELECT gender, AVG(o.total_price) AS avg_spent, SUM(o.total_price) AS total_spent
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY gender;

-- 4. Which age group spent the most money?
SELECT 
    CASE
        WHEN c.age > 0 AND c.age < 18 THEN 'Young'
        WHEN c.age >= 18 AND c.age < 30 THEN 'Young_Adults'
        WHEN c.age >= 30 AND c.age < 45 THEN 'Adults'
        ELSE 'Senior'
    END AS age_group,
    SUM(o.total_price) AS total_spent
FROM customer c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY 
    CASE
        WHEN c.age > 0 AND c.age < 18 THEN 'Young'
        WHEN c.age >= 18 AND c.age < 30 THEN 'Young_Adults'
        WHEN c.age >= 30 AND c.age < 45 THEN 'Adults'
        ELSE 'Senior'
    END
ORDER BY total_spent;

-- 5. Do loyalty members spend more than non-loyalty members?
SELECT loyalty_member, AVG(total_price) AS avg_total_price, SUM(total_price) AS total, COUNT(*)
FROM orders
GROUP BY loyalty_member;

-- 6. Which product types have the highest rating, and how does it correlate with sales volume?
SELECT p.product_type, SUM(total_price) AS total_sales, AVG(o.rating) AS avg_rating, COUNT(*) AS items_bought
FROM product p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_type
ORDER BY total_sales DESC;

-- 7. Does unit price affect the number of items sold?
SELECT p.product_type, p.product_id, p.unit_price, SUM(o.quantity) AS units_sold
FROM product p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_type, p.product_id, p.unit_price
ORDER BY units_sold DESC;

-- 8. How do sales vary by product type?
SELECT p.product_type, SUM(o.total_price) AS total_spent,
    AVG(total_price) AS avg_price, COUNT(*) AS number_of_orders
FROM orders o
JOIN product p
ON o.product_id = p.product_id
GROUP BY p.product_type
ORDER BY total_spent DESC;

-- 9. What are the most used payment methods, and how much was spent?
SELECT payment_method, COUNT(payment_method) AS method_count, AVG(total_price), SUM(total_price)
FROM orders
GROUP BY payment_method
ORDER BY method_count DESC;

-- 10. What is the average rating for customers who purchased add-ons versus those who didn't?
-- Does the presence of add-ons affect sales?
SELECT add_ons_purchased, AVG(rating) AS avg_rating, SUM(total_price) AS sales
FROM (
    SELECT o.order_id, o.rating, o.total_price,
        CASE
            WHEN a.add_ons_purchased = 'None' THEN 'No'
            ELSE 'Yes'
        END AS add_ons_purchased
    FROM orders o
    LEFT JOIN add_ons a
    ON o.order_id = a.order_id
)
GROUP BY add_ons_purchased;

