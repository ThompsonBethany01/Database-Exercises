-- ________________________________Previuos Exercise__________________________________ --

-- Modify your first query to order by first name
-- The first result should be Irena Reutenauer and the last result should be Vidya Simmen.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- Update the query to order by first name and then last name
-- The first result should now be Irena Acton and the last should be Vidya Zweizig.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- Change the order by clause so that you order by last name before first name
-- Your first result should still be Irena Acton but now the last result should be Maya Zyda.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- Update your queries for employees with 'E' in their last name to sort the results by their employee number.
-- Your results should not change!
SELECT *
FROM employees
WHERE last_name like 'E%'
ORDER BY emp_no;

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
   OR last_name LIKE '%e'
ORDER BY emp_no;

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e'
ORDER BY emp_no;

-- Now reverse the sort order for both queries.
SELECT *
FROM employees
WHERE last_name like 'E%'
ORDER BY emp_no DESC;

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
   OR last_name LIKE '%e'
ORDER BY emp_no DESC;

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e'
ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. 
-- It should be Khun Bernini.
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC;

-- ______________________________Current Exercise___________________________________ -- 

use employees;

-- Copy the order by exercise and save it as functions_exercises.sql.
-- Update your queries for employees whose names start and end with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e'
ORDER BY emp_no ASC;

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
   OR last_name LIKE '%e'
ORDER BY emp_no;

-- Convert the names produced in your last query to all uppercase.

SELECT UPPER(CONCAT(first_name,' ',last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e'
ORDER BY emp_no DESC;

SELECT UPPER(CONCAT(first_name,' ',last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
   OR last_name LIKE '%e'
ORDER BY emp_no;

-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company 
-- (Hint: You will also need to use NOW() or CURDATE())

SELECT DATEDIFF(CURDATE(), hire_date) AS days_at_company, 
	   (DATEDIFF(CURDATE(), hire_date)/365) AS years_at_company,
       emp_no, 
       CONCAT(first_name, ' ',last_name) AS full_name,
       hire_date 
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC;

-- Find the smallest and largest salary from the salaries table.

SELECT MIN(salary) AS lowest_salary, MAX(salary) AS highest_salary
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees
-- A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born.

SELECT emp_no AS 'Employee Number', 
		LOWER(CONCAT(
			   SUBSTR(first_name,1,1), -- first 4 char in last name
               SUBSTR(last_name,1,4),  -- first 4 char in last name
               SUBSTR(birth_date,6,2), -- birth month
               "_",                    -- underscore
               SUBSTR(birth_date,3,2)  -- birth year
		)) AS 'Username', 
		CONCAT(first_name, ' ',last_name) AS 'Full Name', 
		birth_date AS 'Birthday'
FROM employees;
