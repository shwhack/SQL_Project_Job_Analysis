/*
Question: What are the most in-demand skills for data analysts?
    - Join job postings to the inner join table similar to query 2.
    - Identify the top 5 in-demand skills for data analysts.
    - Focus on all job postings.
    - Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    *
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
LIMIT 5;