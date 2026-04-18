-- ============================================================
-- ZEPTO PRODUCT DATA ANALYSIS — SQL PROJECT
-- Dataset: Zepto e-commerce product listings (~3,732 rows)
-- Tool: PostgreSQL
-- Author: Vignesh M
-- ============================================================


-- ============================================================
-- SECTION 1: TABLE CREATION & DATA LOAD
-- ============================================================

CREATE TABLE zepto (
    category        VARCHAR(200),
    name            VARCHAR(200),
    mrp             INT,        -- stored in paisa
    dis_percent     INT,
    available_quan  INT,
    disc_sp         INT,        -- stored in paisa
    weight_ingm     INT,
    outofstock      BOOLEAN,
    quantity        INT
);

-- Preview data after import
SELECT * FROM zepto LIMIT 10;
SELECT COUNT(*) FROM zepto;


-- ============================================================
-- SECTION 2: DATA CLEANING
-- ============================================================

-- Check for NULL values
SELECT *
FROM zepto
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR dis_percent IS NULL
   OR available_quan IS NULL
   OR disc_sp IS NULL
   OR weight_ingm IS NULL
   OR outofstock IS NULL
   OR quantity IS NULL;

-- Remove invalid rows
DELETE FROM zepto
WHERE mrp = 0 OR mrp IS NULL;

-- NOTE:
-- Prices are stored in paisa (₹1 = 100 paisa)
-- We will NOT update original data (best practice)


-- ============================================================
-- SECTION 3: DATA TRANSFORMATION
-- ============================================================

-- Convert prices to rupees (for display only)
SELECT 
    name,
    ROUND(mrp / 100.0, 2) AS mrp_rupees,
    ROUND(disc_sp / 100.0, 2) AS selling_price
FROM zepto;

-- Calculate discount amount
SELECT 
    name,
    ROUND((mrp - disc_sp) / 100.0, 2) AS discount_rupees
FROM zepto;

-- Verify discount percentage
SELECT 
    name,
    dis_percent,
    ROUND(((mrp - disc_sp) * 100.0) / mrp, 2) AS calculated_discount
FROM zepto;


-- ============================================================
-- SECTION 4: BASIC ANALYSIS
-- ============================================================

-- Distinct categories
SELECT DISTINCT category FROM zepto ORDER BY category;

-- Total unique products
SELECT COUNT(DISTINCT name) AS total_products FROM zepto;

-- Out-of-stock count
SELECT outofstock, COUNT(*) FROM zepto GROUP BY outofstock;


-- ============================================================
-- SECTION 5: PRICING & DISCOUNT ANALYSIS
-- ============================================================

-- Products above ₹500
SELECT name, ROUND(disc_sp / 100.0, 2) AS price
FROM zepto
WHERE disc_sp > 50000
ORDER BY price DESC;

-- High discount products (>50%)
SELECT name, dis_percent
FROM zepto
WHERE dis_percent > 50
ORDER BY dis_percent DESC;

-- Top 10 expensive products
SELECT name, ROUND(disc_sp / 100.0, 2) AS price
FROM zepto
ORDER BY disc_sp DESC
LIMIT 10;

-- Cheapest products (in stock)
SELECT name, ROUND(disc_sp / 100.0, 2) AS price
FROM zepto
WHERE outofstock = FALSE AND disc_sp > 0
ORDER BY disc_sp ASC
LIMIT 10;

-- Average price per category
SELECT 
    category,
    ROUND(AVG(disc_sp) / 100.0, 2) AS avg_price
FROM zepto
GROUP BY category
ORDER BY avg_price DESC;


-- ============================================================
-- SECTION 6: CATEGORY ANALYSIS
-- ============================================================

-- Total products per category
SELECT category, COUNT(*) AS total_products
FROM zepto
GROUP BY category
ORDER BY total_products DESC;

-- Price range per category
SELECT 
    category,
    MIN(mrp)/100.0 AS min_price,
    MAX(mrp)/100.0 AS max_price,
    (MAX(mrp) - MIN(mrp))/100.0 AS price_range
FROM zepto
GROUP BY category
ORDER BY price_range DESC;


-- ============================================================
-- SECTION 7: STOCK ANALYSIS
-- ============================================================

-- Out-of-stock products by category
SELECT 
    category,
    COUNT(*) AS out_of_stock
FROM zepto
WHERE outofstock = TRUE
GROUP BY category
ORDER BY out_of_stock DESC;

-- Out-of-stock percentage
SELECT 
    category,
    COUNT(*) AS total,
    SUM(CASE WHEN outofstock THEN 1 ELSE 0 END) AS out_stock,
    ROUND(100.0 * SUM(CASE WHEN outofstock THEN 1 ELSE 0 END) / COUNT(*), 2) AS percentage
FROM zepto
GROUP BY category;


-- ============================================================
-- SECTION 8: ADVANCED ANALYSIS
-- ============================================================

-- Rank products by price within category
SELECT 
    category,
    name,
    ROUND(disc_sp / 100.0, 2) AS price,
    RANK() OVER (PARTITION BY category ORDER BY disc_sp DESC) AS rank
FROM zepto;

-- Best value products (grams per rupee)
SELECT 
    name,
    weight_ingm,
    ROUND(disc_sp / 100.0, 2) AS price,
    ROUND(weight_ingm::NUMERIC / NULLIF(disc_sp,0), 2) AS value_ratio
FROM zepto
WHERE outofstock = FALSE
ORDER BY value_ratio DESC
LIMIT 10;


-- ============================================================
-- END OF PROJECT
-- ============================================================
