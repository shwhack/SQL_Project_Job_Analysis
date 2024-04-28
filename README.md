# Introduction

Dive into the data job market. Focusing on data analyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

This project was taken on to analyze the job market for data analyst jobs to determine what skills are ultimately the most requested and highest paid.

## The questions I wanted to answer through my SQL queries were:
1. What are the top paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
   
# Tools I Used

For this analysis of the data analyst job market (2023), the follow tools were utilized: 

- SQL
- PostgreSQL
- Visual Studio Code
- Git & GitHub

# The Analysis

Each query answers a specific question about the data analyst job market to garner insights into the data.

## Top Paying Data Analyst Jobs
```sql
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
    AND job_location IN ('Chicago, IL', 'Columbus, OH', 'Boston, MA', 'Philadelphia, PA', 'Anywhere')
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

## Top Paying Job Skills
```sql
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
```

## Top Demanded Skills
```sql
SELECT
      skills
    , COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim
    ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    1 = 1
    AND job_title_short = 'Data Analyst'
    AND job_location IN ('Chicago, IL', 'Columbus, OH', 'Boston, MA', 'Philadelphia, PA', 'Anywhere')
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

| skills    | demand_count |
|-----------|--------------|
| sql       | 9465         |
| excel     | 6268         |
| python    | 5597         |
| tableau   | 4921         |
| power bi  | 3335         |


## Top Paying Skills
```sql
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
```

| skills        | avg_salary  |
|---------------|-------------|
| dplyr         | 225000.00   |
| bitbucket     | 189154.50   |
| solidity      | 179000.00   |
| hugging face  | 175000.00   |
| tensorflow    | 175000.00   |
| pyspark       | 172836.13   |
| splunk        | 165000.00   |
| watson        | 160515.00   |
| couchbase     | 160515.00   |
| datarobot     | 155485.50   |
| gitlab        | 154500.00   |
| swift         | 153750.00   |
| pandas        | 147030.15   |
| golang        | 145000.00   |
| elasticsearch| 145000.00   |
| jupyter       | 141904.21   |
| numpy         | 141080.36   |
| react         | 140500.00   |
| pytorch       | 140000.00   |
| rust          | 138250.00   |
| atlassian     | 134301.50   |
| db2           | 134112.64   |
| kubernetes    | 132500.00   |
| unify         | 132500.00   |
| databricks    | 131540.43   |


## Most Optimal Skills
```sql
SELECT
      skills_dim.skill_id
    , skills_dim.skills
    , COUNT(skills_job_dim.job_id) AS demand_count
    , ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    1 = 1
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location IN ('Chicago, IL', 'Columbus, OH', 'Boston, MA', 'Philadelphia, PA', 'Anywhere')
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
      avg_salary DESC
    , demand_count DESC
LIMIT 25;
```

| skill_id | skills       | demand_count | avg_salary |
|----------|--------------|--------------|------------|
| 93       | pandas       | 13           | 147030.15  |
| 75       | databricks   | 14           | 131540.43  |
| 97       | hadoop       | 29           | 116559.88  |
| 234      | confluence   | 11           | 114209.91  |
| 80       | snowflake    | 50           | 114189.68  |
| 3        | scala        | 11           | 113471.82  |
| 8        | go           | 37           | 112176.68  |
| 74       | azure        | 45           | 111647.86  |
| 76       | aws          | 46           | 110346.54  |
| 77       | bigquery     | 15           | 110315.00  |
| 184      | dax          | 17           | 110147.06  |
| 201      | alteryx      | 24           | 108477.38  |
| 78       | redshift     | 25           | 106113.22  |
| 4        | java         | 20           | 104436.18  |
| 13       | c++          | 13           | 104118.50  |
| 79       | oracle       | 58           | 103626.87  |
| 185      | looker       | 56           | 103551.24  |
| 233      | jira         | 22           | 102425.36  |
| 1        | python       | 321          | 101695.96  |
| 92       | spark        | 19           | 101342.11  |
| 194      | ssis         | 20           | 100712.60  |
| 5        | r            | 200          | 99985.40   |
| 2        | nosql        | 14           | 99169.89   |
| 61       | sql server   | 56           | 97990.17   |
| 182      | tableau      | 305          | 97910.79   |


# What I Learned

TODO: Complete

# Conclusions

## Insights

TODO: Complete

## Closing Thoughts

TODO: Complete