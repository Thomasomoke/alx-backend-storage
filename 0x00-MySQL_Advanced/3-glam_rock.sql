-- A SQL script that lists all bands with Glam rock as their main style, ranked by their longevity
-- Calculating lifespan in years, until 2022 (or the split year, if applicable)

SELECT
    band_name,
    CASE
        -- If the band has split, calculate lifespan using the split year
        WHEN split IS NOT NULL THEN (split - formed)
        ELSE (2022 - formed)
    END AS lifespan
FROM
    metal_bands
WHERE
    style = 'Glam rock'
ORDER BY
    lifespan DESC;
