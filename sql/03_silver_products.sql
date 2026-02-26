%sql
CREATE OR REPLACE TABLE main.silver.pharma_products
USING DELTA
AS

WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY product_id
               ORDER BY SKU DESC
           ) AS rn
    FROM main.bronze.pharma_products_dirty
)

SELECT
    CAST(product_id AS BIGINT)                  AS product_id,
    INITCAP(TRIM(product_name))                 AS product_name,
    INITCAP(TRIM(product_category))             AS product_category,
    INITCAP(TRIM(manufacturing_city))           AS manufacturing_city,
    INITCAP(TRIM(dosage_form))                  AS dosage_form,
    strength,
    CAST(SKU AS BIGINT)                         AS sku,
    CAST(base_price AS DOUBLE)                  AS base_price,
    storage_condition,
    CAST(expiry_years AS INT)                   AS expiry_years
FROM ranked
WHERE rn = 1
  AND product_id IS NOT NULL
  AND base_price > 0
  AND (expiry_years IS NULL OR expiry_years > 0);