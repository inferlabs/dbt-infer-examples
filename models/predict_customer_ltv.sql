{{
  config(
    materialized = "table"
  )
}}

/*
    We only want to use customers which has been customers for a least 180 days.
    If they have been customers for less, we don't think their LTV matters much

    Things you can do with this:
    - calculate the value of new customers
    - calculate ltv by city/state etc
 */
with predict_customer_ltv_input as (
    SELECT customer_id,
           (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(first_order_date), DAY) > 180 THEN customer_ltv ELSE NULL END) as customer_ltv,
           avg_item_price,
           no_items,
           avg_installments,
           avg_photos,
           avg_weight,
           no_reviews,
           customer_city,
           customer_state,
           purchased_electronics,
           purchased_home,
           payment_installments
    FROM {{ ref('customer') }}
)

SELECT * FROM predict_customer_ltv_input PREDICT(customer_ltv, ignore=customer_id)
