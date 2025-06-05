create database ai_job;
CREATE TABLE ai_job (
    job_id varchar(20) PRIMARY key,
    job_title TEXT not null,
    salary_usd INT,
    salary_currency TEXT,
    experience_level TEXT,
    employment_type TEXT,
    company_location TEXT,
    company_size TEXT,
    employee_residence TEXT,
    remote_ratio INT,
    required_skills TEXT,
    education_required TEXT,
    years_experience INT,
    industry TEXT,
    posting_date DATE,
    application_deadline DATE,
    job_description_length INT,
    benefits_score DECIMAL,
    company_name TEXT
);

select * from ai_job;

-- List all AI jobs with salary more than $100,000
select job_title, salary_usd from ai_job where salary_usd >100000;

--  Find the number of jobs by each experience level
select  experience_level, count(*) as Total_jobs from ai_job group by experience_level;

-- Show job titles and company_locations where remote work is 100%
select job_title, company_location from ai_job where remote_ratio = 100;

-- List all unique employment types
select distinct employment_type from ai_job;

-- Retrieve jobs that require a PhD degree
select job_title, education_required from ai_job where education_required = "PhD";

-- Count jobs available in each country
SELECT company_location, COUNT(*) as Availabel_jobs FROM ai_job GROUP BY company_location ORDER BY COUNT(*) DESC;

-- Find the average salary for each company size
select company_size, round(avg(salary_usd),2) as average_salary from ai_job group by company_size order by average_salary;

-- Which companies offer jobs with benefits score above 8?
select company_name, benefits_score from ai_job where  benefits_score >8  order by benefits_score desc;

-- Get top 5 highest paying job roles
SELECT job_title, salary_usd FROM ai_job ORDER BY salary_usd DESC LIMIT 5;

-- Find the average years of experience required for each job title
select job_title, round(avg(years_experience),0) as average_experience from ai_job group by job_title 
order by average_experience;

-- Get job roles that mention 'Python' in required skills
select job_title, required_skills  from ai_job where required_skills like '%Python%';

-- Count jobs posted each month
SELECT job_title, MONTH(posting_date) AS post_month, COUNT(*) AS jobs_count 
FROM ai_job 
GROUP BY post_month,job_title order by post_month;

-- Compare average salaries between Bachelor's and Master's required jobs
select education_required, round(avg(salary_usd),2) as avg_salary from ai_job where education_required in
('Bachelor','MAster') group by education_required;

-- Find jobs with application deadlines in next 15 days
SELECT job_id, job_title, application_deadline 
FROM ai_job 
WHERE application_deadline BETWEEN CURDATE() AND CURDATE() + INTERVAL 15 DAY 
order by application_deadline;

-- Show top 5 industries with highest average salary
SELECT industry, round(AVG(salary_usd),2) AS avg_salary 
FROM ai_job 
GROUP BY industry 
ORDER BY avg_salary DESC 
LIMIT 5;

-- Find the top company by number of remote jobs
SELECT company_name, COUNT(*) AS remote_jobs 
FROM ai_job 
WHERE remote_ratio = 100 
GROUP BY company_name 
ORDER BY remote_jobs DESC 
LIMIT 1;

-- Which experience level has the highest average benefits score?
SELECT experience_level, AVG(benefits_score) AS avg_benefit 
FROM ai_job 
GROUP BY experience_level 
ORDER BY avg_benefit DESC 
LIMIT 1;

-- Find the company with the longest average job descriptions
SELECT company_name, round(AVG(job_description_length),1) AS avg_desc_length 
FROM ai_job 
GROUP BY company_name 
ORDER BY avg_desc_length DESC 
LIMIT 1;

-- List all jobs where the posting date is older than 90 days
select job_title,posting_date from ai_job where
posting_date < current_date()- interval 90 day;

-- Get jobs in the ‘Media’ industry with experience level 'EN' (Entry)
SELECT job_title, company_name, salary_usd 
FROM ai_job 
WHERE industry = 'Media' AND experience_level = 'EN';