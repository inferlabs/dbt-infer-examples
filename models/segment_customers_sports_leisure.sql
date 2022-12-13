
/*
    Segments customers who have bought leisure products by behavioral traits
 */
with customers_sports_leisure as (
    SELECT ltv,
           customer_city,
           customer_state,
           avg_item_price,
           no_items,
           avg_review_score,
           no_reviews,
           avg_installments,
           avg_photos,
           avg_weight
    FROM {{ ref('customers') }} WHERE purchased_leisure = 1
)

SELECT * FROM customers_sports_leisure CLUSTER()
