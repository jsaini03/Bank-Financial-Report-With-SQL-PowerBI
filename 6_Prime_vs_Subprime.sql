/*
COMPARING THE 'PRIME' AND 'SUBPRIME' LOAN APPLICATIONS WITH PERCENTAGE
PRIME LOAN APPLICATIONS - REQUEST FOR A LOAN FROM LENDER FOR A BORROWER WITH GOOD CREDIT SCORE
SUBPRIME LOAN APPLICATIONS - REFERS TO LOANS FOR BORROWERS WITH HIGH RISK OF DEFAULT
*/

SELECT * FROM financial_loan_data;

--Total prime and subprime applications

SELECT 
	FORMAT(COUNT(CASE WHEN loan_status= 'Fully Paid' OR loan_status= 'Current'THEN id END),'N0') as Total_Prime_App,
	FORMAT(COUNT(CASE WHEN loan_status= 'Charged Off' THEN id END),'N0') as Total_Subprime_App
FROM financial_loan_data;


-- %age of prime and subprime applications

SELECT 
	CONCAT(
		COUNT(CASE WHEN loan_status= 'Fully Paid' OR loan_status= 'Current'THEN id END)*100 / 
		COUNT(id) , '%') AS Prime_applications,
	CONCAT(
		COUNT(CASE WHEN loan_status= 'Charged Off' THEN id END)*100 / 
		COUNT(id) , '%') AS SubPrime_applications
	
FROM financial_loan_data;

--Prime & Subprime Loan Funded Amount

SELECT 
	CONCAT('$ ',
		FORMAT(SUM(CASE WHEN loan_status= 'Fully Paid' OR loan_status= 'Current'THEN loan_amount END ), 'N2')
		)
		AS Prime_Loan_Funded_Amount,
	CONCAT('$ ',
		FORMAT(SUM(CASE WHEN loan_status= 'Charged Off' THEN loan_amount END),'N2')
		)
		AS Subprime_Loan_Funded_Amount
FROM financial_loan_data;

-- Prime & Subprime Loan Payments Received

SELECT 
	CONCAT('$ ',
		FORMAT(SUM(CASE WHEN loan_status= 'Fully Paid' OR loan_status= 'Current'THEN total_payment END ), 'N2')
		)
		AS Prime_Loan_Payment_Received,
	CONCAT('$ ',
		FORMAT(SUM(CASE WHEN loan_status= 'Charged Off' THEN total_payment END),'N2')
		)
		AS Subprime_Loan_Payment_Received
FROM financial_loan_data;