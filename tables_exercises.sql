#Use the employees database
use employees;

#List all the tables in the database
select database();

#Q: What different data types are present?
DESCRIBE salaries;
#A: int, date, varchar, enum

#Q: Which table(s) do you think contain a numeric type column?
#A: employees, dept_emp, dept_manager, employees_with_departments, salaries

#Q: Which table(s) do you think contain a string type column?
#A: employees, departments, dept_emp, dept-manager, employees_with_departments

#Q: Which table(s) do you think contain a date type column?
#A: employees, dept_emp, dept_manager, employees_with_departments, salaries

#Q: What is the relationship between the employees and the departments tables?
#A: employees -> employees_with_departments -> departments

#Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;
#CREATE TABLE `dept_manager` (
#	`emp_no` int(11) NOT NULL,
#	`dept_no` char(4) NOT NULL,
#	`from_date` date NOT NULL,
#	`to_date` date NOT NULL,
#	PRIMARY KEY (`emp_no`,`dept_no`),
#	KEY `dept_no` (`dept_no`),
#	CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
#	CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
#	) 
#ENGINE=InnoDB DEFAULT CHARSET=latin1