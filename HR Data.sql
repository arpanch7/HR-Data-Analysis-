SELECT * FROM hr_data.hrdata;
-- Employee Count
SELECT SUM(employee_count) AS 'Total Number of Employees'
FROM hrdata;
-- Attrition Count 
SELECT COUNT(attrition) AS 'Total Attrition'
FROM hrdata
where attrition='Yes';
-- Attrition rate 
SELECT ROUND(((SELECT COUNT(attrition) FROM hrdata WHERE attrition='Yes')/
SUM(employee_count))*100,2) AS 'Attrition Rate' FROM hrdata;
-- Number of Active Employees
SELECT SUM(employee_count)-(SELECT COUNT(attrition) FROM hrdata WHERE attrition='Yes')
FROM hrdata;
-- Average age 
SELECT ROUND(AVG(age),0) AS 'Average Employee Age'
FROM hrdata;
-- Attrition by gender 
SELECT gender AS Gender,COUNT(attrition) AS 'Total Attrition'
FROM hrdata 
WHERE attrition='Yes'
GROUP BY gender;
-- Attrition by department 
SELECT department,COUNT(attrition) AS 'Total Attriton'
FROM hrdata 
WHERE attrition='Yes'
GROUP BY department
ORDER BY COUNT(attrition) DESC;
-- Number of Employees by Age Group
SELECT age_band AS 'Age Group',COUNT(age_band)
FROM hrdata 
GROUP BY age_band 
ORDER BY count(age_band) DESC;
-- Education field wise attrition 
SELECT education_field AS 'Education Field',COUNT(attrition) AS 'Total Attrition'
FROM hrdata 
WHERE attrition='Yes'
GROUP BY education_field 
ORDER BY COUNT(attrition) DESC;
-- Age group wise attrition for different gender
SELECT age_band AS 'Age Group',(SELECT COUNT(attrition) FROM hrdata WHERE gender='Female' AND attrition='Yes') AS ' Number of Female Attrition',(SELECT COUNT(attrition) FROM hrdata WHERE gender='Male' AND attrition='Yes') AS ' Number of Male Attrition' 
FROM hrdata 
GROUP BY age_band;
-- Attrition rate by gender for different age group 
SELECT age_band AS 'Age Group',gender AS Gender,COUNT(attrition) AS Attrition,
ROUND((COUNT(attrition)/(SELECT COUNT(attrition) FROM hrdata where attrition='Yes'))*100,2) AS "Attrition Rate"
FROM hrdata
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;
-- Job Satisfaction Rating
SELECT job_role,
  SUM(CASE WHEN job_satisfaction = 1 THEN employee_count END) AS one,
  SUM(CASE WHEN job_satisfaction = 2 THEN employee_count END) AS two,
  SUM(CASE WHEN job_satisfaction = 3 THEN employee_count END) AS three,
  SUM(CASE WHEN job_satisfaction = 4 THEN employee_count END) AS four
FROM hrdata
GROUP BY job_role
ORDER BY job_role;
