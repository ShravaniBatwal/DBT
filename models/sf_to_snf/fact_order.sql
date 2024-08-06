{{
    config(
        materialized='table'
    )
}}

with dim_account as (
    select * from {{ ref('dim_account') }}
),

dim_user as (
    select * from {{ ref('dim_user') }}
),

dim_date as (
    select * from {{ ref('dim_date') }}
),

stg_orders as (
    select *
    from {{ ref('stage_orders') }}
)

select
    stg_orders.id,
    dim_account.account_key,
    dim_user.user_key,
    dim_date.date_key,
    coalesce(dim_account.tax, 0) as tax_percent,
    coalesce(dim_user.discount__c, 0) as discount_percent,
    stg_orders.TotalAmount,
    round({{ calculate_discounted_amount('stg_orders.TotalAmount', 'coalesce(dim_user.discount__c, 0)') }}, 1) as discounted_amount,
    round({{ calculate_amount_with_tax(calculate_discounted_amount('stg_orders.TotalAmount', 'coalesce(dim_user.discount__c, 0)'), 'coalesce(dim_account.tax, 0)') }}, 1) as amount_with_tax
from stg_orders
join dim_account on stg_orders.accountid = dim_account.account_id
join dim_user on stg_orders.Ownerid = dim_user.Owner_id
join dim_date on DATE_TRUNC('DAY', TO_TIMESTAMP(stg_orders.createddate, 'YYYY-MM-DDTHH24:MI:SS.FF TZHTZM')) = dim_date.date
