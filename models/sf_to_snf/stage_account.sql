{{
    config(
        materialized='table'
    )
}}
select * from {{ source('salesforce_to_snowflake', 'Account') }}

