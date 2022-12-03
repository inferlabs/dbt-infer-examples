

SELECT product_id,
       ANY_VALUE(product_category_name) as product_category_name,
       ANY_VALUE(product_name_length) as product_name_length,
       ANY_VALUE(product_description_length) as product_description_length,
       ANY_VALUE(product_photos_qty) as product_photos_qty,
       ANY_VALUE(product_weight_g) as product_weight_g,
       ANY_VALUE(product_length_cm) as product_length_cm,
       ANY_VALUE(product_height_cm) as product_height_cm,
       ANY_VALUE(product_width_cm) as product_width_cm,
       COUNT(DISTINCT order_id) as no_orders,
       COUNT(DISTINCT customer_id) as no_customers,
       AVG(price) as avg_price,
       AVG(payment_installments) as avg_installments,
       AVG(review_score) as avg_review_score
FROM {{ ref('item_orders') }}
GROUP BY product_id
