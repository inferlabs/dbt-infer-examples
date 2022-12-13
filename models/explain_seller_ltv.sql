
 /*
    Model for explaining the prediction of seller ltv.

    This model extends the `predict_seller_ltv` model by calculating the drives of the seller ltv.
 */

with predict_seller_ltv_input as (
    SELECT (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(won_date), DAY) > 180 THEN ltv ELSE NULL END) as ltv,
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
    FROM {{ ref('seller_orders') }}
)

SELECT * FROM predict_seller_ltv_input EXPLAIN(PREDICT(ltv))
