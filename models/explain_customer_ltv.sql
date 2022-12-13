
/*
    Model for explaining the prediction of customer ltv.

    This model extends the `predict_customer_ltv` model by calculating the drives of the customer ltv.

    For each entry we record the date of the explanation.
    The idea is to track the drivers over time and monitor if what drives LTV changes, since this would indicate a
    change in the underlying customer dynamics.
 */

with predict_customer_ltv_input as (
    SELECT (CASE WHEN DATE_DIFF(DATE({{ var("year") }}, {{ var("month") }}, {{ var("day") }}), DATE(first_order_date), DAY) > 180 THEN ltv ELSE NULL END) as ltv,
           customer_city,
           customer_state,
           avg_item_price,
           no_items,
           avg_review_score,
           no_reviews,
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

SELECT * FROM predict_customer_ltv_input EXPLAIN(PREDICT(ltv))
