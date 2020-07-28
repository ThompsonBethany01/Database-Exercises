-- Create a file named temporary_tables.sql to do your work for this exercise.

SELECT * 
FROM emp_w_depts;

-- 1. Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE emp_w_depts(
SELECT *
FROM employees.employees_with_departments AS ewd
);

	-- Add a column named full_name to this table. 
		-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
		
ALTER TABLE emp_w_depts ADD full_name VARCHAR(31);
	
	-- Update the table so that full name column contains the correct data
	
UPDATE emp_w_depts
SET full_name = CONCAT(first_name, ' ', last_name);
	
	-- Remove the first_name and last_name columns from the table.
	
ALTER TABLE emp_w_depts DROP COLUMN first_name;
ALTER TABLE emp_w_depts DROP COLUMN last_name;

	-- What is another way you could have ended up with this same table?
	-- Create a query selecting this specific data, and then create the temporary table around it

-- 2. Create a temporary table based on the payment table from the sakila database.

SELECT *
FROM sakila_payment;

DESCRIBE sakila_payment;

CREATE TEMPORARY TABLE sakila_payment(
	SELECT *
	FROM sakila.payment AS sp);

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

ALTER TABLE sakila_payment ADD cent_amount INT(10);
UPDATE sakila_payment SET cent_amount = amount * 100;
ALTER TABLE sakila_payment DROP COLUMN amount;

-- 3. Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?

-- z-score = ((salary - average))/ stddev

-- first entry 60117
SELECT salary
FROM employees.salaries;

-- 63810.7448
SELECT AVG(salary)
FROM employees.salaries;

-- 16904.8283
SELECT STDDEV(salary)
FROM employees.salaries;

-- step 1: hard code z-score formula
SELECT ((60117 - 63810.7448)/16904.8283);

-- Step 2: insert stddev coding
SELECT ((60117 - 63810.7448)/(SELECT STDDEV(salary)
FROM employees.salaries));

-- Step 3: insert average salary coding
SELECT ((60117 - (SELECT AVG(salary)
FROM employees.salaries))/(SELECT STDDEV(salary)
FROM employees.salaries));

-- Step 4: insert salary value
SELECT emp_no, (((salary) - (SELECT AVG(salary)
FROM employees.salaries))/(SELECT STDDEV(salary)
FROM employees.salaries)) AS z_score
FROM employees.salaries;


-- Step 5: group by department

SELECT money.emp_no, dept_emp.dept_no, depts.dept_name, (((salary) - (SELECT AVG(salary)
	FROM employees.salaries))/(SELECT STDDEV(salary)
	FROM employees.salaries)) AS z_score
	FROM employees.salaries AS money
	JOIN employees.dept_emp AS dept_emp ON dept_emp.emp_no = money.emp_no
	JOIN employees.departments AS depts ON depts.dept_no = dept_emp.dept_no
	ORDER BY emp_no;

CREATE TEMPORARY TABLE z_scores(
	SELECT money.emp_no, dept_emp.dept_no, depts.dept_name, 
	(
		(
			(salary) 
		- 
			(SELECT AVG(salary) FROM employees.salaries)
		)
		/
		(SELECT STDDEV(salary) FROM employees.salaries)
	) AS z_score
	FROM employees.salaries AS money
	JOIN employees.dept_emp AS dept_emp ON dept_emp.emp_no = money.emp_no
	JOIN employees.departments AS depts ON depts.dept_no = dept_emp.dept_no
	ORDER BY emp_no);

-- z-scores for all historic salaries and department employees
SELECT dept_name, FORMAT(AVG(z_score), 6) AS salary_z_score
FROM z_scores
GROUP BY dept_name;

/*
+--------------------+-----------------+
| dept_name          | salary_z_score  | 
+--------------------+-----------------+
| Customer Service   | -0.273079       | 
| Development        | -0.251549       | 
| Finance            |  0.378261       | 
| Human Resources    | -0.467379       | 
| Marketing          |  0.464854       | 
| Production         | -0.24084        | 
| Quality Management | -0.379563       | 
| Research           | -0.236791       | 
| Sales              |  0.972891       | 
+--------------------+-----------------+
*/

 -- With only current salaries and department employees
CREATE TEMPORARY TABLE z_scores_current_salaries(
	SELECT money.emp_no, dept_emp.dept_no, depts.dept_name, (((salary) - (SELECT AVG(salary)
	FROM employees.salaries WHERE employees.salaries.to_date > CURDATE()))/(SELECT STDDEV(salary)
	FROM employees.salaries WHERE employees.salaries.to_date > CURDATE())) AS z_score
	FROM employees.salaries AS money
	JOIN employees.dept_emp AS dept_emp ON dept_emp.emp_no = money.emp_no AND dept_emp.to_date > CURDATE()
	JOIN employees.departments AS depts ON depts.dept_no = dept_emp.dept_no
	WHERE money.to_date > CURDATE()
	ORDER BY emp_no);

SELECT dept_name, FORMAT(AVG(z_score),6) AS salary_z_score
FROM z_scores_current_salaries
GROUP BY dept_name;
