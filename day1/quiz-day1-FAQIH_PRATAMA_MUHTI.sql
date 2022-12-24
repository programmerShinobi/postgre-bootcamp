-- 1)   Informasi jumlah department di tiap regions.
SELECT region_name, COUNT(department_id)
	FROM departments de
JOIN locations lo ON lo.location_id = de.location_id
JOIN countries co ON co.country_id = lo.country_id
JOIN regions re ON re.region_id = co.region_id
GROUP BY region_name;
----

-- 2)   Informasi jumlah department tiap countries.
SELECT country_name, COUNT(department_id)
	FROM departments de
JOIN locations lo ON lo.location_id = de.location_id
JOIN countries co ON co.country_id = lo.country_id
GROUP BY country_name;
----

-- 3)   Informasi jumlah employee tiap department.
SELECT department_name, COUNT(employee_id)
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
GROUP BY department_name;
----

-- 4)   Informasi jumlah employee tiap region.
SELECT region_name, COUNT(employee_id)
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
JOIN locations lo ON lo.location_id = de.location_id
JOIN countries co ON co.country_id = lo.country_id
JOIN regions re ON re.region_id = co.region_id
GROUP BY region_name;
----

-- 5)	Informasi jumlah employee tiap countries.
SELECT country_name, COUNT(employee_id)
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
JOIN locations lo ON lo.location_id = de.location_id
JOIN countries co ON co.country_id = lo.country_id
GROUP BY country_name;
----

-- 6)	Informasi salary tertinggi tiap department.
SELECT department_name, MAX(salary) AS max_salary
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
GROUP BY department_name;
----

-- 7)	Informasi salary terendah tiap department.
SELECT department_name, MIN(salary) AS min_salary
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
GROUP BY department_name;

-- 8)	Informasi salary rata-rata tiap department.
SELECT department_name, AVG(salary) AS avg_salary
	FROM employees em
JOIN departments de ON de.department_id = em.department_id
GROUP BY department_name;

-- 9)	Informasi jumlah mutasi pegawai tiap deparment.
SELECT department_name, COUNT(job_id) AS jumlah
	FROM job_history jo
JOIN departments de ON de.department_id = jo.department_id
GROUP BY department_name;

-- 10)	Informasi jumlah mutasi pegawai berdasarkan role-jobs.
SELECT job_title, COUNT(joh.job_id) AS jumlah_mutasi_pegawai
FROM job_history joh
JOIN jobs jo ON jo.job_id = joh.job_id
GROUP BY job_title;
----

-- 11)	Informasi jumlah employee yang sering dimutasi.
SELECT COUNT(jumlah_employee_mutasi)jumlah_mutasi
FROM (
	SELECT employee_id, COUNT(employee_id)employee
	FROM job_history
	GROUP BY employee_id
) AS jumlah_employee_mutasi WHERE employee > 1;
----

-- 12)	Informasi jumlah employee berdasarkan role jobs-nya.
SELECT job_title, COUNT(em.employee_id) AS jumlah_pegawai
	FROM employees em
JOIN jobs jo ON jo.job_id = em.job_id
GROUP BY job_title;
----

-- 13)	Informasi employee paling lama bekerja di tiap deparment.
SELECT CONCAT(emp.first_name, ' ', emp.last_name), emp.department_id, emp.hire_date
FROM (
	SELECT department_id, MIN(hire_date) min_hire_date
	FROM employees
	GROUP BY department_id
	ORDER BY department_id
	) dep
INNER JOIN employees emp ON dep.department_id = emp.department_id
WHERE emp.hire_date = min_hire_date
ORDER BY dep.department_id;
----

-- 14)	Informasi employee baru masuk kerja di tiap department.
SELECT CONCAT(emp.first_name, ' ', emp.last_name), emp.department_id, emp.hire_date
FROM (
	SELECT department_id, MAX(hire_date) max_hire_date
	FROM employees
	GROUP BY department_id
	ORDER BY department_id
	) dep
INNER JOIN employees emp ON dep.department_id = emp.department_id
WHERE emp.hire_date = max_hire_date
ORDER BY dep.department_id;
----

-- 15)	Informasi lama bekerja tiap employee dalam tahun dan jumlah mutasi history-nya.
SELECT emp.employee_id AS ID,
	CONCAT(emp.first_name, ' ',emp.last_name)full_name,
	(SELECT EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM emp.hire_date))lama_bekerja,
	CASE
		WHEN jumlah_mutasi IS NULL THEN 0
		ELSE jumlah_mutasi
	END
FROM employees emp
LEFT JOIN (
	SELECT employee_id, COUNT(employee_id) jumlah_mutasi
	FROM job_history
	GROUP BY employee_id
) mutasi
	ON emp.employee_id = mutasi.employee_id
ORDER BY emp.employee_id ASC