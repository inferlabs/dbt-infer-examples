{{
  config(
    materialized = "table"
  )
}}

with predict_seller_conversion_input as (
    SELECT first_contact_date,
           landing_page_id,
           origin,
           (CASE WHEN seller_id IS NULL THEN 0 ELSE 1 END) as converted
    FROM {{ ref('closed_leads') }}
)

SELECT *
FROM predict_seller_conversion_input PREDICT(converted)
