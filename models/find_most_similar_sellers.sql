
{{
  config(
    materialized = "table"
  )
}}

/*
 Finds the sellers most similar to the highest grossing seller.
 */

with most_similar_to_highest_ltv_seller as (
    SELECT no_products,
           no_customers,
           seller_city,
           seller_state,
           origin,
           business_segment,
           lead_type,
           business_type,
           row_num
    FROM (
        SELECT sellers_orders.*, ROW_NUMBER() OVER (ORDER BY ltv DESC) AS row_num
        FROM {{ ref('sellers_orders') }} as sellers_orders
    )
)

SELECT * FROM most_similar_to_highest_ltv_seller SIMILAR_TO(row_num=1)
