with doctor_details as (
    select * from {{ ref("stg_healthcare_provider") }}
), 

hospital_details  as (
    select * from {{ ref("stg_healthcare_provider_org") }}
)

select {{ dbt_utils.generate_surrogate_key(['hospital_details.healthcare_id'])}} as hospital_key,
        hospital_details.healthcare_id,
        hospital_details.hospital_name,
        doctor_details.doctor_id,
        doctor_details.first_name,
        doctor_details.last_name
from hospital_details
left join doctor_details
on hospital_details.healthcare_id = doctor_details.healthcare_org_id