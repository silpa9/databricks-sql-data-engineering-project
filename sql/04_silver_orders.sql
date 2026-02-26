CREATE OR REPLACE TABLE main.silver.pharma_orders
USING DELTA
AS
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id
               ORDER BY order_date DESC
           ) AS rn
    FROM main.bronze.pharma_orders_dirty
)
SELECT
    CAST(o.order_id AS BIGINT) AS order_id,
    CAST(o.product_id AS BIGINT) AS product_id,
    CAST(o.customer_id AS BIGINT) AS customer_id,
    CAST(o.quantity AS INT) AS quantity,
    CAST(o.unit_price AS DOUBLE) AS unit_price,
    CAST(o.order_date AS DATE) AS order_date,
    CAST(o.shipping_date AS DATE) AS shipping_date,
    o.order_status,
    o.payment_method,
    o.prescription_required,
    CAST(o.quantity * o.unit_price AS DOUBLE) AS total_amount
FROM ranked o
JOIN main.silver.pharma_products p
  ON o.product_id = p.product_id
WHERE rn = 1
  AND o.order_id IS NOT NULL
  AND o.customer_id IS NOT NULL
  AND o.quantity > 0
  AND o.unit_price > 0
  AND o.order_date IS NOT NULL
  AND (o.shipping_date IS NULL OR o.shipping_date >= o.order_date);