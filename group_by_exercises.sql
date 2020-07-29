-- Create a new file named group_by_exercises.sql
-- In your script, use DISTINCT to find the unique titles in the titles table.

SELECT DISTINCT title
FROM titles;

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY last_name ASC;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. You should get 846 rows.

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%e'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'.

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
  AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others

SELECT last_name AS 'Unique_Last_Name', COUNT(last_name) AS 'Name_Count'
FROM employees
 WHERE last_name LIKE '%q%'
   AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT COUNT(first_name) AS 'Name_Count', gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- Recall the query that generated usernames for the employees from the last lesson. Are there any duplicate usernames?
-- There are duplicates because SELECT with DISTINCT != SELECT without DISTINCT

-- 300,024 rows
SELECT 
		LOWER(CONCAT(
			   SUBSTR(first_name,1,1), -- first char in first name
               SUBSTR(last_name,1,4),  -- first 4 char in last name
               '_',					   -- underscore
               SUBSTR(birth_date,6,2), -- birth month                  
               SUBSTR(birth_date,3,2)  -- birth year
		)) AS 'Username',
		CONCAT(first_name, ' ',last_name) AS 'Full Name', 
		birth_date AS 'Birthday'
FROM employees;

-- 285872 rows
SELECT DISTINCT LOWER(CONCAT(
			    SUBSTR(first_name,1,1), -- first 4 char in last name
                SUBSTR(last_name,1,4),  -- first 4 char in last name
                SUBSTR(birth_date,6,2), -- birth month
                "_",                    -- underscore
                SUBSTR(birth_date,3,2)  -- birth year
		)) AS 'Username'
FROM employees;
-- another way to see if duplicates

SELECT username, COUNT(*) AS records
FROM 
(
	(SELECT 
		CONCAT
		(
			LOWER(SUBSTR(first_name, 1, 1)), 
			LOWER(SUBSTR(last_name, 1, 4)), 
			"_", 
			SUBSTR(birth_date, 6, 2), 
			SUBSTR(birth_date, 3, 2)
		) AS username, 
		first_name, last_name, birth_date
        FROM employees
     ) AS temp)
GROUP by username
ORDER BY records DESC;
-- Bonus: how many duplicate usernames are there?
-- 300,024 minus 285,872 = 14,152 turns out to be wrong lol \/

-- Finding answer programaticaly...

SELECT sum(temp.username_count)
FROM (
        SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), "_", SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)) AS username, COUNT(*) as username_count
        FROM employees
        GROUP BY username
        ORDER BY username_count DESC
) as temp
WHERE username_count > 1;