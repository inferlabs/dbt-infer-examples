
/*
 Calculates the topics of translated reviews about leisure products
 */

SELECT * FROM {{ ref('translate_reviews_sports_leisure') }} TOPICS(review_comment_message_translated)
