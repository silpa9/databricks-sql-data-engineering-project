ALTER TABLE main.silver.pharma_products
ADD CONSTRAINT price_positive
CHECK (base_price > 0);

ALTER TABLE main.silver.pharma_orders
ADD CONSTRAINT quantity_positive
CHECK (quantity > 0);

ALTER TABLE main.silver.pharma_orders
ADD CONSTRAINT valid_shipping
CHECK (
    shipping_date IS NULL
    OR shipping_date >= order_date
);