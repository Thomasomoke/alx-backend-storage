-- a SQL script that ranks country origins of bands
-- ordered by the number of (non-unique) fans
DROP TABLE IF EXISTS `band_origins_ranked`;
-- create a new table to store the ranked origins
CREATE TABLE `band_origins_ranked` AS
SELECT
	origin,
	SUM(fans) AS nb_fans
FROM
	metal_bands
GROUP BY
	origin
ORDER BY
	nb_fans DESC;
SELECT origin, nb_fans FROM `band_origins_ranked`;
