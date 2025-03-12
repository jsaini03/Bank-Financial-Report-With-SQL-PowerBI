/*
CALCULATING AVERAGE INTEREST RATE TO GET INSIGHTS INTO LENDING PORTFOLIO
*/


SELECT CONCAT(ROUND(AVG(int_rate)*100, 4),'%') AS Average_interest_rate
FROM financial_loan_data;

--MTD AVERAGE INTEREST RATE

SELECT 
	CONCAT(ROUND(AVG(int_rate)*100, 4),'%') as MTD_int_rate
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;



--MoM CHANGES IN METRICS
WITH MonthlyIntRate AS (
	SELECT 
		FORMAT(issue_date, 'MMM') as Month_of_year,
		MONTH(issue_date) as Month_num,
		ROUND(AVG(int_rate)*100, 4) as MTD_int_rate
	FROM financial_loan_data
	WHERE YEAR(issue_date)= 2021
	GROUP BY FORMAT(issue_date, 'MMM'), MONTH(issue_date)
)

SELECT 
	Month_of_year,
	MTD_int_rate,
	CASE
		WHEN LAG(MTD_int_rate) OVER (ORDER BY Month_Num) IS NOT NULL 
		THEN LAG(MTD_int_rate) OVER (ORDER BY Month_Num) 
		ELSE NULL 
	END AS PMTD_int_rate,
	CASE
		WHEN LAG(MTD_int_rate) OVER (ORDER BY Month_Num) IS NOT NULL 
        THEN
			CONCAT(
            ROUND(
			CAST( (MTD_int_rate - LAG(MTD_int_rate) OVER (ORDER BY Month_Num)) AS FLOAT) 
            / LAG(MTD_int_rate) OVER (ORDER BY Month_Num) * 100, 2
			), '%')
        ELSE NULL 
    END AS MoM_change_percentage
FROM MonthlyIntRate
ORDER BY Month_Num;