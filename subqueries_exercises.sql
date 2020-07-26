-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

-- Find all the employees with the same hire date as employee 101010 using a sub-query.
-- 69 Rows

SELECT *
FROM employees
WHERE hire_date IN 
	(
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
	);

-- Find all the titles held by all employees with the first name Aamod.
-- 314 total titles, 6 unique titles

SELECT titles.title, CONCAT(employees.first_name, ' ', employees.last_name) AS 'full_name'
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
WHERE first_name IN
	(
	SELECT first_name
	FROM employees
	WHERE first_name = 'Aamod'
	)
ORDER BY titles.title;
	
SELECT DISTINCT titles.title
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
WHERE first_name IN
	(
	SELECT first_name
	FROM employees
	WHERE first_name = 'Aamod'
	);


-- How many people in the employees table are no longer working for the company?

SELECT COUNT(DISTINCT emp_no)
FROM dept_emp
WHERE to_date NOT IN 
	(
	SELECT to_date
	FROM dept_emp
	WHERE to_date > CURDATE()
	GROUP BY emp_no
	);

-- Find all the current department managers that are female.

/*
+------------+------------+
| first_name | last_name  |
+------------+------------+
| Isamu      | Legleitner |
| Karsten    | Sigstam    |
| Leon       | DasSarma   |
| Hilary     | Kambil     |
+------------+------------+
*/

SELECT CONCAT(first_name, ' ', last_name) AS female_managers
FROM dept_manager AS dman
JOIN employees AS emp ON emp.emp_no = dman.emp_no
WHERE gender IN
	(
	SELECT gender
	FROM employees
	WHERE gender = 'F'
	)
AND to_date > CURDATE();



-- Find all the employees that currently have a higher than average salary.
-- 154543 rows in total. Here is what the first 5 rows will look like:

SELECT emp.first_name, emp.last_name, salaries.salary
FROM salaries
JOIN employees AS emp ON emp.emp_no = salaries.emp_no
WHERE salary >
	(
	SELECT AVG(salary)
	FROM salaries
	)
AND to_date > CURDATE();

/*
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Georgi     | Facello   | 88958  |
| Bezalel    | Simmel    | 72527  |
| Chirstian  | Koblick   | 74057  |
| Kyoichi    | Maliniak  | 94692  |
| Tzvetan    | Zielinski | 88070  |
+------------+-----------+--------+
*/

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- 78 salaries

SELECT COUNT(salary)
FROM salaries
WHERE salary > 			   -- filters all salaries higher than (max salary - one standard deviation)
	(
		(
		SELECT MAX(salary) -- max salary
		FROM salaries
		)
	 -                     -- subtracted by
		(
		SELECT STD(salary) -- standard deviation
		FROM salaries
		)
	)
AND to_date > CURDATE()
;   -- filters out any outdated salaries


-- percentage based on all historic salaries
SELECT  
(
	(
		SELECT COUNT(salary)
		FROM salaries
		WHERE salary > 			   -- filters all salaries higher than (max salary - one standard deviation)
		(
			(
			SELECT MAX(salary) -- max salary
			FROM salaries
			)
	 	-                      -- subtracted by
			(
			SELECT STD(salary) -- standard deviation
			FROM salaries
			)
		)
		AND to_date > CURDATE()
	)
	/COUNT(salary) * 100		-- filters out any outdated salaries that after filtered with WHERE clause
) AS percentage
FROM salaries;

-- percentage of all current salaries
SELECT  
(
	(
		SELECT COUNT(salary)
		FROM salaries
		WHERE salary > 			   -- filters all salaries higher than (max salary - one standard deviation)
		(
			(
			SELECT MAX(salary) -- max salary
			FROM salaries
			)
	 	-                     -- subtracted by
			(
			SELECT STD(salary) -- standard deviation
			FROM salaries
			)
		)
		AND to_date > CURDATE()		-- filters out any outdated salaries that after filtered with WHERE clause
	)
	/COUNT(salary) * 100
) AS percentage
FROM salaries
WHERE to_date > CURDATE();			-- filters out any outdated salaries from the total salaries

-- We want salaries > MAX(salary) - STD(salary)


-- BONUS
-- Find all the department names that currently have female managers.



/*
+-----------------+
| dept_name       |
+-----------------+
| Development     |
| Finance         |
| Human Resources |
| Research        |
+-----------------+
*/

-- Find the first and last name of the employee with the highest salary.

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Tokuyasu   | Pesch     |
+------------+-----------+
*/

-- Find the department name that the employee with the highest salary works in.

/*
+-----------+
| dept_name |
+-----------+
| Sales     |
+-----------+
*/