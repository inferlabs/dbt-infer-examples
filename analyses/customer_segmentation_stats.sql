
SELECT customer_segment_id, 
       COUNT(customer_id) as no_customers 
FROM {{ ref('customer_segmentation') }}
GROUP BY customer_segment_id
