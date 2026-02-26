CREATE OR REPLACE TABLE main.gold.revenue_by_category
USING DELTA
AS
SELECT
    p.product_category,
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM main.silver.pharma_orders o
JOIN main.silver.pharma_products p
  ON o.product_id = p.product_id
GROUP BY p.product_category;