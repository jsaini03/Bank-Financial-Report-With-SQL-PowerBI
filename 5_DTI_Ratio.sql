/*
EVALUATING THE AVERAGE DEBT-TO-INCOME RATIO (DTI) FOR THE BORROWERS TO HELP US GAUGE THEIR FINANCIAL HEALTH. 
DTI= TOTAL MONTHLY PAYMENTS/GROSS MONTHLY INCOME *100
DTI SHOULD BE LOW AS IT CONFIRMS FINANCIAL STABILITY, HIGHER LOAN APPROVAL CHANCES, BETTER INT RATES.
Below 36% – Generally considered ideal for mortgage or loan approvals.
36% to 43% – Acceptable, but may require stronger credit or higher down payments.
Above 43% – Considered high risk, making it difficult to get loans or favorable terms.
COMPUTING AVERAGE DTI, MTD AND MoM FLUCTUATIONS
*/

SELECT * FROM financial_loan_data;

SELECT 
	ROUND(AVG(dti)*100, 4) AS Average_dti_ratio
FROM financial_loan_data;

--MTD AVERAGE INTEREST RATE

SELECT 
	ROUND(AVG(dti)*100, 4) as MTD_dti
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;



--MoM CHANGES IN METRICS
WITH MonthlyDTI AS (
	SELECT 
		FORMAT(issue_date, 'MMM') as Month_of_year,
		MONTH(issue_date) as Month_num,
		ROUND(AVG(dti)*100, 4) as MTD_dti
	FROM financial_loan_data
	WHERE YEAR(issue_date)= 2021
	GROUP BY FORMAT(issue_date, 'MMM'), MONTH(issue_date)
)

SELECT 
	Month_of_year,
	MTD_dti,
	CASE
		WHEN LAG(MTD_dti) OVER (ORDER BY Month_Num) IS NOT NULL 
		THEN LAG(MTD_dti) OVER (ORDER BY Month_Num) 
		ELSE NULL 
	END AS PMTD_dti,
	CASE
		WHEN LAG(MTD_dti) OVER (ORDER BY Month_Num) IS NOT NULL 
        THEN
			CONCAT(
            ROUND(
			CAST( (MTD_dti - LAG(MTD_dti) OVER (ORDER BY Month_Num)) AS FLOAT) 
            / LAG(MTD_dti) OVER (ORDER BY Month_Num) * 100, 2
			), '%')
        ELSE NULL 
    END AS MoM_change_percentage
FROM MonthlyDTI
ORDER BY Month_Num;