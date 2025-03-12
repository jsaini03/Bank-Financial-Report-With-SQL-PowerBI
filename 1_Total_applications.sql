/* CALCULATED THE TOTAL NUMBER OF LOAN APPLICATIONS RECEIVED DURING THE SPECIFIC PERIOD.
	AND ADDITIONALLY MONITORED THE MONTH-TO-DATE(MTD) LOAN APPLICATIONS AND TRACK CHANGES MONTH-OVER-MONTH (MoM) 
*/


-- TOTAL LOAN APPLICATIONS
SELECT COUNT(id) AS Total_Loan_Applications
FROM financial_loan_data

--MTD LOAN APPLICATIONS FOR THE LATEST MONTH WHICH IS DEC 2021
SELECT COUNT(id) AS MTD_Applications
FROM financial_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- MoM LOAN APPLICATIONS 
WITH MonthlyApplications AS (
	SELECT 
		FORMAT(issue_date, 'MMM') as MTD,
		MONTH(issue_date) as Month_num,
		COUNT(id) AS MTD_applications
	FROM financial_loan_data
	WHERE YEAR(issue_date)= 2021
	GROUP BY FORMAT(issue_date, 'MMM'), MONTH(issue_date)
)

SELECT 
	MTD,
	MTD_applications,
	LAG(MTD_applications) OVER (ORDER BY Month_Num) AS PMTD_Applications,
	CASE
		WHEN LAG(MTD_applications) OVER (ORDER BY Month_Num) IS NOT NULL 
        THEN
			CONCAT(
            ROUND(
			CAST( (MTD_applications - LAG(MTD_applications) OVER (ORDER BY Month_Num)) AS FLOAT) 
            / LAG(MTD_applications) OVER (ORDER BY Month_Num) * 100, 2
			), ' %')
        ELSE NULL 
    END AS MoM_change_percentage
FROM MonthlyApplications
ORDER BY Month_Num;
