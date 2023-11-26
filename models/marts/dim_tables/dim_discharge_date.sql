with patients as (
    select * from {{ ref("stg_patient_records")}}
)

SELECT
  {{ dbt_utils.generate_surrogate_key(['discharge_date'])}} as discharge_date_key,
  EXTRACT(YEAR FROM discharge_date) AS year,
  DATE_FORMAT(discharge_date, 'MMMM') AS month,
  EXTRACT(DAY FROM discharge_date) AS day
FROM patients
group by discharge_date