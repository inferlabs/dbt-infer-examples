

SELECT customer_id,
       SUM(payment_value) as customer_ltv,
       AVG(avg_item_price) as avg_item_price,
       SUM(no_items) as no_items,
       AVG(avg_installments) as avg_installments,
       AVG(avg_photos) as avg_photos,
       AVG(avg_weight) as avg_weight,
       SUM(CASE WHEN review_score IS NOT NULL THEN 1 ELSE 0 END) as no_reviews,
       ANY_VALUE(customer_city) as customer_city,
       ANY_VALUE(customer_state) as customer_state,
       MAX(purchased_electronics) as purchased_electronics,
       MAX(purchased_home) as purchased_home,
       MIN(order_purchase_timestamp) as first_order_date,
       AVG(avg_installments) as payment_installments
FROM (
       SELECT ANY_VALUE(customer_id) as customer_id,
              AVG(payment_value) as payment_value,
              AVG(price) as avg_item_price,
              COUNT(product_id) as no_items,
              ANY_VALUE(review_score) as review_score,
              AVG(payment_installments) as avg_installments,
              AVG(product_photos_qty) as avg_photos,
              AVG(product_weight_g) as avg_weight,
              ANY_VALUE(customer_city) as customer_city,
              ANY_VALUE(customer_state) as customer_state,
              ANY_VALUE(order_purchase_timestamp) as order_purchase_timestamp,
              MAX(CASE WHEN product_category_name_english IN ('computers_accessories', 'electronics', 'telephony') THEN 1 ELSE 0 END) AS purchased_electronics,
              MAX(CASE WHEN product_category_name_english IN ('bed_bath_table', 'furniture_decor', 'housewares') THEN 1 ELSE 0 END) AS purchased_home
              FROM {{ ref('item_orders') }} GROUP BY order_id
    ) GROUP BY customer_id
