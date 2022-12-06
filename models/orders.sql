
/*
 Model of all oders.

 Data from items are aggregated into orders. Most columns are averaged to aggregate.

 We engineer a number of new features based on the types of items in the orders, all prefixed with `purchased_`.
 These features are 1 if the order contained an item of a given type otherwise 0.
 */


SELECT order_id,
       ANY_VALUE(customer_id) as customer_id,
       ANY_VALUE(customer_city) as customer_city,
       ANY_VALUE(customer_state) as customer_state,
       SUM(payment_value) as payment_value,
       AVG(price) as avg_item_price,
       COUNT(product_id) as no_items,
       ANY_VALUE(review_score) as review_score,
       ANY_VALUE(review_comment_title) as review_comment_title,
       ANY_VALUE(review_comment_message) as review_comment_message,
       AVG(payment_installments) as avg_installments,
       AVG(product_photos_qty) as avg_photos,
       AVG(product_weight_g) as avg_weight,
       ANY_VALUE(order_purchase_timestamp) as order_purchase_timestamp,
       MAX(CASE WHEN product_category_name_english IN ('computers_accessories', 'electronics', 'telephony', 'consoles_games')
           THEN 1 ELSE 0 END) AS purchased_electronics,
       MAX(CASE WHEN (product_category_name_english IN ('bed_bath_table', 'housewares')
                          OR (product_category_name_english LIKE 'furniture%')
                          OR (product_category_name_english LIKE 'home_%')) THEN 1 ELSE 0 END) AS purchased_home,
       MAX(CASE WHEN product_category_name_english IN ('auto') THEN 1 ELSE 0 END) AS purchased_auto,
       MAX(CASE WHEN product_category_name_english IN ('baby', 'toys') THEN 1 ELSE 0 END) AS purchased_children,
       MAX(CASE WHEN product_category_name_english IN ('pet_shop') THEN 1 ELSE 0 END) AS purchased_pets,
       MAX(CASE WHEN product_category_name_english IN ('sports_leisure') THEN 1 ELSE 0 END) AS purchased_leisure,
       MAX(CASE WHEN product_category_name_english IN ('health_beauty', 'perfumery') THEN 1 ELSE 0 END) AS purchased_beauty,
       MAX(CASE WHEN product_category_name_english IN ('garden_tools') THEN 1 ELSE 0 END) AS purchased_gardening,
       MAX(CASE WHEN product_category_name_english IN ('office_furniture', 'stationery') THEN 1 ELSE 0 END) AS purchased_office,
       MAX(CASE WHEN (product_category_name_english LIKE 'fashion%')
                         OR (product_category_name_english = 'watches_gifts') THEN 1 ELSE 0 END) AS purchased_fashion,
       MAX(CASE WHEN product_category_name_english LIKE 'construction%' THEN 1 ELSE 0 END) AS purchased_construction
       FROM {{ ref('items') }} GROUP BY order_id
