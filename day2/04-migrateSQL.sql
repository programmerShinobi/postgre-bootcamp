-- RUN 1
BEGIN;
DECLARE
	my_cursor CURSOR FOR SELECT * FROM employees;

-- RUN ..
FETCH NEXT FORM my_cursor; --Fetch selanjutnya

-- RUN ..
FETCH PRIOR FROM my_cursor; --Fetch sebelumnya

-- RUN ..
FETCH LAST FROM my_cursor; --Fetch terakhir


-- RUN 2 
COMMIT; --tutup cursor

-- RUN 3
CREATE OR REPLACE FUNCTION get_profile(p_year INTEGER)
RETURNS text AS $$

DECLARE 
	profile text DEFAULT '';
	rec_emp record;
	cur_emps CURSOR(p_year INTEGER)
		FOR SELECT CONCAT(first_name, ' ', last_name)
			AS fullname, salary, hire_date
			FROM employees
			WHERE EXTRACT(year FROM AGE(now(),hire_date)) = p_year;
			
BEGIN
	OPEN cur_emps(p_year);
	
	LOOP
		FETCH cur_emps INTO rec_emp;
		
		EXIT WHEN NOT FOUND;
		
		profile:=profile || ',' || rec_emp.fullname || ':' || rec_emp.salary;
	END LOOP;
	
	CLOSE cur_emps;
	RETURN profile;
	
	END;$$
	LANGUAGE plpgsql;

-- RUN 4 --SELECT function
SELECT get_profile(15);

-- RUN 5 -- CREATE procedure bonus
CREATE OR REPLACE PROCEDURE bonus(sender INT, amount DEC)
	LANGUAGE plpgsql AS $$
	BEGIN
		UPDATE employees
			SET salary = salary + amount
		WHERE employee_id = sender;

COMMIT;

END;$$

-- RUN 6 -- CALL procedure bonus
CALL bonus(166, 20000);

-- RUN 7 -- SELECT employees sesuai dengan 
SELECT * FROM  employees
	WHERE employee_id = 166;
	
