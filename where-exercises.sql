-- 1A)
use employees;

-- 2A) Find all employees with first names 'Irena', 'Vidya', or 'Maya' 
-- 709 rows 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3A) Find all employees whose last name starts with 'E' 
-- 7,330 rows
SELECT *
FROM employees
WHERE last_name like 'E%';

-- 4A) Find all employees hired in the 90s 
-- 135,214 rows
SELECT *
FROM employees
WHERE hire_date LIKE '199%';

-- 5A) Find all employees born on Christmas
-- 842 rows
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

-- 6A) Find all employees with a 'q' in their last name 
-- 1,873 rows
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

-- 1B) Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN
-- 709 rows
SELECT *
FROM employees
WHERE first_name = 'Irena' 
   OR first_name = 'Vidya'
   OR first_name = 'Maya';
   
-- 2B) Add a condition to the previous query to find everybody with those names who is also male 
-- 441 rows
SELECT *
FROM employees
WHERE (
	     first_name = 'Irena' 
      OR first_name = 'Vidya'
      OR first_name = 'Maya')
   AND gender = 'M';
   
-- 3B) Find all employees whose last name starts or ends with 'E' 
-- 30,723 rows
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
   OR last_name LIKE '%e';

-- 4B) Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'
-- 899 rows.
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
  AND last_name LIKE '%e';
   
-- 5B) Find all employees hired in the 90s and born on Christmas 
-- 362 rows
SELECT *
FROM employees
WHERE hire_date like '199%'
 AND birth_date like '%12-25';

-- 6B) Find all employees with a 'q' in their last name but not 'qu' 
-- 547 rows
SELECT *
FROM employees
WHERE last_name like '%q%'
  AND last_name NOT LIKE '%qu%';