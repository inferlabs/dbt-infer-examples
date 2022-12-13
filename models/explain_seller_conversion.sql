
/*
    Model for explaining the probability of a seller lead converting based on what is known about an leads.

    This model extends the `predict_customer_ltv` model by calculating the drives of the customer ltv.
 */

with predict_seller_conversion_input as (
    SELECT first_contact_date,
           landing_page_id,
           origin,
           (CASE WHEN seller_id IS NULL THEN False ELSE True END) as converted
    FROM {{ ref('closed_leads') }}
)

SELECT * FROM predict_seller_conversion_input EXPLAIN(PREDICT(converted))
