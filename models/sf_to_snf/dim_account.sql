{{ config(
    materialized='incremental',
    unique_key='Id'
)}}

select 
    row_number() over(order by Id) as Account_key,
    Id as Account_id,
    Name,
    AccountNumber,
    tax__c as tax,
    Phone,
    BillingCity,
    LastModifiedDate 
from 
    {{ ref('stage_account') }} 
