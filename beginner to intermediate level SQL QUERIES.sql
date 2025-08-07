SELECT  * 
FROM parks_and_recreation.employee_demographics;

SELECT  first_name,
last_name,
 birth_date,
 age,
( age + 10) *10+10
FROM parks_and_recreation.employee_demographics;
#PEMDAS- ORDER OF executION DONE

SELECT  DISTINCT  gender
FROM parks_and_recreation.employee_demographics;

SELECT  DISTINCT  first_name,gender
FROM parks_and_recreation.employee_demographics;

SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie'
;


SELECT * 
FROM employee_salary
WHERE salary > 50000
;

SELECT * 
FROM employee_salary
WHERE salary >= 50000
;

SELECT * 
FROM employee_salary
WHERE salary <= 50000
;

SELECT * 
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01' 
AND gender = 'Male'
;

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01' 
 OR NOT gender = 'Male'
;

SELECT * 
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age >55
;

-- LIKE statement 
-- % AND _
SELECT * 
FROM employee_demographics
WHERE first_name LIKE '%er%'
;

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a__%'
;
SELECT * 
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;
-- group by 
SELECT gender
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

-- order by
SELECT * 
FROM employee_demographics
ORDER BY gender , age desc
;
-- col no =5, gender
SELECT * 
FROM employee_demographics
ORDER BY 5, 4
;

-- having 
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation, avg(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING avg(salary) > 75000
;

-- limit 

SELECT *
FROM employee_demographics
ORDER BY AGE DESC
LIMIT 2,1
;

-- ALAISING

SELECT gender, avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 40
;

-- joins 

SELECT *
FROM employee_demographics;

SELECT * 
FROM employee_salary;
-- INNER JOIN
SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
		ON employee_demographics.employee_id = employee_salary.employee_id
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
;

-- OUTER JOIN
SELECT *
FROM employee_demographics as dem
LEFT JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics as dem
RIGHT JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
;

-- SELF JOIN
SELECT *
FROM employee_salary EMP1
JOIN employee_salary EMP2
		ON EMP1.employee_id + 1 = EMP2. employee_id
;


SELECT *
FROM employee_salary EMP1
JOIN employee_salary EMP2
		ON EMP1.employee_id + 1 = EMP2. employee_id
;

SELECT emp1.employee_id AS emp_SANTA,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
		ON emp1.employee_id + 1 = emp2. employee_id
;

-- Joining multiple tables together

SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
		ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments PD
		ON sal.dept_id = pd.department_id
;

SELECT *
FROM parks_departments;

-- UNION

SELECT age, gender
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary
;
SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender= 'Male'
UNION
SELECT first_name, last_name, 'Old lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender= 'Female'
UNION
SELECT first_name, last_name, 'highly paided' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;

-- String functions 
SELECT LENGTH('Skyfall');

SELECT first_name, length(first_name)
from employee_demographics
order by 2;

-- Upper and Lower

SELECT UPPER('Sky');
SELECT LOWER('SKY');

SELECT first_name, UPPER(first_name)
from employee_demographics
order by 2;

-- TRIM

SELECT TRIM('   SKY   ');
SELECT  LTRIM('     SKY    ');
SELECT  RTRIM('     SKY    ');

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2),
birth_date,
SUBSTRING(birth_date ,3,2),
SUBSTRING(birth_date ,6,2) as birth_month
from employee_demographics;

select first_name, replace(first_name, 'a', 'z')
from employee_demographics;

SELECT LOCATE('x' , 'Alexander');

SELECT first_name, LOCATE('An' , first_name)
from employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name,' ', last_name)  AS FULL_NAME
from employee_demographics;


SELECT first_name, last_name,
CASE
		WHEN age <= 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Old'
        WHEN age >= 30 THEN "On Death's Door"
	END AS Age_Bracket
from employee_demographics;


-- Pay Increase and bonus
-- <50000=5%
-- >50000=7%
-- Finance= 10% bonus

Select first_name, last_name, salary,
CASE
		WHEN salary < 50000 THEN salary + (salary * 0.05)
        WHEN salary > 50000 THEN salary *1.07
END AS New_salary,
CASE
		WHEN dept_id = 6 THEN salary * 1.10
END AS bonus
FROM employee_salary;

SELECT *
FROM employee_salary;


SELECT *
FROM parks_departments;

-- Sub queries 

SELECT *
FROM employee_demographics
WHERE employee_id IN 
									(SELECT employee_id
										FROM employee_salary
                                        WHERE dept_id = 1)
;

SELECT first_name, salary, 
(SELECT AVG(salary) 
FROM employee_salary) AS AVG_SALARY
FROM employee_salary;


SELECT gender, AVG(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

SELECT AVG(`max(age)`)
FROM(
SELECT gender, AVG(age) as avg_age,
 max(age), 
 min(age), 
 count(age)
from employee_demographics
group by gender
) as Agg_table
;
SELECT AVG(max_age)
FROM(
SELECT gender, 
 avg (age) as avg_age ,
 max(age) as max_age , 
 min(age) as min_age, 
 count(age) as count_age
from employee_demographics
group by gender
) as Agg_table
;