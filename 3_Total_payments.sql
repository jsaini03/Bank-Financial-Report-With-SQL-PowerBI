/*
TRACKING THE TOTAL AMOUNT RECEIVED FROM THE BORROWERS TO ASSESSING THE BANK’S CASH FLOW AND LOAN REPAYMENT
ALONGWITH MTD AND MoM CHANGES
*/

SELECT 
	CONCAT('$ ', FORMAT(SUM(total_payment),'N2')) as Total_received_amount
FROM financial_loan_data



--MTD TOTAL RECEIVED AMOUNT FOR LATEST MONTH (DECEMBER 2021)
SELECT 
	CONCAT('$ ', FORMAT(SUM(total_payment),'N2')) as MTD_received_amount
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)= 2021;



--MoM CHANGES IN METRICS
WITH MonthlyAmount AS (
	SELECT 
		FORMAT(issue_date, 'MMM') as Month_of_year,
		MONTH(issue_date) as Month_num,
		SUM(total_payment) as MTD_received_payment
	FROM financial_loan_data
	WHERE YEAR(issue_date)= 2021
	GROUP BY FORMAT(issue_date, 'MMM'), MONTH(issue_date)
)

SELECT 
	Month_of_year,
	CONCAT('$ ', FORMAT(MTD_received_payment, 'N2')) as MTD_received_payment,
	CASE
		WHEN LAG(MTD_received_payment) OVER (ORDER BY Month_Num) IS NOT NULL 
		THEN CONCAT('$ ', FORMAT(LAG(MTD_received_payment) OVER (ORDER BY Month_Num), 'N2')) 
		ELSE NULL 
	END AS PMTD_received_payment,
	CASE
		WHEN LAG(MTD_received_payment) OVER (ORDER BY Month_Num) IS NOT NULL 
        THEN
			CONCAT(
            ROUND(
			CAST( (MTD_received_payment - LAG(MTD_received_payment) OVER (ORDER BY Month_Num)) AS FLOAT) 
            / LAG(MTD_received_payment) OVER (ORDER BY Month_Num) * 100, 2
			), ' %')
        ELSE NULL 
    END AS MoM_change_percentage
FROM MonthlyAmount
ORDER BY Month_Num;