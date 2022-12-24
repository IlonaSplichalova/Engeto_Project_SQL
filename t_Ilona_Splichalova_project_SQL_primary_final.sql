CREATE OR REPLACE TABLE t_Ilona_Splichalova_project_SQL_primary_final AS  
	WITH adjusted_czechia_payroll AS (
		SELECT 
			cpvt.code AS code_type,	
			AVG(cp.value) AS year_value,
			cpu.name AS unit,
			cpib.name AS industry_branch,
			cpc.name AS calculation,
			cp.payroll_year	
		FROM czechia_payroll cp 
		LEFT JOIN czechia_payroll_calculation cpc ON cp.calculation_code = cpc.code
		LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code 
		LEFT JOIN czechia_payroll_unit cpu ON cp.unit_code = cpu.code
		LEFT JOIN czechia_payroll_value_type cpvt ON cp.value_type_code = cpvt.code
		GROUP BY code_type, Unit, industry_branch, cpc.name, cp.payroll_year 
		),
		adjusted_czechia_price AS (
		SELECT 
			AVG(cpr.value) AS average_value,
			YEAR(cpr.date_from) AS year,
			cpc.name,
			cpc.price_value,
			cpc.price_unit,
			cpr.region_code
		FROM czechia_price cpr
		LEFT JOIN czechia_price_category cpc on cpr.category_code = cpc.code
		WHERE region_code IS NULL
		GROUP BY year, cpc.name, cpc.price_value, cpc.price_unit, cpr.region_code
		)
	SELECT  
		code_type,	
		year_value,
		unit,
		industry_branch,
		calculation,
		payroll_year,
		average_value,
		year,
		name,
		price_value,
		price_unit
	FROM adjusted_czechia_payroll AS acp
	INNER JOIN adjusted_czechia_price AS acpr ON acpr.year = acp.payroll_year;	


 