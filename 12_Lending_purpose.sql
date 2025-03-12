/*
LENDING BASED ON PURPOSE: LENDING OF MONEY BASED ON STATED PURPOSE, UNDERSTANDING PRIMARY REASONS FOR FINANCING 
*/


SELECT
	purpose AS Loan_Purpose,
	COUNT(id) AS Total_Loan_Applications,
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N0')) AS Total_Funded_Amount,
	CONCAT('$ ', FORMAT(SUM(total_payment),'N0')) AS Total_Payment_Received
FROM financial_loan_data
GROUP BY purpose
ORDER BY Total_Loan_Applications desc;