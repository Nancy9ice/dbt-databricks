with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['insurance_provider'])}} as insurance_key,
    insurance_provider
from patients
group by insurance_provider
