-- window functions 

SELECT dem.first_name, gender, avg(salary) as avg_salary
FROM employee_demographics as dem
join employee_salary as sal
		on dem.employee_id = sal.employee_id
	group by dem.first_name, gender
;

SELECT dem.first_name, gender, avg(salary) OVER(PARTITION BY gender )
FROM employee_demographics as dem
join employee_salary as sal
		on dem.employee_id = sal.employee_id
;
-- rolling total
SELECT dem.first_name, dem.last_name,gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id ) as Rolling_total
FROM employee_demographics as dem
join employee_salary as sal
		on dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name,gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc ) as row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary desc ) as rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary desc ) as denserow_num
FROM employee_demographics as dem
join employee_salary as sal
		on dem.employee_id = sal.employee_id
;









