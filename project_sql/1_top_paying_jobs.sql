/*
Question: What are the top paying data analyst jobs?
    - Identify the top 10 highest paying data analyst roles that are available in Chicago, IL.
    - Focuses on job postings with specified salaries (remove nulls).
    - Why? Highlight the top paying opportunities for data analysts, offering insights into employment opportunities
*/

SELECT
      job_id
    , job_title
    , job_location
    , job_schedule_type
    , salary_year_avg
    , job_posted_date::DATE
    , company_dim.name AS company_name
FROM
    job_postings_fact jpc
LEFT JOIN company_dim
    ON company_dim.company_id = jpc.company_id
WHERE
    1 = 1
    AND job_title_short = 'Data Analyst'
    AND job_location = 'Chicago, IL'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;