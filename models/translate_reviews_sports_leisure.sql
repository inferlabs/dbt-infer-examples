
/*
 Translates product reviews into english
 */


with leisure_reviews_translated as (
    SELECT order_id,
           review_comment_message
    FROM {{ ref('orders') }} WHERE purchased_leisure = 1 AND review_comment_message IS NOT NULL
)

SELECT order_id, prediction as review_comment_message_translated FROM leisure_reviews_translated TRANSLATE(review_comment_message)

