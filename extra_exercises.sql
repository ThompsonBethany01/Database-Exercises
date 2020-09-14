-- Extr SQL Exercises

-- How much do the current managers of each department get paid, relative to the average salary for the department? 

#first let's find the average salary for each department
SELECT de.dept_no as department, AVG(s.salary) as average_salary
FROM salaries as s
JOIN dept_emp as de on de.emp_no = s.emp_no and de.to_date > CURDATE()
WHERE s.to_date > CURDATE()
GROUP BY de.dept_no;

#second we find the salary of all current managers, along with their department no
SELECT dm.emp_no, dm.dept_no, s.salary
FROM dept_manager as dm
JOIN salaries as s on s.emp_no = dm.emp_no and s.to_date > CURDATE()
WHERE dm.to_date > CURDATE();

#let's add their names
SELECT CONCAT(e.first_name, ' ',e.last_name) as first_name, dm.emp_no, dm.dept_no, s.salary
FROM dept_manager as dm
JOIN salaries as s on s.emp_no = dm.emp_no and s.to_date > CURDATE()
JOIN employees as e on e.emp_no = dm.emp_no
WHERE dm.to_date > CURDATE();

#now we can add the tables together
SELECT CONCAT(e.first_name, ' ',e.last_name) as first_name, dm.emp_no, dm.dept_no, s.salary as manager_salary, dept_s.department_salary
FROM dept_manager as dm
JOIN salaries as s on s.emp_no = dm.emp_no and s.to_date > CURDATE()
JOIN employees as e on e.emp_no = dm.emp_no
JOIN (
		SELECT de.dept_no, ROUND(AVG(s.salary),0) as department_salary
		FROM salaries as s
		JOIN dept_emp as de on de.emp_no = s.emp_no and de.to_date > CURDATE()
		WHERE s.to_date > CURDATE()
		GROUP BY de.dept_no
		) as dept_s on dept_s.dept_no = dm.dept_no
WHERE dm.to_date > CURDATE();

-- Is there any department where the department manager gets paid less than the average salary?
#two managers make less money than the department average
SELECT *
FROM(
	SELECT CONCAT(e.first_name, ' ',e.last_name) as first_name, dm.emp_no, dm.dept_no, s.salary as manager_salary, dept_s.department_salary
	FROM dept_manager as dm
	JOIN salaries as s on s.emp_no = dm.emp_no and s.to_date > CURDATE()
	JOIN employees as e on e.emp_no = dm.emp_no
	JOIN (
		SELECT de.dept_no, ROUND(AVG(s.salary),0) as department_salary
		FROM salaries as s
		JOIN dept_emp as de on de.emp_no = s.emp_no and de.to_date > CURDATE()
		WHERE s.to_date > CURDATE()
		GROUP BY de.dept_no
		) as dept_s on dept_s.dept_no = dm.dept_no
	WHERE dm.to_date > CURDATE()
	) as dept_man_salaries
JOIN departments as d on d.dept_no = dept_man_salaries.dept_no
WHERE  manager_salary < department_salary;

-- Step 1: Find salary of current managers

SELECT dm.emp_no, e.first_name, e.last_name, FORMAT(s.salary, 2) AS manager_salary, d.dept_name
FROM dept_manager AS dm
JOIN salaries AS s ON s.emp_no = dm.emp_no AND s.to_date > CURDATE()
JOIN employees as e ON e.emp_no = dm.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > CURDATE();

-- Step 2: Find average salary of each departments

SELECT d.dept_name, FORMAT(AVG(salary), 2) AS department_salary
FROM salaries AS s
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date > CURDATE()
GROUP BY dept_name;

-- Employees Date Base

SELECT *
FROM dept_manager AS dm
JOIN salaries AS s ON dm.emp_no = s.emp_no AND s.to_date > CURDATE()
WHERE dm.to_date > CURDATE();

-- World Data Base
-- What languages are spoken in Santa Monica?

SELECT cl.language, cl.percentage
FROM countrylanguage AS cl
JOIN country ON country.code = cl.countrycode
JOIN city ON city.countrycode = country.code
WHERE city.name LIKE 'Santa Monica'
ORDER BY cl.percentage ASC, cl.language ASC;

-- How many different countries are in each region?

SELECT region, COUNT(name) AS num_countries
FROM country
GROUP BY region
ORDER BY num_countries ASC;

-- What is the population for each region?
SELECT region, SUM(population) AS population
FROM country
GROUP BY population DESC, region;

-- What is the population for each continent?
SELECT continent, SUM(population) AS population
FROM country
GROUP BY continent
ORDER BY population DESC;

-- What is the average life expectancy globally?

SELECT AVG(lifeexpectancy)
FROM country;

-- What is the average life expectancy for each region, each continent? 
-- Sort the results from shortest to longest

SELECT region, AVG(lifeexpectancy)
FROM country
GROUP BY region
ORDER BY AVG(lifeexpectancy);

SELECT continent, AVG(lifeexpectancy)
FROM country
GROUP BY continent
ORDER BY AVG(lifeexpectancy);

-- BONUS______________________________________________________________________

-- Find all the countries whose local name is different from the official name.

SELECT *
FROM country
WHERE name != LocalName;

-- How many countries have a life expectancy less than x?

SELECT *
FROM country
WHERE LifeExpectancy < 40;

-- What state is city x located in?

SELECT *
FROM city
JOIN country on country.code = city.CountryCode
WHERE city.name = 'Dubai';

-- What region of the world is city x located in?

SELECT Region
FROM city
JOIN country on country.code = city.CountryCode
WHERE city.name = 'Dubai';

-- What country (use the human readable name) city x located in?

SELECT country.name
FROM city
JOIN country on country.code = city.CountryCode
WHERE city.name = 'Dubai';

-- What is the life expectancy in city x?

SELECT LifeExpectancy
FROM country
JOIN city on country.code = city.CountryCode
WHERE city.name = 'Los Angeles'