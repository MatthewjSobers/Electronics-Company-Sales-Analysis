-- Data Cleaning

-- Display all records
SELECT *
FROM staging_table;

-- Verify if there are any entries with a gender that is neither 'Female' nor 'Male'
SELECT gender, COUNT(gender) AS gender_count
FROM staging_table
WHERE gender <> 'Female' AND gender <> 'Male'
GROUP BY gender;

-- Delete those entries
DELETE FROM staging_table
WHERE gender <> 'Female' AND gender <> 'Male';

-- Check for unexpected results in the loyalty_member field
SELECT loyalty_member, COUNT(loyalty_member) AS loyalty_member_count
FROM staging_table
WHERE loyalty_member <> 'Yes' AND loyalty_member <> 'No'
GROUP BY loyalty_member;

-- Check for unexpected results in product_type and payment_method fields
SELECT DISTINCT product_type, payment_method
FROM staging_table;

-- Check for unexpected results in order_status and shipping_type fields
SELECT DISTINCT order_status, shipping_type
FROM staging_table;

-- Change NULL values in the add_ons_purchased field to 'None'
UPDATE staging_table
SET add_ons_purchased = 'None'
WHERE add_ons_purchased IS NULL;

-- Verify if there are any NULL values in critical fields
SELECT *
FROM staging_table
WHERE customer_id IS NULL
   OR age IS NULL
   OR gender IS NULL
   OR loyalty_member IS NULL
   OR product_id IS NULL
   OR product_type IS NULL
   OR unit_price IS NULL
   OR rating IS NULL
   OR quantity IS NULL
   OR total_price IS NULL
   OR order_id IS NULL
   OR order_status IS NULL
   OR payment_method IS NULL
   OR purchase_date IS NULL
   OR shipping_type IS NULL
   OR add_ons_purchased IS NULL;

-- Ensure all price, quantity, and age fields contain positive numbers
SELECT *
FROM staging_table
WHERE unit_price < 0
   OR total_price < 0
   OR quantity < 0
   OR add_on_total < 0
   OR age < 0;

-- Verify correct product_id to product_type mappings
SELECT DISTINCT product_id, product_type
FROM staging_table;

-- Update incorrect product_type values associated with product_id
MERGE INTO staging_table st
USING (
    WITH product_type_counts AS ( -- Count occurrences of each product_type by product_id
        SELECT product_id, product_type, COUNT(*) AS type_count
        FROM staging_table
        GROUP BY product_id, product_type
    ),
    most_frequent_type AS ( -- Find the most frequent product_type for each product_id
        SELECT product_id, product_type
        FROM (
            SELECT product_id, product_type, type_count,
                ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY type_count DESC) AS rn
            FROM product_type_counts
        ) ranked_products
        WHERE rn = 1
    )
    SELECT * FROM most_frequent_type
) mf
ON (st.product_id = mf.product_id)
WHEN MATCHED THEN
    UPDATE SET st.product_type = mf.product_type;

-- Update incorrect unit_price values associated with product_id
MERGE INTO staging_table st
USING (
    WITH product_price_counts AS (
        SELECT product_id, unit_price, COUNT(unit_price) AS unit_count
        FROM staging_table
        GROUP BY product_id, unit_price
    ), 
    most_frequent_price AS (
        SELECT product_id, unit_price
        FROM (
            SELECT product_id, unit_price, unit_count,
                ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY unit_count DESC) AS rn
            FROM product_price_counts
        ) ranked_product_price
        WHERE rn = 1
    )
    SELECT * FROM most_frequent_price
) pf
ON (st.product_id = pf.product_id)
WHEN MATCHED THEN
    UPDATE SET st.unit_price = pf.unit_price;

-- Verify the format of purchase_date
SELECT purchase_date
FROM staging_table
WHERE purchase_date NOT LIKE '__-__-__';
