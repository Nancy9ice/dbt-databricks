with patients as (
    select * from {{ ref("stg_patient_records")}}
)

select
    {{ dbt_utils.generate_surrogate_key(['test_results'])}} as result_key,
    test_results as result_status
from patients
group by test_results