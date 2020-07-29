-- Create a file named join_exercises.sql to do your work in.

-- _________________Join Example Database__________________ --
-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FRom roles as roles
JOIN users as users ON roles.id = users.role_id;;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT roles.name, COUNT(roles.name)
FROM roles as roles
LEFT JOIN users as users ON roles.id = users.role_id
GROUP BY roles.name;

SELECT *
FROM roles as roles
RIGHT JOIN users as users ON roles.id = users.role_id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(roles.name)
FROM roles as roles
RIGHT JOIN users as users ON roles.id = users.role_id
GROUP BY roles.name;

-- _______________________Employees Database_______________________ --
-- 1. Use the employees database.

use employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT depts.dept_name AS 'Department Name', CONCAT(emps.first_name, ' ', emps.last_name) AS 'Department Manager'
FROM departments AS depts
JOIN dept_manager AS managers ON depts.dept_no = managers.dept_no AND managers.to_date > CURDATE()
JOIN employees AS emps ON managers.emp_no = emps.emp_no
ORDER BY depts.dept_name;

/*  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang */
  
-- 3. Find the name of all departments currently managed by women.

SELECT depts.dept_name AS 'Department Name', CONCAT(emps.first_name, ' ', emps.last_name) AS 'Department Manager'
FROM departments AS depts
JOIN dept_manager AS managers ON depts.dept_no = managers.dept_no AND managers.to_date > CURDATE()
JOIN employees AS emps ON managers.emp_no = emps.emp_no AND emps.gender = 'F'
ORDER BY depts.dept_name;

/*Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil */

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT titles.title, COUNT(titles.title)
FROM departments as depts
JOIN dept_emp as dept_emps ON depts.dept_no = dept_emps.dept_no AND dept_emps.dept_no = 'd009'
JOIN titles AS titles ON dept_emps.emp_no = titles.emp_no AND titles.to_date > CURDATE()
GROUP BY titles.title;

/*Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241 */

-- 5. Find the current salary of all current managers.

SELECT depts.dept_name AS 'Department Name', 
	CONCAT(emp.first_name, ' ', emp.last_name) AS 'Name', 
	money.salary AS 'Salary'
FROM salaries AS money
JOIN dept_manager AS managers ON money.emp_no = managers.emp_no AND managers.to_date > CURDATE()
JOIN departments AS depts ON managers.dept_no = depts.dept_no
JOIN employees AS emp ON managers.emp_no = emp.emp_no
WHERE money.to_date > CURDATE()
ORDER BY depts.dept_name;

/*Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987 */

-- 6. Find the number of employees in each department.

SELECT dept.dept_no, dept.dept_name, COUNT(emp.emp_no) AS 'num_employees'
FROM departments AS dept
JOIN dept_emp AS emp ON emp.dept_no = dept.dept_no AND emp.to_date > CURDATE()
GROUP BY dept.dept_no;

/*
+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+*/

-- 7. Which department has the highest average salary?

SELECT dept.dept_name AS dept_name, AVG(money.salary) AS average_salary
FROM salaries AS money
JOIN dept_emp AS emp ON money.emp_no = emp.emp_no AND emp.to_date > CURDATE()
JOIN departments AS dept ON emp.dept_no = dept.dept_no
WHERE money.to_date > CURDATE()
GROUP BY dept.dept_name
ORDER BY AVG(money.salary) DESC
LIMIT 1;

/*
+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+*/

-- 8. Who is the highest paid employee in the Marketing department?

SELECT CONCAT(emps.first_name, ' ', emps.last_name) AS full_name
FROM salaries AS money
JOIN dept_emp AS emp_dept ON money.emp_no = emp_dept.emp_no AND emp_dept.dept_no = 'd001'
JOIN employees AS emps ON money.emp_no = emps.emp_no
ORDER BY money.salary DESC
LIMIT 1;

/*
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+*/

-- 9. Which current department manager has the highest salary?

SELECT emp.first_name, emp.last_name, money.salary, dept.dept_name
FROM employees AS emp
JOIN dept_manager AS man ON emp.emp_no = man.emp_no AND man.to_date > CURDATE()
JOIN salaries AS money ON emp.emp_no = money.emp_no AND money.to_date > CURDATE()
JOIN departments AS dept ON dept.dept_no = man.dept_no
ORDER BY money.salary DESC
LIMIT 1;

/*
+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+*/

-- Bonus Find the names of all current employees, their department name, and their current manager's name.

-- SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS emp_name, dept.dept_name AS department

SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name,
	man.dept_name AS department_name,
	man.manager_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no AND dept_emp.to_date > CURDATE()
JOIN	
	(
	SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS manager_name, dept.dept_name, dept_emp.dept_no
	FROM employees as emp
	JOIN dept_emp ON dept_emp.emp_no = emp.emp_no AND dept_emp.to_date > CURDATE()
	JOIN departments AS dept ON dept.dept_no = dept_emp.dept_no
	LEFT JOIN dept_manager AS man ON man.dept_no = dept_emp.dept_no AND man.to_date > CURDATE()
	WHERE emp.emp_no IN
		(
		SELECT dept_manager.emp_no
		FROM dept_manager
		WHERE dept_manager.to_date > CURDATE()
		)
	)AS man ON man.dept_no = dept_emp.dept_no
WHERE dept_emp.dept_no = man.dept_no;

/*240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....*/

-- Bonus Find the highest paid employee in each department.
SELECT *
FROM
(
	SELECT emp.first_name, money.salary, dept.dept_name
	FROM employees AS emp
	JOIN salaries AS money ON money.emp_no = emp.emp_no AND money.to_date > CURDATE()
	JOIN dept_emp ON dept_emp.emp_no = emp.emp_no AND dept_emp.to_date > CURDATE()
	JOIN departments AS dept ON dept.dept_no = dept_emp.dept_no
	GROUP BY money.salary, dept.dept_name
	ORDER BY money.salary DESC
) AS dept_pay;
