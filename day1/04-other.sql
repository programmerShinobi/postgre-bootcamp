SELECT manager_id, COUNT(employee_id) FROM employees GROUP BY manager_id;

SELECT SUM(salary) FROM employees;

SELECT MIN(salary) FROM employees;

SELECT MAX(salary) FROM employees;

SELECT AVG(salary) FROM employees;

SELECT department_id, SUM(salary) as salary FROM employees
GROUP BY department_id
HAVING SUM(salary) <= 6500;

SELECT employee_id, first_name, last_name FROM employees
WHERE first_name LIKE 'Da%';

SELECT * FROM departments WHERE location_id IN
(SELECT location_id FROM locations l, countries c WHERE l.country_id = c.country_id AND c.region_id = 1);

SELECT CONCAT(first_name, ' ' ,last_name)fullname FROM employees;