/*
Question: What skills are required for the top paying data analyst jobs?
    - Use the top 10 highest paying data analyst jobs from the first query.
    - Add the specific skills required for these roles.
    - Why? It provides a detailed look at which high paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (
    SELECT
        job_id
        , job_title
        , salary_year_avg
        , company_dim.name AS company_name
    FROM
        job_postings_fact jpc
    LEFT JOIN company_dim
        ON company_dim.company_id = jpc.company_id
    WHERE
        1 = 1
        AND job_title_short = 'Data Analyst'
        AND job_location IN ('Chicago, IL', 'Columbus, OH', 'Boston, MA', 'Philadelphia, PA', 'Anywhere')
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
      top_paying_jobs.*
    , skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY
    salary_year_avg DESC;

/*
Here's the breakdown of the most demanded skills for data analysts in 2023, based on job postings in Chicago, IL:
SQL is the leading with a count of 7.
Python and Tableau are tied with a count of 6.
R follows closely with a count of 3.
Other skills such as Excel, Pandas, and Jupyter show varying degrees of demand.
*/