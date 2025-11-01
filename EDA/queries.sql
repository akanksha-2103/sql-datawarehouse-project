-- Retrieve  a list of  unique countries from which customers orginate

select distinct country from gold.dim_customers;



-- RETRIEVE  a list of unique categories,subcategories,and products

select distinct
category,
subcategory,
product_name
FROM gold.dim_products;


-- Determine the first nd last order date and the total duration in months

SELECT
min(order_date)as first_order,
max(order_date)as last_order,
TIMESTAMPDIFF(Month,min(order_date),max(order_date)) as duration_in_months
from gold.fact_sales;



SELECT
min(birthdate) as oldest_bdate,
timestampdiff(year,min(birthdate),now())as oldest_cust_age,
max(birthdate)as youngest_bdate,
timestampdiff(year,max(birthdate),now()) as youngest_cust_age
from gold.dim_customers;


-- Find total customers by countries

select
country,
count(customer_key)as total_customers
from gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- find total customers by gender

SELECT
     gender,
     COUNT(customer_key)AS total_customers
     FROM gold.dim_customers
     GROUP BY gender
     ORDER BY total_customers DESC;
     
     
     -- find total products by category
      
select
      category,
      count(product_key) as total_products
from gold.dim_products
group by category
order by total_products DESC;
      
     
     
	-- what is the average costs in each category
    
    SELECT
     category,
     AVG(cost)AS avg_cost
     FROM gold.dim_products
     GROUP BY category
     ORDER BY avg_cost DESC;
     
     
	-- what is the total revenue generated for each category?
    
    SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
    from gold.fact_sales f
    LEFT JOIN gold.dim_products p
         on p.product_key=f.product_key
	group by p.category;
    
    -- what is the total revenue generated for each customer?
    
    SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    sum(f.sales_amount) as total_revenue
    from gold.fact_sales f
    LEFT JOIN gold.dim_customers c
    on c.customer_key=f.customer_key
    group by
    c.customer_key,
    c.first_name,
    c.last_name
    order by total_revenue desc;
    
    -- what is the distribution of sold items across countries?
    
    SELECT
    c.country,
    SUM(f.quantity) AS total_sold_items
    FROM gold.fact_sales f 
    LEFT JOIN gold.dim_customers c
         ON c.customer_key=f.customer_key
	group by c.country
    order by total_sold_items DESC;


-- which 5 products generating the highest revenue?
-- simple ranking

SELECT 
p.product_name,
sum(f.sales_amount) AS total_revenue
from gold.fact_sales f 
left join gold.dim_products p
on p.product_key=f.product_key
group by p.product_name
order by total_revenue DESC
LIMIT 5;


-- FIND TOP 10 customers who have generated the highest revenue

select 
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount)as total_revenue
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
group by
c.customer_key,
c.first_name,
c.last_name
order by total_revenue DESC
limit 10;








