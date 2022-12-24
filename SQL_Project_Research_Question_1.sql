/* 
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? 
*/

SELECT 
	DISTINCT payroll_year,
	industry_branch,
	code_type,
	year_value
FROM t_Ilona_Splichalova_project_SQL_primary_final 
WHERE code_type = 5958 AND calculation = "přepočtený" AND industry_branch IS NOT NULL
ORDER BY industry_branch, year;  

	

