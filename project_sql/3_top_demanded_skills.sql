/*
Question: What are the most in-demand skills for data analysts who wants to work from home?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
Here's the breakdown of the most in-demand skills for data analysts, based on job postings:
- SQL is the undisputed leader, appearing in 7,291 job postings.
- Excel (4,611) and Python (4,330) follow closely as foundational core skills.
- Data visualization tools round out the top five, with Tableau leading at 3,745 and Power BI at 2,609.
*/