-- Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT e.emp_no, de.dept_no, de.from_date, de.to_date,
	CASE
		WHEN (to_date > CURDATE()) THEN 1
		ELSE 0
		END AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
ORDER BY e.emp_no;

-- 2. Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	CASE
		WHEN SUBSTR(last_name, 1, 1) <= 'H' THEN 'A-H'
		WHEN SUBSTR(last_name, 1, 1) >= 'I' AND SUBSTR(last_name, 1, 1) <= 'Q' THEN 'I-Q'
		WHEN SUBSTR(last_name, 1, 1) >= 'R' AND SUBSTR(last_name, 1, 1) <= 'Z' THEN 'R-Z'
		ELSE `last_name`
		END as alpha_group
FROM employees
ORDER BY last_name;

-- 3. How many employees were born in each decade?

SELECT COUNT(birth_date) AS total_employees,
	CASE
		WHEN birth_date LIKE '194%' THEN '40s'
		WHEN birth_date LIKE '195%' THEN '50s'
		WHEN birth_date LIKE '196%' THEN '60s'
		WHEN birth_date LIKE '197%' THEN '70s'
		END AS decade
FROM employees
GROUP BY decade;

-- ____________________BONUS_______________________

-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

-- Step 1: Combine specified groups

SELECT dept_name,		CASE 			WHEN dept_name IN ('research', 'development') THEN 'R_&_D'			WHEN dept_name IN ('sales', 'marketing') THEN 'Sales_&_Marketing' 			WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod_&_QM'
			WHEN dept_name IN ('finance', 'human resources') THEN 'Finance_&_HR'
			WHEN dept_name IN ('customer service') THEN 'Customer_Service'
			ELSE dept_name		END AS dept_groupFROM employees.departments
ORDER BY dept_group;

-- Step 2: Group By dept_group
SELECT		CASE 					WHEN dept_name IN ('research', 'development') THEN 'R_&_D'			WHEN dept_name IN ('sales', 'marketing') THEN 'Sales_&_Marketing' 			WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod_&_QM'
			WHEN dept_name IN ('finance', 'human resources') THEN 'Finance_&_HR'
			WHEN dept_name IN ('customer service') THEN 'Customer_Service'			ELSE dept_name		END AS dept_groupFROM employees.departments
GROUP BY dept_group;

-- Step 3: Join salaries/End Results

SELECT		CASE		-- Case statment groups by specified departments			WHEN dept_name IN ('research', 'development') THEN 'R_&_D'			WHEN dept_name IN ('sales', 'marketing') THEN 'Sales_&_Marketing' 			WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod_&_QM'
			WHEN dept_name IN ('finance', 'human resources') THEN 'Finance_&_HR'
			WHEN dept_name IN ('customer service') THEN 'Customer_Service'			ELSE dept_name		END AS dept_group,
		FORMAT(AVG(salary), 2) AS avg_salary -- Calculates avg salary of grouped departmentsFROM departments
JOIN dept_emp AS de ON de.dept_no = departments.dept_no		-- Joins dept_emp to be able to link salaries
JOIN salaries AS s ON s.emp_no = de.emp_no					-- Joins salaries to have access to AVG(salary) function
GROUP BY dept_group											-- Groups departments from case statement
;
/*
+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+
*/