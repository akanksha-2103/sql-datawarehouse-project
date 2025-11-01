drop  view if exists gold.report_customers;

CREATE view gold.report_customers as

WITH base_query AS (
  -- 1) base query : Retrieves core columns from tables
  
    SELECT
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        TIMESTAMPDIFF(YEAR, c.birthdate, NOW()) AS age,
        f.order_date,
        f.sales_amount,
        f.quantity,
        f.product_key
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON c.customer_key = f.customer_key
    WHERE order_date IS NOT NULL
),
--- 2) customer aggregation
  
customer_aggregation AS (
    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        CASE
            WHEN age < 20 THEN 'Under 20'
            WHEN age BETWEEN 20 AND 29 THEN '20–29'
            WHEN age BETWEEN 30 AND 39 THEN '30–39'
            WHEN age BETWEEN 40 AND 49 THEN '40–49'
            ELSE '50 and above'
        END AS age_group,

        COUNT(DISTINCT order_date) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
  
        CASE
            WHEN TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 AND SUM(sales_amount) > 5000 THEN 'VIP'
            WHEN TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) >= 12 AND SUM(sales_amount) <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment,

        CASE 
            WHEN SUM(sales_amount) = 0 THEN 0
            ELSE SUM(sales_amount) / COUNT(DISTINCT order_date)
        END AS avg_order_value,

        CASE 
            WHEN TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date)) = 0 THEN SUM(sales_amount)
            ELSE SUM(sales_amount) / TIMESTAMPDIFF(MONTH, MIN(order_date), MAX(order_date))
        END AS avg_monthly_spend

    FROM base_query
    GROUP BY customer_key, customer_number, customer_name, age
)

SELECT * FROM customer_aggregation;



SELECT*FROM gold.report_customers;
