-- El precio de la cripto debe ser mayor a cero
SELECT *
FROM {{ ref('stg_crypto') }}
WHERE price_usd <= 0