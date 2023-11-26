with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    row_number() OVER (order by hospital_name) + 100 as healthcare_id,
    hospital_name
from patients
group by hospital_name