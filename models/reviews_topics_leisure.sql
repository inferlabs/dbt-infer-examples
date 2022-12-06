
{{
  config(
    materialized = "table"
  )
}}

/*
 Calculates the topics of translated reviews about leisure products
 */

SELECT * FROM {{ ref('reviews_translated_leisure') }} TOPICS(review_comment_message_translated)
