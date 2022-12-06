
/*
 Model of all customers.

 Data from orders which are then aggregated by customer_id. Most columns are average to aggregate.

 We hot-encode the `purchased` features.
 So if a customer ever bought a type of product the associated will be 1 otherwise 0.
 */

SELECT customer_id,
       customer_city,
       customer_state,
       SUM(payment_value) as ltv,
       AVG(avg_item_price) as avg_item_price,
       SUM(no_items) as no_items,
       AVG(review_score) as avg_review_score,
       SUM(CASE WHEN review_score IS NOT NULL THEN 1 ELSE 0 END) as no_reviews,
       AVG(avg_installments) as avg_installments,
       AVG(avg_photos) as avg_photos,
       AVG(avg_weight) as avg_weight,
       MIN(order_purchase_timestamp) as first_order_date,
       MAX(purchased_electronics) as purchased_electronics,
       MAX(purchased_home) as purchased_home,
       MAX(purchased_auto) as purchased_auto,
       MAX(purchased_children) as purchased_children,
       MAX(purchased_pets) as purchased_pets,
       MAX(purchased_leisure) as purchased_leisure,
       MAX(purchased_beauty) as purchased_beauty,
       MAX(purchased_gardening) as purchased_gardening,
       MAX(purchased_office) as purchased_office,
       MAX(purchased_fashion) as purchased_fashion,
       MAX(purchased_construction) as purchased_construction
FROM {{ ref('orders') }}
GROUP BY customer_id, customer_city, customer_state
