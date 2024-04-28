/*
Question: What are the top skills based on salary?
    - Look for the average salary associated with each skill for data analyst positions.
    - Focuses on roles with specified salaries, regardless of location.
    - Why? It reveals how different skills impact salary levels for data analysts and
    helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
      skills
    , ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    1 = 1
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location IN ('Chicago, IL', 'Columbus, OH', 'Boston, MA', 'Philadelphia, PA', 'Anywhere')
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;