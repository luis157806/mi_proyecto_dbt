{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('raw', 'crypto') }}
),

renamed AS (
    SELECT
        id AS crypto_id,
        name AS coin_name,
        symbol,
        (quote->'USD'->>'price')::FLOAT AS price_usd,
        _airbyte_extracted_at AS loaded_at
    FROM source
)

SELECT * FROM renamed
WHERE price_usd > 0  -- Esta línea solucionará el fallo del test