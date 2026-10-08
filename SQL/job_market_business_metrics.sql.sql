use job_market_analytics;

-- Market Size: Total Job Postings (Query 1)
SELECT
COUNT(*) AS total_job_postings,
COUNT(DISTINCT company_name) AS unique_companies,
COUNT(DISTINCT job_title) AS unique_job_roles,
COUNT(DISTINCT primary_city_clean) AS hiring_cities,
ROUND(100.0 * SUM(CASE WHEN salary_disclosed = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS salary_disclosure_rate,
ROUND(AVG(salary_midpoint_clean), 2) AS average_salary_lpa,
ROUND(AVG(experience_midpoint_clean), 2) AS average_experience_years,
ROUND(AVG(skills_count_clean), 2) AS average_skills_per_job,
ROUND(100.0 * SUM(CASE WHEN is_fresher_friendly = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS fresher_opportunity_rate
FROM job_market_cleaned;

-- Hiring Demand: Role Market Share (Query 2)
SELECT
role_category,
COUNT(*) AS job_postings,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS market_share_percent
FROM job_market_cleaned
GROUP BY role_category
ORDER BY job_postings DESC;

-- Geography: City Hiring Share (Query 4)
SELECT
primary_city_clean AS city,
COUNT(*) AS job_postings,
COUNT(DISTINCT company_name) AS companies_hiring,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS market_share_percent
FROM job_market_cleaned
GROUP BY primary_city_clean
ORDER BY job_postings DESC;

-- Companies: Top Hiring Companies (Query 20)
SELECT
company_name,
COUNT(*) AS job_postings,
COUNT(DISTINCT role_category) AS roles_hiring,
COUNT(DISTINCT primary_city_clean) AS cities_hiring
FROM job_market_cleaned
GROUP BY company_name
ORDER BY job_postings DESC
LIMIT 20;

-- Skills: Top 20 In-Demand Skills (Query 17)
SELECT
skill,
COUNT(DISTINCT job_id) AS jobs_requiring_skill,
ROUND(100.0 * COUNT(DISTINCT job_id) / (SELECT COUNT(*) FROM job_market_cleaned), 2) AS job_demand_percentage
FROM job_market_skill_table
GROUP BY skill
ORDER BY jobs_requiring_skill DESC
LIMIT 20;

-- Salary: Average Salary by Role (Query 8)
SELECT
role_category,
COUNT(*) AS jobs_with_salary,
ROUND(AVG(salary_midpoint_clean), 2) AS average_salary_lpa,
ROUND(MIN(salary_midpoint_clean), 2) AS minimum_salary_lpa,
ROUND(MAX(salary_midpoint_clean), 2) AS maximum_salary_lpa
FROM job_market_cleaned
WHERE salary_midpoint_clean IS NOT NULL
GROUP BY role_category
HAVING COUNT(*) >= 5
ORDER BY average_salary_lpa DESC;

-- Experience: Experience vs Salary (Query 10)
SELECT
ROUND(experience_midpoint_clean, 0) AS experience_years,
COUNT(*) AS job_postings,
ROUND(AVG(salary_midpoint_clean), 2) AS average_salary_lpa
FROM job_market_cleaned
WHERE experience_midpoint_clean IS NOT NULL
AND salary_midpoint_clean IS NOT NULL
GROUP BY ROUND(experience_midpoint_clean, 0)
ORDER BY experience_years;

-- Freshers: Fresher Opportunity Rate (Query 12)
SELECT
COUNT(*) AS total_jobs,
SUM(CASE WHEN is_fresher_friendly = TRUE THEN 1 ELSE 0 END) AS fresher_friendly_jobs,
ROUND(100.0 * SUM(CASE WHEN is_fresher_friendly = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS fresher_opportunity_rate
FROM job_market_cleaned;

-- Work Mode: Work Mode Market Share (Query 15)
SELECT
work_mode_clean AS work_mode,
COUNT(*) AS job_postings,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS market_share_percent
FROM job_market_cleaned
GROUP BY work_mode_clean
ORDER BY job_postings DESC;

-- Transparency: Salary Disclosure Rate (Query 22)
SELECT
role_category,
COUNT(*) AS total_jobs,
SUM(CASE WHEN salary_disclosed = TRUE THEN 1 ELSE 0 END) AS jobs_with_salary,
ROUND(100.0 * SUM(CASE WHEN salary_disclosed = TRUE THEN 1 ELSE 0 END) / COUNT(*), 2) AS salary_disclosure_rate
FROM job_market_cleaned
GROUP BY role_category
HAVING COUNT(*) >= 5
ORDER BY salary_disclosure_rate DESC;

-- Company Size: Hiring by Company Size (Query 25)
SELECT
company_size_bucket,
COUNT(*) AS job_postings,
COUNT(DISTINCT company_name) AS companies,
ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS market_share_percent,
ROUND(AVG(salary_midpoint_clean), 2) AS average_salary_lpa
FROM job_market_cleaned
GROUP BY company_size_bucket
ORDER BY job_postings DESC;

-- Career Opportunity: High-Demand + High-Salary Roles (Query 28)
WITH role_metrics AS (
SELECT
role_category,
COUNT(*) AS job_postings,
AVG(salary_midpoint_clean) AS average_salary_lpa
FROM job_market_cleaned
WHERE salary_midpoint_clean IS NOT NULL
GROUP BY role_category
)
SELECT
role_category,
job_postings,
ROUND(average_salary_lpa, 2) AS average_salary_lpa
FROM role_metrics
WHERE job_postings >= 5
ORDER BY job_postings DESC, average_salary_lpa DESC;