/*
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší 
než růst mezd (větší než 10 %)?
*/

WITH table1 AS (
	SELECT 
		year AS year_1, 
		ROUND(AVG(year_value),2) AS year_value_1, 
		ROUND(AVG(average_value)) AS average_value_1
	FROM t_Ilona_Splichalova_project_SQL_primary_final   
	GROUP BY year
), 
table2 AS (
	SELECT 
		year AS year_2, 
		ROUND(AVG(year_value),2) AS year_value_2, 
		ROUND(AVG(average_value)) AS average_value_2
	FROM t_Ilona_Splichalova_project_SQL_primary_final  
	GROUP BY year
)
SELECT 
	*, 
	ROUND((table2.year_value_2  - table1.year_value_1) / table1.year_value_1 * 100, 2) AS diff_year_value_percent,
	ROUND((table2.average_value_2  - table1.average_value_1) / table1.average_value_1 * 100, 2) AS diff_average_value_percent
FROM table1
JOIN table2 
	ON table1.year_1 = table2.year_2 - 1	
WHERE (table2.year_value_2  - table1.year_value_1) / table1.year_value_1 * 100 > (table2.average_value_2  - table1.average_value_1) / table1.average_value_1 * 100;