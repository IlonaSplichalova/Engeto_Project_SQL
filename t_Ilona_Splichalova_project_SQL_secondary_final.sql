
CREATE OR REPLACE TABLE t_Ilona_Splichalova_project_SQL_secondary_final AS
	SELECT
		c.country,
		e.population,
		e.year,
		e.GDP,
		e.gini
	FROM countries c 
	LEFT JOIN economies e ON e.country = c.country
	WHERE continent = "Europe" AND c.country != "Czech Republic" 
		AND e.year BETWEEN 2006 AND 2018
	ORDER BY country, year;
	
