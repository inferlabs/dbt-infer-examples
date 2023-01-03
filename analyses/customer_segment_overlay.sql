
WITH segment_stats AS (
       SELECT customer_segment_id,
              AVG(ltv) as ltv,
              AVG(avg_installments) as avg_installments,
              AVG(avg_weight) as avg_weight,
              AVG(avg_photos) as avg_photos
       FROM (
              SELECT customer_segment_id, 
                     ltv,
                     avg_installments,
                     avg_weight,
                     avg_photos
              FROM {{ ref('customer_segmentation') }} AS segmentation
              LEFT JOIN {{ ref('customers') }} AS customers
              ON segmentation.customer_id = customers.customer_id
       )
       GROUP BY customer_segment_id
)

SELECT customer_segment_id,
       ltv/(SELECT AVG(ltv) FROM segment_stats) - 1.0 as ltv_index, 
       avg_installments/(SELECT AVG(avg_installments) FROM segment_stats) - 1.0 as avg_installments_index,
       avg_weight/(SELECT AVG(avg_weight) FROM segment_stats) - 1.0 as avg_weight_index,
       avg_photos/(SELECT AVG(avg_photos) FROM segment_stats) - 1.0 as avg_photos_index
FROM segment_stats
