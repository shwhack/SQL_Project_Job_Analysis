-- January
CREATE TABLE january_jobs AS
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT
        *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT
    job_posted_date
FROM
    march_jobs;

SELECT
      job_title_short
    , job_location
    , CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Columbus, OH' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact jpc;

SELECT
      COUNT(job_id) AS number_of_jobs
    , CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Chicago, IL' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact jpc
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;