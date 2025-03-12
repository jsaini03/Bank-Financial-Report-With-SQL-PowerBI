/* MONTHLY TRENDS BY ISSUE DATE: TO IDENTIFY THE SESONALITY AND LONG TERM TRENDS IN LENDING ACTIVITIES */

SELECT 
	
	DATENAME(MONTH, issue_date) AS Month,
	YEAR(issue_date) AS Year,
	COUNT(id) AS Total_Applications,
	CONCAT('$ ',FORMAT(SUM(loan_amount),'N0')) as Total_Funded_Amount,
	CONCAT('$ ',FORMAT(SUM(total_payment),'N0')) as Total_Payment_Received
FROM financial_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date), YEAR(issue_date)
ORDER BY MONTH(issue_date);