
{{
  config(
    materialized = "table"
  )
}}

/*
 Calculates the sentiment of translated reviews about leisure products
 */

SELECT * FROM {{ ref('reviews_translated_leisure') }} SENTIMENT(review_comment_message_translated)
