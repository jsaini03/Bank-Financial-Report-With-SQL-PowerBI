/* REGIONAL ANALYSIS OF LOAN APPLICATIONS BY EACH STATE: TO IDENTIFY REGIONS WITH SIGNIFICANT LENDING ACTIVITIES AND ASSESS
REGIONAL DISPARITIES */

SELECT
	address_state as State,
	COUNT(id) AS Total_Loan_Applications,
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N0')) AS Total_Funded_Amount,
	CONCAT('$ ', FORMAT(SUM(total_payment),'N0')) AS Total_Payment_Received
FROM financial_loan_data
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC ;