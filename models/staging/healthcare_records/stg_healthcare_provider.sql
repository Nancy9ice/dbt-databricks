with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    row_number() over (order by patients.doctor_name) + 100 as doctor_id,
    dense_rank() OVER (order by patients.hospital_name, patients.room_number) + 100 as healthcare_org_id,
    substring_index(patients.doctor_name, ' ', 1) as first_name,
    substring_index(patients.doctor_name, ' ', -1) as last_name
from patients
group by patients.doctor_name, patients.hospital_name, patients.room_number