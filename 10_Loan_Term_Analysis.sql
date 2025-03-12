/*LOAN TERM ANALYSIS: TO ALLOW CLIENT TO UNDERSTAND THE DISTRIBUTION OF LOANS ACROSS VARIOUS TERM LENGTHS
*/

SELECT
	term AS Term_length,
	COUNT(id) AS Total_Loan_Applications,
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N0')) AS Total_Funded_Amount,
	CONCAT('$ ', FORMAT(SUM(total_payment),'N0')) AS Total_Payment_Received
FROM financial_loan_data
GROUP BY term
ORDER BY Total_Loan_Applications DESC;