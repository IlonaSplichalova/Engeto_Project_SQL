/*
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, 
pokud HDP vzroste výrazněji v jednom roce, 
projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
*/

CREATE OR REPLACE VIEW v_Ilona_Splichalova_GDP AS
	SELECT 
		t.payroll_year,
		average_value,
		year_value,
		GDP
	FROM t_Ilona_Splichalova_project_SQL_primary_final as t
	LEFT JOIN economies e ON e.`year` = t.`year`
	GROUP BY t.payroll_year;	

CREATE OR REPLACE VIEW v_Ilona_Splichalova_comparison AS 
	SELECT *, 
		LAG(GDP) OVER (ORDER BY average_value) AS GDP_last_year,
		LAG(average_value) OVER (ORDER BY average_value) AS average_value_last_year,
		LAG(year_value) OVER (ORDER BY average_value) AS year_value_last_year
	FROM v_Ilona_Splichalova_GDP
	ORDER BY payroll_year;

SELECT 
	payroll_year,
	ROUND((GDP - GDP_last_year) / GDP*100,2) AS GDP_difference,
	ROUND((average_value - average_value_last_year) / average_value*100,2) AS average_value_difference,
	ROUND((year_value - year_value_last_year) / year_value*100,2) AS year_value_difference
FROM v_Ilona_Splichalova_comparison 
WHERE GDP_last_year IS NOT NULL 
ORDER BY payroll_year;