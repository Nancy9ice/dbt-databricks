WITH source AS (
    SELECT * FROM {{ source('healthcare_records', '_airbyte_raw_healthcare_data_extraction') }}
),

staged AS (

SELECT 
  get_json_object(_airbyte_data, '$.Admission Type') AS admission_type,
  CAST(get_json_object(_airbyte_data, '$.Age') AS INT) AS age,
  get_json_object(_airbyte_data, '$.Billing Amount') AS billing_amount,
  get_json_object(_airbyte_data, '$.Blood Type') AS blood_type,
  TO_DATE(get_json_object(_airbyte_data, '$.Date of Admission'), 'yyyy-MM-dd') AS date_of_admission,
  TO_DATE(get_json_object(_airbyte_data, '$.Discharge Date'), 'yyyy-MM-dd') AS discharge_date,
  get_json_object(_airbyte_data, '$.Doctor') AS doctor_name,
  get_json_object(_airbyte_data, '$.Gender') AS gender,
  get_json_object(_airbyte_data, '$.Hospital') AS hospital_name,
  get_json_object(_airbyte_data, '$.Insurance Provider') AS insurance_provider,
  get_json_object(_airbyte_data, '$.Medical Condition') AS medical_condition,
  get_json_object(_airbyte_data, '$.Medication') AS medication,
  get_json_object(_airbyte_data, '$.Name') AS patient_name,
  get_json_object(_airbyte_data, '$.Room Number') AS room_number,
  get_json_object(_airbyte_data, '$.Test Results') AS test_results
FROM source
)

SELECT * FROM staged