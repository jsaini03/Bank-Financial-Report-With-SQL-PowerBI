/*
FINDING OUT THE TOTAL AMOUNT OF FUNDS DISBURSED AS LOANS, MTD TOTAL FUNDED AMOUNT AND MoM CHANGES IN METRICS
*/

SELECT 
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N2')) as Total_funded_amount
FROM financial_loan_data



--MTD TOTAL FUNDED AMOUNT FOR LATEST MONTH (DECEMBER 2021)
SELECT 
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N2')) as MTD_funded_amount
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;



--MoM CHANGES IN METRICS
WITH MonthlyAmount AS (
	SELECT 
		FORMAT(issue_date, 'MMM') as MTD,
		MONTH(issue_date) as Month_num,
		SUM(loan_amount) as MTD_loan_amount
	FROM financial_loan_data
	WHERE YEAR(issue_date)= 2021
	GROUP BY FORMAT(issue_date, 'MMM'), MONTH(issue_date)
)

SELECT 
	MTD,
	CONCAT('$ ', FORMAT(MTD_loan_amount, 'N2')) as MTD_loan_amount,
	CASE
		WHEN LAG(MTD_loan_amount) OVER (ORDER BY Month_Num) IS NOT NULL 
		THEN CONCAT('$ ', FORMAT(LAG(MTD_loan_amount) OVER (ORDER BY Month_Num), 'N2')) 
		ELSE NULL 
	END AS PMTD_loan_amount,
	CASE
		WHEN LAG(MTD_loan_amount) OVER (ORDER BY Month_Num) IS NOT NULL 
        THEN
			CONCAT(
            ROUND(
			CAST( (MTD_loan_amount - LAG(MTD_loan_amount) OVER (ORDER BY Month_Num)) AS FLOAT) 
            / LAG(MTD_loan_amount) OVER (ORDER BY Month_Num) * 100, 2
			), ' %')
        ELSE NULL 
    END AS MoM_change_percentage
FROM MonthlyAmount
ORDER BY Month_Num;