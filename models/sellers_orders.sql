
SELECT SUM(orders.price) as ltv,
       ANY_VALUE(sellers.seller_city) as seller_city,
       ANY_VALUE(sellers.seller_state) as seller_state,
       ANY_VALUE(sellers.origin) as origin,
       ANY_VALUE(sellers.sdr_id) as sdr_id,
       ANY_VALUE(sellers.business_segment) as business_segment,
       ANY_VALUE(sellers.lead_type) as lead_type,
       ANY_VALUE(sellers.business_type) as business_type,
       ANY_VALUE(sellers.won_date) as won_date
FROM demo_data.olist_order_items_dataset as orders
INNER JOIN {{ ref('sellers') }} as sellers ON orders.seller_id = sellers.seller_id
GROUP BY sellers.seller_id
