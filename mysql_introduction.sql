#Use the employees database
use employees;

#List all the tables in the database
show tables;

#Q: What different data types are present?
DESCRIBE employees;
DESCRIBE departments;
DESCRIBE dept_manager;
DESCRIBE salaries;
DESCRIBE titles;
#A: int,date, varchar, enum

#Q: Which table(s) do you think contain a numeric type column?
#A: The employee ID number, salarie dollar amounts, other columns are numbers in date dtype

#Q: Which table(s) do you think contain a string type column?
#A: The employees' first name and last name, emp title name, emp department title

#Q: Which table(s) do you think contain a date type column?
#A: The employees' birth date and hire date, from date and to date in multiple tables

#Q: What is the relationship between the employees and the departments tables?
#A: employees -> employees_with_departments -> departments