/*
Loan Grid View
*/

SELECT 
	loan_status,
	FORMAT(COUNT(id),'N0') AS Total_Loan_Applications,
	CONCAT('$ ',FORMAT(SUM(total_payment),'N2')) as Total_Payments_Received,
	CONCAT('$ ',FORMAT(SUM(loan_amount),'N2')) as Total_Funded_Amount,
	CONCAT(ROUND(AVG(int_rate *100),4),' %') as Interest_Rate,
	CONCAT(ROUND(AVG(dti *100),4),' %') as DTI_Ratio
FROM financial_loan_data
GROUP BY loan_status;

--MTD GRID VIEW
SELECT 
	loan_status,
	FORMAT(COUNT(id),'N0') AS Total_Loan_Applications,
	CONCAT('$ ',FORMAT(SUM(total_payment),'N2')) as Total_Payments_Received,
	CONCAT('$ ',FORMAT(SUM(loan_amount),'N2')) as Total_Funded_Amount,
	CONCAT(ROUND(AVG(int_rate *100),4),' %') as Interest_Rate,
	CONCAT(ROUND(AVG(dti *100),4),' %') as DTI_Ratio
FROM financial_loan_data
WHERE MONTH(issue_date)=12 AND YEAR(issue_date)=2021
GROUP BY loan_status;
