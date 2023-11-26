with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['patient_name'])}} as patient_key,
    substring_index(patient_name, ' ', 1) as first_name,
    substring_index(patient_name, ' ', -1) as last_name,
    age,
    gender,
    blood_type, 
    room_number
from patients
group by patient_name, first_name, last_name, age, gender, blood_type, room_number
