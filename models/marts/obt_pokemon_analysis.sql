{{ config(materialized='table') }}

WITH base_data AS (
    SELECT * FROM {{ ref('int_pokemon_crypto') }}
),

calculated_metrics AS (
    SELECT 
        *,
        -- Usamos el nombre que definiste en el modelo anterior
        (base_experience * price_usd) AS pokemon_value_usd
    FROM base_data
),

final_output AS (
    SELECT
        *,
        CASE 
            WHEN pokemon_value_usd > 10000 THEN 'Luxury'
            WHEN pokemon_value_usd > 5000 THEN 'Premium'
            ELSE 'Standard'
        END AS value_tier
    FROM calculated_metrics
)

SELECT * FROM final_output