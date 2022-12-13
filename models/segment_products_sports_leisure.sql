
/*
 Segments leisure products by product characteristics
 */
with products_sports_leisure as (
    SELECT product_category_name_english,
       product_name_length,
       product_description_length,
       product_photos_qty,
       product_weight_g,
       product_length_cm,
       product_height_cm,
       product_width_cm,
       no_orders,
       no_customers,
       avg_price,
       avg_installments,
       avg_review_score
    FROM {{ ref('products') }} WHERE product_category_name_english='sports_leisure'
)


SELECT * FROM products_sports_leisure CLUSTER()
