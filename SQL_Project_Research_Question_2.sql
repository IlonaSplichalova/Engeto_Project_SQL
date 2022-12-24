/*
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a 
poslední srovnatelné období v dostupných datech cen a mezd?
*/

SELECT
	year,
	code_type,
	ROUND(year_value) AS avg_salary,
	unit,
	name,
	ROUND(average_value,2) AS avg_price,
	price_value,
	price_unit,
	CASE 
		WHEN NAME IN ("Mléko polotučné pasterované", "Chléb konzumní kmínový") THEN ROUND((year_value/average_value))
	END AS purchase_power
FROM t_Ilona_Splichalova_project_SQL_primary_final 
WHERE industry_branch IS NULL
	AND year IN (2006, 2018)  
	AND name IN ("Mléko polotučné pasterované", "Chléb konzumní kmínový")  
	AND code_type = "5958" 
	AND calculation = "přepočtený"
ORDER BY year, name DESC;

