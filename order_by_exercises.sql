-- 1A)
use employees;

-- 2A) Find all employees with first names 'Irena', 'Vidya', or 'Maya' 
-- Modify your first query to order by first name. 
-- The first result should be Irena Reutenauer and the last result should be Vidya Simmen
-- 709 rows 
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

-- Update the query to order by first name and then last name
-- The first result should now be Irena Acton and the last should be Vidya Zweizig
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

-- 3A) Find all employees whose last name starts with 'E' 
-- 7,330 rows
-- Update your queries for employees with 'E' in their last name to sort the results by their employee number.
-- Your results should not change!
SELECT *
FROM employees
WHERE last_name like 'E%'
ORDER BY emp_no;

-- Now reverse the sort order for both queries.
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC;

SELECT *
FROM employees
WHERE last_name like 'E%'
ORDER BY emp_no DESC;

-- Change the query for employees hired in the 90s and born on Christmas: the first result is the oldest employee who was hired last. 
-- It should be Khun Bernini
-- 5B) Find all employees hired in the 90s and born on Christmas 
-- 362 rows
SELECT *
FROM employees
WHERE hire_date like '199%'
 AND birth_date like '%12-25'
 ORDER BY birth_date ASC, hire_date DESC;
