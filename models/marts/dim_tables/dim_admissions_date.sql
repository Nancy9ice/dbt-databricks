with patients as (
    select * from {{ ref("stg_patient_records")}}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['date_of_admission'])}} as admission_date_key,
  EXTRACT(YEAR FROM date_of_admission) AS year,
  DATE_FORMAT(date_of_admission, 'MMMM') AS month,
  EXTRACT(DAY FROM date_of_admission) AS day
FROM patients
group by date_of_admission