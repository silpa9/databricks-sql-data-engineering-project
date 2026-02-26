CSV in Volume
(/Volumes/workspace/bronze/raw_files)

        ↓ read_files()

Bronze Table
(main.bronze.pharma_orders_dirty)

        ↓ cleaning + casting

Silver Table
(main.silver.pharma_orders)

        ↓ aggregation

Gold Table
(main.gold.pharma_sales_summary)