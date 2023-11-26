with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['medical_condition'])}} as diagnosis_key,
    medical_condition as diagnosis
from patients
group by diagnosis