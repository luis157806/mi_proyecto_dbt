{{ config(materialized='view') }}

WITH pokemon AS (
    SELECT * FROM {{ ref('stg_pokemon') }}
),

crypto AS (
    SELECT * FROM {{ ref('stg_crypto') }}
    WHERE symbol = 'BTC'
)

SELECT
    p.pokemon_id,
    p.pokemon_name,
    p.base_experience,
    c.coin_name,
    c.price_usd, -- Agregamos el nombre original para que el Mart lo encuentre
    c.price_usd AS btc_price_reference,
    (p.base_experience * 0.1) AS value_index
FROM pokemon p
CROSS JOIN crypto c