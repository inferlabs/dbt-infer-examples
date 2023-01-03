
/*
 Full customre segmentation - this is a one-off, or at least very infrequent analysis, so we disable it by default.
 */

{{ config(
  enabled=false
) }}

with customers_segmentation_input as (
    SELECT customer_id,
           customer_city,
		       no_items/no_orders as avg_no_items,
           avg_item_price,
           no_detailed_reviews/no_orders as likehood_of_detailed_reviews,
           avg_review_score
    FROM {{ ref('customers') }} WHERE no_orders > 1
)

with customers_segmentation_output as (
    SELECT * 
    FROM customers_segmentation_input
    CLUSTER(ignore=customer_id, min_cluster_size=50)
)

SELECT customer_id, 
       cluster_id as customer_segment_id 
FROM customers_segmentation_output
