-- RUN 1
-- Membuat procedure
CREATE PROCEDURE hitung_luas_persegi (sisi INTEGER)
AS $$
    SELECT sisi * sisi * sisi AS luas;
$$ LANGUAGE SQL;

-- RUN 2
-- Memanggil procedure
CALL hitung_luas_persegi(5);

-- RUN 3
-- stop procedure
COMMIT

-- RUN 4
-- CREATE
CREATE PROCEDURE insert_employee
(
  @name VARCHAR(50),
  @email VARCHAR(255)
)
AS
$$
BEGIN
  INSERT INTO employees (name, email)
  VALUES (@name, @email);
END;
$$
LANGUAGE plpgsql;

-- RUN 5
-- INSERT
CALL insert_employee('John Smith', 'john.smith@example.com');

-- RUN 6
-- UPDATE
ALTER PROCEDURE update_employee
(
  @employee_id INT,
  @new_name VARCHAR(50)
)
AS
BEGIN
  UPDATE employees
  SET name = @new_name
  WHERE id = @employee_id
END

-- RUN 7
-- DROP
DROP PROCEDURE nama_procedure

