-- 	DROP function search_sales(cari varchar(40))
--	TASK 3, MODUL SALES
-- 	PENCARIAN BERDASARKAN nama, nama pekerjaan, dan nama negara
-- 	Kode program di FUNCTION ini digunakan untuk mencari data sesuai dengan KATA YANG DICARI dan HALAMAN
-- 	Pemanggilan function diinput sebanyak 2 parameter

-- RUN 1
CREATE OR REPLACE FUNCTION search_next(
	cari VARCHAR(40), 
	page INT
)
RETURNS TABLE (
	fullname TEXT,
	jobtitle TEXT,
	emailaddress TEXT,
	salesquota NUMERIC,
	bonus NUMERIC,
	commissionpct DECIMAL,
	salesytd NUMERIC,
	saleslastyear NUMERIC,
	teritory_name TEXT
) AS 
$$
DECLARE
	jml_row INT := 3;
	o int := (page-1) * jml_row;	
	my_cursor CURSOR FOR
		(SELECT CONCAT(pe.p.firstname,' ',pe.p.lastname)fullname, hr.e.jobtitle, pe.e.emailaddress, sa.sp.salesquota,
			sa.sp.bonus, sa.sp.commissionpct, sa.sp.salesytd, sa.sp.saleslastyear,
			sa.st.name
		FROM sa.sp
			LEFT JOIN pe.p ON pe.p.businessentityid = sa.sp.businessentityid
			LEFT JOIN hr.e ON hr.e.businessentityid = pe.p.businessentityid
			LEFT JOIN pe.e ON pe.e.businessentityid = pe.p.businessentityid
			LEFT JOIN sa.st ON sa.st.territoryid = sa.sp.territoryid
		WHERE pe.p.firstname
			LIKE concat(cari,'%')
		 		OR pe.p.firstname
		 	LIKE CONCAT('%',cari,'%')
		 		OR pe.p.firstname
		 	LIKE CONCAT('%',cari)
				OR pe.p.lastname
		 	LIKE concat(cari,'%')
		 		OR pe.p.lastname
		 	LIKE CONCAT('%',cari,'%')
		 		OR pe.p.lastname
		 	LIKE CONCAT('%',cari)
				OR hr.e.jobtitle
		 	LIKE concat(cari,'%')
		 		OR hr.e.jobtitle
		 	LIKE CONCAT('%',cari,'%')
		 		OR hr.e.jobtitle
		 	LIKE CONCAT('%',cari)
				OR pe.e.emailaddress
			LIKE concat(cari,'%')
		 		OR pe.e.emailaddress
		 	LIKE CONCAT('%',cari,'%')
		 		OR pe.e.emailaddress
		 	LIKE CONCAT('%',cari)
		 		OR sa.st.name
		 	LIKE concat(cari,'%')
		 		OR sa.st.name
		 	LIKE CONCAT('%',cari,'%')
		 		OR sa.st.name 
		 	LIKE CONCAT('%',cari)
		 ORDER BY fullname 
		 LIMIT jml_row
		 OFFSET o
		);
	row_data record;
	counts int := 1;
	
	ambil_data text default '';
BEGIN
	OPEN my_cursor;
		LOOP
			FETCH NEXT FROM my_cursor INTO fullname, jobtitle , emailaddress , salesquota ,
								bonus , commissionpct , salesytd , saleslastyear ,
								teritory_name  ;
 			EXIT WHEN NOT FOUND;
			
			RETURN NEXT;
 		END LOOP;
		
	CLOSE my_cursor;
END;
$$
LANGUAGE PLPGSQL;

-- RUN 2
--search_text(kata,halaman)
SELECT * FROM search_next('@adven', 3)	-- cari data berdasarkan emailaddress (email)

SELECT * FROM search_next('David', 1) 	-- cari data dengan fullname (nama) yang berada di halaman ke- ..

SELECT * FROM search_next('Man', 1) 	-- cari jobtitle (job title) dengan unsur 'Sales' yang berada di halaman ke- ..

SELECT * FROM search_next('Nort',1) 	-- cari teritory (negara) yang ada kata 'Nort' -nya dan berada di page/halaman ke- ..



-- RUN 4
-- PAGINATION UNTUK MENAMPILKAN SEMUA DATA SALES
-- Function yang membutuhkan input (parameter) berupa angka dari halaman yang akan di lihat
CREATE OR REPLACE FUNCTION all_data_page(page int)
RETURNS TABLE(
	fullname TEXT, 
	jobtitle TEXT, 
	emailaddress TEXT, 
	salesquota NUMERIC,
	bonus NUMERIC, 
	commissionpct DECIMAL, 
	salesytd NUMERIC, 
	saleslastyear NUMERIC,
	teritory_name TEXT
) AS
$$
DECLARE
-- 	counter int default 0;
	jml_row INT := 3;
	o int := (page-1) * jml_row; --untuk mengambil offset dari halaman
	my_cursor CURSOR FOR
	(
		SELECT CONCAT(pe.p.firstname,' ',pe.p.lastname)fullname, 
		hr.e.jobtitle,
		pe.e.emailaddress,
		sa.sp.salesquota,
		sa.sp.bonus,
		sa.sp.commissionpct, sa.sp.salesytd, sa.sp.saleslastyear,
		sa.st.name
		FROM sa.sp
		--pe.p
			LEFT JOIN pe.p ON pe.p.businessentityid = sa.sp.businessentityid
			LEFT JOIN hr.e ON hr.e.businessentityid = pe.p.businessentityid
			LEFT JOIN pe.e ON pe.e.businessentityid = pe.p.businessentityid
			LEFT JOIN sa.st ON sa.st.territoryid = sa.sp.territoryid
		ORDER BY fullname 
		LIMIT jml_row
		OFFSET o
	);
	
s_data record;
counts int := 1;
ambil_data text default '';
	
BEGIN
	OPEN my_cursor;
		LOOP
			FETCH NEXT FROM my_cursor INTO 
				fullname,
				jobtitle,
				emailaddress,
				salesquota,
				bonus,
				commissionpct,
				salesytd,
				saleslastyear,
				teritory_name;
			EXIT WHEN NOT FOUND;
			RETURN NEXT;
		END LOOP;
	CLOSE my_cursor;
END;
$$
LANGUAGE PLPGSQL;

-- RUN 5
SELECT * FROM all_data_page(1)
SELECT * FROM all_data_page(6)