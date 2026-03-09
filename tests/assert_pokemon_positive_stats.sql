-- Los stats no pueden ser negativos [cite: 96]
SELECT *
FROM {{ ref('stg_pokemon') }}
WHERE height < 0 OR weight < 0 OR base_experience < 0