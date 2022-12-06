
/*
 Model of all seller leads.

 If they did not convert we have very little data - only first_contact_date, landing_page_id and origin.
 Once they convert we get a lot more data about their business.
*/

with closed_leads as (
    SELECT mql.mql_id,
           mql.first_contact_date,
           mql.landing_page_id,
           mql.origin,
           closed.seller_id,
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
    FROM demo_data.olist_marketing_qualified_leads_dataset as mql LEFT JOIN
         demo_data.olist_closed_deals_dataset as closed ON mql.mql_id = closed.mql_id
)

SELECT * from closed_leads
