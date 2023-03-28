-- regions join countries
SELECT * 
    FROM regions r 
        LEFT JOIN countries c 
            ON r.region_id = c.region_id; 

SELECT * 
    FROM regions r 
        RIGHT JOIN countries c 
            ON r.region_id = c.region_id; 

SELECT * 
    FROM regions r 
        INNER JOIN countries c 
            ON r.region_id = c.region_id; 

SELECT * 
    FROM regions r 
        FULL OUTER JOIN countries c    
            ON r.region_id = c.region_id; 
-------------

-- countries join locations
SELECT * 
    FROM countries c 
        LEFT JOIN locations l 
            ON c.country_id = l.country_id;

SELECT * 
    FROM countries c 
        RIGHT JOIN locations l 
            ON c.country_id = l.country_id;

SELECT * 
    FROM countries c 
        INNER JOIN locations l 
            ON c.country_id = l.country_id;

SELECT * 
    FROM countries c 
        FULL OUTER JOIN locations l 
            ON c.country_id = l.country_id;
-------------

-- locations join departments
SELECT * 
    FROM locations l 
        LEFT JOIN departments d 
            ON l.location_id = d.location_id;

SELECT * 
    FROM locations l 
        RIGHT JOIN departments d 
            ON l.location_id = d.location_id;

SELECT * 
    FROM locations l 
        INNER JOIN departments d 
            ON l.location_id = d.location_id;

SELECT * 
    FROM locations l 
        FULL OUTER JOIN departments d 
            ON l.location_id = d.location_id;
------------- 

-- departmens join employees
SELECT * 
    FROM departments d 
        LEFT JOIN employees e 
            ON d.department_id = e.department_id;

SELECT * 
    FROM departments d 
        RIGHT JOIN employees e 
            ON d.department_id = e.department_id;

SELECT * 
    FROM departments d 
        INNER JOIN employees e 
            ON d.department_id = e.department_id;

SELECT * 
    FROM departments d 
        FULL OUTER JOIN employees e 
            ON d.department_id = e.department_id;
------------- 

-- department join job_history
SELECT * 
    FROM departments d 
        LEFT JOIN job_history j 
            ON d.department_id = j.department_id;

SELECT * 
    FROM departments d 
        RIGHT JOIN job_history j 
            ON d.department_id = j.department_id;

SELECT * 
    FROM departments d 
        INNER JOIN job_history j 
            ON d.department_id = j.department_id;

SELECT * 
    FROM departments d 
        FULL OUTER JOIN job_history j 
            ON d.department_id = j.department_id;
-------------

-- employees join job_history
SELECT * 
    FROM employees e 
        LEFT JOIN job_history j 
            ON e.employee_id = j.employee_id;

SELECT * 
    FROM employees e 
        RIGHT JOIN job_history j 
            ON e.employee_id = j.employee_id;

SELECT * 
    FROM employees e 
        INNER JOIN job_history j 
            ON e.employee_id = j.employee_id;

SELECT * 
    FROM employees e 
        FULL OUTER JOIN job_history j 
            ON e.employee_id = j.employee_id;
-------------

-- jobs join employees
SELECT * 
    FROM jobs j 
        LEFT JOIN employees e 
            ON j.job_id = e.job_id;

SELECT * 
    FROM jobs j 
        RIGHT JOIN employees e 
            ON j.job_id = e.job_id;

SELECT * 
    FROM jobs j 
        INNER JOIN employees e 
            ON j.job_id = e.job_id;

SELECT * 
    FROM jobs j 
        FULL OUTER JOIN employees e 
            ON j.job_id = e.job_id;
-------------

-- region join countries join locations
SELECT * 
    FROM regions r 
        JOIN countries c 
            ON r.region_id = c.region_id
        JOIN locations l 
            ON c.country_id = l.country_id;
