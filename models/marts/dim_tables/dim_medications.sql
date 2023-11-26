with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['medication'])}} as treatment_key,
    medication
from patients
group by medication