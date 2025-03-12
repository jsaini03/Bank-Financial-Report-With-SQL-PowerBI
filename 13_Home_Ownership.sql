/*
HOME OWNERSHIP ANLAYSIS: IMPACT OF HOMEOWNERSHIP ON LOAN APPLICATIONS AND DISBURSEMENTS
*/


SELECT
	home_ownership as Home_Status,
	COUNT(id) AS Total_Loan_Applications,
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N0')) AS Total_Funded_Amount,
	CONCAT('$ ', FORMAT(SUM(total_payment),'N0')) AS Total_Payment_Received
FROM financial_loan_data
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;