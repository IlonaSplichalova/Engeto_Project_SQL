/*
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
*/

WITH percentage_growth_table AS (
	SELECT 
		year,
		average_value,
		name,
		price_value,
		price_unit,
		LEAD(average_value) OVER (PARTITION BY name ORDER BY name,year) AS average_value2
	FROM t_Ilona_Splichalova_project_SQL_primary_final
	GROUP BY name, year
	)
SELECT 	
	name,
	SUM(ROUND(((average_value2 - average_value) / average_value2 ) *100, 2)) AS sum_growth_percent
FROM percentage_growth_table
GROUP BY name
ORDER BY sum_growth_percent ASC;