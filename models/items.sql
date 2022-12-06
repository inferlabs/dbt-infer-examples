
/*
 Models combining everything know about each item purchased.

 We join information about the product of the item as well as the order it was contained in,
 including customer details, reviews and payment info.
 */

with orders_items as (
    select items.order_id,
           orders.customer_id,
           items.product_id,
           items.seller_id,
           items.shipping_limit_date,
           items.price,
           items.freight_value,
           orders.order_status,
           orders.order_purchase_timestamp,
           orders.order_approved_at,
           orders.order_delivered_carrier_date,
           orders.order_delivered_customer_date,
           orders.order_estimated_delivery_date
           from demo_data.olist_order_items_dataset as items INNER JOIN demo_data.olist_orders_dataset as orders ON items.order_id = orders.order_id
), orders_items_payments as (
    select orders_items.*,
           payments.payment_sequential,
           payments.payment_type,
           payments.payment_installments,
           payments.payment_value
           from orders_items INNER JOIN demo_data.olist_order_payments_dataset as payments ON orders_items.order_id = payments.order_id
), customer_orders as (
    select orders_items_payments.*,
           customers.customer_zip_code_prefix,
           customers.customer_city,
           customers.customer_state
           from orders_items_payments INNER JOIN demo_data.olist_customers_dataset as customers ON orders_items_payments.customer_id = customers.customer_id
), customer_orders_products as (
    SELECT customer_orders.*,
           products.product_category_name,
           products.product_name_lenght as product_name_length,
           products.product_description_lenght as product_description_length,
           products.product_photos_qty,
           products.product_weight_g,
           products.product_length_cm,
           products.product_height_cm,
           products.product_width_cm
    FROM customer_orders INNER JOIN demo_data.olist_products_dataset as products ON customer_orders.product_id = products.product_id
), customer_orders_reviews as (
    SELECT customer_orders_products.*,
           reviews.review_score,
           reviews.review_comment_title,
           reviews.review_comment_message,
           reviews.review_creation_date,
           reviews.review_answer_timestamp
    FROM customer_orders_products LEFT JOIN demo_data.olist_order_reviews_dataset as reviews ON customer_orders_products.order_id = reviews.order_id
), customer_orders_translated as (
    SELECT customer_orders_reviews.*,
           translated.product_category_name_english
    FROM customer_orders_reviews INNER JOIN demo_data.product_category_name_translation as translated ON customer_orders_reviews.product_category_name = translated.product_category_name
)

SELECT * FROM customer_orders_translated
