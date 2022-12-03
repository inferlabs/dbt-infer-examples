{{
  config(
    materialized = "table"
  )
}}


with predict_seller_ltv_input as (
    SELECT (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(won_date), DAY) > 180 THEN ltv ELSE NULL END) as ltv,
           seller_city,
           seller_state,
           origin,
           sdr_id,
           business_segment,
           lead_type,
           business_type
    FROM {{ ref('sellers_orders') }}
)

SELECT * FROM predict_seller_ltv_input PREDICT(ltv)
