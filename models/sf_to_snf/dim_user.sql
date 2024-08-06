{{ config(
    materialized='table')
}}

select 
    md5(DBT_VALID_FROM || Owner_Id) as User_key,
    row_number() over(order by null) rn,
    Owner_Id,
    USERNAME,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    PHONE,
    LASTMODIFIEDDATE,
    DISCOUNT__C,
    DBT_VALID_FROM as Valid_from,
    '9999-01-01'::date as valid_to,
    CASE WHEN DBT_VALID_TO IS NULL THEN 'true' ELSE 'false' END AS status
from {{ ref('user_scd2') }} us