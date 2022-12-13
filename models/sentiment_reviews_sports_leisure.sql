
/*
 Calculates the sentiment of translated reviews about leisure products
 */

SELECT * FROM {{ ref('translate_reviews_sports_leisure') }} SENTIMENT(review_comment_message_translated)
