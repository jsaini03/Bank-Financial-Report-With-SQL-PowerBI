/*EMPLOYMENT LENGTH ANLAYSIS: IDENTIFYING THE LENDING METRICS BASED ON EMPLOYMENT LENGTH OF BORROWER 
AND IF IT IMPACTS THE APPLICATION
*/

SELECT
	emp_length AS Emp_length,
	COUNT(id) AS Total_Loan_Applications,
	CONCAT('$ ', FORMAT(SUM(loan_amount),'N0')) AS Total_Funded_Amount,
	CONCAT('$ ', FORMAT(SUM(total_payment),'N0')) AS Total_Payment_Received
FROM financial_loan_data
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;