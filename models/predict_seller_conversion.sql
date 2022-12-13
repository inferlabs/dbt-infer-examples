
/*
 Model for predicting the probability of a seller lead converting based on what is known about an leads.

 Very little is known about a non-converted lead, so the prediction is only based on three columns.

 If a lead has converted they receive a `seller_id`, so we use this as the target for the prediction.
 */

with predict_seller_conversion_input as (
    SELECT mql_id,
           first_contact_date,
           landing_page_id,
           origin,
           (CASE WHEN seller_id IS NULL THEN False ELSE True END) as converted
    FROM {{ ref('closed_leads') }}
)

SELECT * FROM predict_seller_conversion_input PREDICT(converted, ignore=mql_id)
