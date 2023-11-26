with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['admission_type'])}} as admission_key,
    admission_type
from patients
group by admission_type