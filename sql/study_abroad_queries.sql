-- 1. Total Number of Countries.
SELECT COUNT(DISTINCT "Country") AS total_countries
FROM data;

-- 2. Average Annual Study Cost For Each Country.
SELECT "Country", Round(AVG("Total_Annual_Cost_USD"), 2)  AS avg_annual_cost
FROM data 
GROUP BY "Country" 
ORDER BY Avg_Annual_Cost;

-- 3. Top 5 Countries with the Lowest Annual Study Cost.
SELECT "Country", ROUND(AVG("Total_Annual_Cost_USD"), 2) AS avg_annual_cost
FROM data
GROUP BY "Country"
ORDER BY avg_annual_cost LIMIT 5;

-- 4. Average Graduate Salary For Each Country.
SELECT "Country", ROUND(AVG("Average_Graduate_Salary_USD"),2) AS avg_salary
FROM data
GROUP BY "Country" ORDER BY avg_salary;

-- 5. Top 5 Countries with the Highest Graduate Salaries.
SELECT "Country", ROUND(AVG("Average_Graduate_Salary_USD"),2) AS avg_salary 
FROM data 
GROUP BY "Country" ORDER BY avg_salary DESC LIMIT 5;

-- 6. Average ROI for Each Country.
SELECT
    "Country",
    ROUND(AVG("ROI")::numeric, 2) AS avg_roi
FROM data
GROUP BY "Country"
ORDER BY avg_roi;

-- 7. Rank countries based on ROI.
SELECT "Country", Round(AVG("ROI")::numeric, 2) AS avg_roi, RANK() OVER (ORDER BY AVG("ROI") DESC) AS roi_rank 
FROM data
GROUP BY "Country";

-- 8. VISA Success Rate for Each Country.
SELECT "Country", ROUND(AVG("Visa_Success")::numeric,2) AS visa_success_rate 
FROM data
GROUP BY "Country" ORDER BY visa_success_rate DESC;

-- 9. Ranking Countries Based on Scholarship Opportunities.
SELECT "Country", ROUND(AVG("Scholarships_Available")::numeric,2) AS avg_scholarships,
RANK() OVER(ORDER BY AVG("Scholarships_Available") DESC) AS scholarship_rank 
FROM data
GROUP BY "Country";

-- 10. Countries with the Highest Visa Success Rates.
SELECT "Country", ROUND(AVG("Visa_Success")::numeric,2) AS visa_success_rate 
FROM data 
GROUP BY "Country" ORDER BY visa_success_rate DESC LIMIT 5;

-- 11. Average Scholarship Amount for Each Country.
SELECT "Country", ROUND(AVG("Scholarships_Available")::numeric,2) AS avg_scholarships 
FROM data
GROUP BY "Country" ORDER BY avg_scholarships DESC;

-- 12. Best Country for Students Seeking High Salaries after Graduation.
SELECT "Country", ROUND(AVG("Average_Graduate_Salary_USD")::numeric,2) AS avg_salary 
FROM data
GROUP BY "Country" ORDER BY avg_salary DESC LIMIT 1;

-- 13. Find Countries that offer the Best Value for Money
-- (Higher-than-average graduate salary and lower-than-average annual study cost)
SELECT
    "Country",
    ROUND(AVG("Average_Graduate_Salary_USD")::numeric, 2) AS avg_salary,
    ROUND(AVG("Total_Annual_Cost_USD")::numeric, 2) AS avg_cost
FROM data
GROUP BY "Country"
HAVING AVG("Average_Graduate_Salary_USD") >
       (SELECT AVG("Average_Graduate_Salary_USD") FROM data)
   AND AVG("Total_Annual_Cost_USD") <
       (SELECT AVG("Total_Annual_Cost_USD") FROM data)
	   
-- 14. Best Country for International Students based on ROI and Affordability.
SELECT "Country", ROUND(AVG("ROI")::numeric,2) AS roi, ROUND(AVG("Affordability")::numeric,2) AS affordability 
FROM data
GROUP BY "Country" ORDER BY AVG("ROI") DESC,
AVG("Affordability") DESC LIMIT 1;

-- 15. Country Summary Report:
SELECT
    "Country",
    ROUND(AVG("Total_Annual_Cost_USD")::numeric,2) AS average_cost,
    ROUND(AVG("Average_Graduate_Salary_USD")::numeric,2) AS average_salary,
    ROUND(AVG("ROI")::numeric,2) AS roi,
    ROUND(AVG("Visa_Success")::numeric,2) AS visa_success_rate,
    ROUND(AVG("Scholarships_Available")::numeric,2) AS scholarships,
    ROUND(AVG("Affordability")::numeric,2) AS affordability_score
FROM data
GROUP BY "Country"
ORDER BY "Country";
