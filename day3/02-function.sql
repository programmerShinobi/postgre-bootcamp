-- RUN 1
CREATE OR REPLACE FUNCTION get_profile(p_year INTEGER) 
	RETURNS text AS $$ 
		DECLARE profile text DEFAULT '';

rec_emp record;

cur_emps CURSOR(p_year INTEGER) FOR
	SELECT CONCAT(first_name, ' ', last_name) AS fullname,
		salary,
		hire_date
	FROM employees
	WHERE EXTRACT(
		year FROM AGE(now(), hire_date)
	) = p_year;

BEGIN OPEN cur_emps(p_year);

LOOP FETCH cur_emps INTO rec_emp;

EXIT WHEN NOT FOUND;

profile := profile || ',' || rec_emp.fullname || ':' || rec_emp.salary;

END LOOP;

CLOSE cur_emps;

RETURN profile;

END;

$$ LANGUAGE plpgsql;

-- Run 2
SELECT get_profile(15);