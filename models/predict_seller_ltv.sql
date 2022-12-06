{{
  config(
    materialized = "table"
  )
}}

 /*
    Model for predicting the ltv for each seller.

    We only want to use seller which have been on the platform for a least 180 days.
    To do this we set the ltv, our target for prediction, to NULL if a customer has been active for less than 180 days.
    Setting it to NULL means that PREDICT won't use this row to learn from but will predict the ltv value for it in the output.

    Things you can do with this:
    - calculate the expected LTV of new sellers
    - aggregate the expected ltv by city, state, business_segment etc to understand where the most value is expected to come from
 */

with predict_seller_ltv_input as (
    SELECT seller_id,
           (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(won_date), DAY) > 180 THEN ltv ELSE NULL END) as ltv,
           no_customers,
           no_items_sold,
           no_products,
           seller_city,
           seller_state,
           origin,
           sdr_id,
           business_segment,
           lead_type,
           business_type
    FROM {{ ref('sellers_orders') }}
)

SELECT * FROM predict_seller_ltv_input PREDICT(ltv, ignore=seller_id)
