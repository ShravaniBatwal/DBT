{{
    config(
        materialized='table'
    )
}}

select 
    account_key,
    user_key,
    date_key,
    sum(TotalAmount) as Aggregated_Amount,
    round(sum(discounted_amount), 1) as Aggregated_Discounted_Amount,
    round(sum(amount_with_tax), 1) as Aggregated_Amount_With_Tax
from {{ ref('fact_order') }}
group by
    account_key,
    user_key,
    date_key
