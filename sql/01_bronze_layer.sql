%sql
CREATE OR REPLACE TABLE main.bronze.pharma_orders_dirty
USING DELTA
AS
SELECT *
FROM read_files(
  '/Volumes/main/bronze/raw_files/pharma_orders_dirty.csv',
  format => 'csv',
  header => true,
  inferSchema => true
);

%sql
CREATE OR REPLACE TABLE main.bronze.pharma_products_dirty
USING DELTA
AS
SELECT *
FROM read_files(
  '/Volumes/main/bronze/raw_files/pharma_products_dirty.csv',
  format => 'csv',
  header => true,
  inferSchema => true
);