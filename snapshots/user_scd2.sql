{% snapshot user_scd2 %}
{{
    config(
      materialized='snapshot',
      unique_key='Owner_Id',
      strategy='check',
      check_cols=['USERNAME', 'FIRSTNAME','LASTNAME','EMAIL','PHONE','DISCOUNT__C','LastModifiedDate']
    ) 
}}
select 
    Id as Owner_Id,
    USERNAME,
    FIRSTNAME,
    LASTNAME,
    EMAIL,
    PHONE,
    CREATEDDATE,
    LASTMODIFIEDDATE,
    DISCOUNT__C
 from {{ ref('stage_user') }}
{% endsnapshot %}
