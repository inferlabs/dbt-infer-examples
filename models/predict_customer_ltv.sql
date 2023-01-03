
/*
    Model for predicting the ltv for each customer.

    We only want to use customers which has been customers for a least 180 days.
    If they have been customers for less, we don't think their LTV matters much.
    To do this we set the ltv, our target for prediction, to NULL if a customer has been active for less than 180 days.
    Setting it to NULL means that PREDICT won't use this row to learn from but will predict the ltv value for it in the output.

    Things you can do with this:
    - calculate the value of new customers
    - calculate ltv by city/state etc
 */
with predict_customer_ltv_input as (
    SELECT customer_id,
           (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(first_order_date), DAY) > 180 THEN ltv ELSE NULL END) as ltv,
           customer_city,
           customer_state,
           avg_item_price,
           no_items,
           avg_review_score,
           no_detailed_reviews,
           avg_installments,
           avg_photos,
           avg_weight,
           purchased_electronics,
           purchased_home,
           purchased_auto,
           purchased_children,
           purchased_pets,
           purchased_leisure,
           purchased_beauty,
           purchased_gardening,
           purchased_office,
           purchased_fashion,
           purchased_construction
    FROM {{ ref('customers') }}
)

SELECT * FROM predict_customer_ltv_input PREDICT(ltv, ignore=customer_id)
