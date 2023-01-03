SELECT customer_segment_id, 
        (CASE WHEN customer_city = "sao paulo" THEN 1 ELSE 0 END) as city_sao_paulo,
        (CASE WHEN customer_city = "rio de janeiro" THEN 1 ELSE 0 END) as city_rio,
        (CASE WHEN customer_city = "belo horizonte" THEN 1 ELSE 0 END) as city_belo_horizonte,
        (CASE WHEN customer_city = "brasilia" THEN 1 ELSE 0 END) as city_brasilia,
        no_items/no_orders as avg_no_items,
        avg_item_price,
        no_detailed_reviews/no_orders as likehood_of_detailed_reviews,
        avg_review_score
FROM {{ ref('customer_segmentation') }} AS segmentation
LEFT JOIN {{ ref('customers') }} AS customers
ON segmentation.customer_id = customers.customer_id
EXPLAIN(PREDICT(customer_segment_id))