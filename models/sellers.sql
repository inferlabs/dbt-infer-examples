
SELECT sellers.seller_id,
       sellers.seller_zip_code_prefix,
       sellers.seller_city,
       sellers.seller_state,
       closed.mql_id,
       closed.first_contact_date,
       closed.landing_page_id,
       closed.origin,
       closed.sdr_id,
       closed.sr_id,
       closed.won_date,
       closed.business_segment,
       closed.lead_type,
       closed.lead_behaviour_profile,
       closed.has_company,
       closed.has_gtin,
       closed.average_stock,
       closed.business_type,
       closed.declared_product_catalog_size,
       closed.declared_monthly_revenue
FROM demo_data.olist_sellers_dataset as sellers INNER JOIN
    {{ ref('closed_leads') }} as closed ON sellers.seller_id = closed.seller_id
