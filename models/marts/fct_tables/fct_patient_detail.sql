with patients as (
    select * from {{ ref("dim_patients") }}
),

patient_records as (
    select * from {{ ref("stg_patient_records") }}
),

hospital_details as (
    select * from {{ ref("dim_health_facility")}}
),

insurance_org as (
    select * from {{ ref("dim_insurance_org") }}
),

diagnosis as (
    select * from {{ ref("dim_diagnosis") }}
), 

medications as (
    select * from {{ ref("dim_medications") }}
), 

patient_admissions as (
    select * from {{ ref("dim_admissions")}}
), 

test_results as (
    select * from {{ ref("dim_test_results") }}
), 

admission_date as (
    select * from {{ ref("dim_admissions_date") }}
), 

discharge_date as (
    select * from {{ ref("dim_discharge_date") }}
)

select 
    {{ dbt_utils.generate_surrogate_key(['patient_name'])}} as patient_key,
    {{ dbt_utils.generate_surrogate_key(['hospital_details.healthcare_id'])}} as hospital_key,
    {{ dbt_utils.generate_surrogate_key(['insurance_provider'])}} as insurance_key,
    {{ dbt_utils.generate_surrogate_key(['medical_condition'])}} as diagnosis_key,
    {{ dbt_utils.generate_surrogate_key(['admission_type'])}} as admission_key,
    {{ dbt_utils.generate_surrogate_key(['medication'])}} as treatment_key,
    {{ dbt_utils.generate_surrogate_key(['date_of_admission'])}} as admission_date_key,
    {{ dbt_utils.generate_surrogate_key(['discharge_date'])}} as discharge_date_key,
    {{ dbt_utils.generate_surrogate_key(['test_results'])}} as result_key,
    patient_records.billing_amount, 
    datediff(discharge_date, date_of_admission) as days_in_hospital
from patient_records
inner join hospital_details
on patient_records.hospital_name = hospital_details.hospital_name

