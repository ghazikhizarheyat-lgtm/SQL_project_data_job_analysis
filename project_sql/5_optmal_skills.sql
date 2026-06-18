/*
Question: What are the most optimal skills to learn (aka in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial upside (high salaries),
    offering strategic advice for career development
*/


WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
) ,    average_salary AS (
    SELECT
        skills_job_dim.skill_id, 
         ROUND (AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand 
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id 
WHERE 
    demand_count > 10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
    
    LIMIT 25

/*
Insights on the most optimal skills for data analysts (high demand & high salary):
- High-Value Programming & Cloud Skills: Go ($115,320) and Hadoop ($113,193) command 
the highest average salaries, despite lower overall demand counts.
- Cloud Platforms & Modern Data Warehouses: Cloud competencies like Snowflake ($112,948),
 Azure ($111,225), and AWS ($108,317) show a strong balance of high pay and consistent demand.
- Golden Standards for Job Security: Python (236 postings / $101,397), 
Tableau (230 postings / $99,288), and R (148 postings / $100,499) offer the absolute best 
combination of widespread job availability and six-figure salaries.
*/