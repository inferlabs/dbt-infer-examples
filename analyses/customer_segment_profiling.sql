
WITH segment_stats AS (
       SELECT customer_segment_id,
              AVG(avg_no_items) as avg_no_items,
              AVG(avg_item_price) as avg_item_price,
              AVG(likehood_of_detailed_reviews) as likehood_of_detailed_reviews,
              AVG(avg_review_score) as avg_review_score,
              AVG(city_sao_paulo) as city_sao_paulo,
              AVG(city_rio) as city_rio,
              AVG(city_belo_horizonte) as city_belo_horizonte,
              AVG(city_brasilia) as city_brasilia
       FROM (
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
       )
       GROUP BY customer_segment_id
)

SELECT customer_segment_id, 
       avg_no_items/(SELECT AVG(avg_no_items) FROM segment_stats) - 1.0 as avg_no_items_index, 
       avg_item_price/(SELECT AVG(avg_item_price) FROM segment_stats) - 1.0 as avg_item_price_index,
       likehood_of_detailed_reviews/(SELECT AVG(likehood_of_detailed_reviews) FROM segment_stats) - 1.0 as likehood_of_detailed_reviews_index,
       avg_review_score/(SELECT AVG(avg_review_score) FROM segment_stats) - 1.0 as avg_review_score_index,
       city_sao_paulo/(SELECT AVG(city_sao_paulo) FROM segment_stats) - 1.0 as city_sao_paulo_index,
       city_rio/(SELECT AVG(city_rio) FROM segment_stats) - 1.0 as city_rio_index,
       city_belo_horizonte/(SELECT AVG(city_belo_horizonte) FROM segment_stats) - 1.0 as city_belo_horizonte_index,
       city_brasilia/(SELECT AVG(city_brasilia) FROM segment_stats) - 1.0 as city_brasilia_index
FROM segment_stats
