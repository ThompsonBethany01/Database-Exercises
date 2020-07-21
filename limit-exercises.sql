-- Use employees
use employees;

-- List the first 10 distinct last names sorted in descending order
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql
-- Update it to find just the first 5 employees.
	-- |5B) Find all employees hired in the 90s and born on Christmas 
	-- |362 rows
	-- |SELECT *
	-- |FROM employees
	-- |WHERE hire_date like '199%'
    -- |AND birth_date like '%12-25';
      
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
  AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

-- Try to think of your results as batches, sets, or pages
-- The first five results are your first page
-- The five after that would be your second page, etc.
-- Update the query to find the tenth page of results
-- Page 10 would be results of pages 45-50
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
  AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;

-- LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
-- OFFEST is the index value of the page
-- LIMIT is items per page
-- OFFSET = (Page #)(LIMIT)-(LIMIT)
-- OFFSET = LIMIT(Page# - 1)