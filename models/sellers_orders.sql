
/*
 We join sellers with order data.
 */
SELECT sellers.seller_id,
       SUM(items.price) as ltv,
       COUNT(*) as no_items_sold,
       COUNT(DISTINCT items.product_id) as no_products,
       COUNT(DISTINCT items.customer_id) as no_customers,
       ANY_VALUE(sellers.seller_city) as seller_city,
       ANY_VALUE(sellers.seller_state) as seller_state,
       ANY_VALUE(sellers.origin) as origin,
       ANY_VALUE(sellers.sdr_id) as sdr_id,
       ANY_VALUE(sellers.has_company) as has_company,
       ANY_VALUE(sellers.business_segment) as business_segment,
       ANY_VALUE(sellers.lead_type) as lead_type,
       ANY_VALUE(sellers.business_type) as business_type,
       ANY_VALUE(sellers.won_date) as won_date
FROM {{ ref('items') }} as items
INNER JOIN {{ ref('sellers') }} as sellers ON items.seller_id = sellers.seller_id
GROUP BY sellers.seller_id
