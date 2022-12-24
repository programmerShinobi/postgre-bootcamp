-- Search Sales Person
-- RUN 1
CREATE OR REPLACE FUNCTION SearchSalesPerson (searching TEXT)
RETURNS TABLE (
	FullName TEXT,
	JobTitle TEXT,
	Email TEXT,
	SalesQuota NUMERIC,
	Bonus NUMERIC,
	CommissionPct NUMERIC,
	SalesYTD NUMERIC,
	SalesLastYear NUMERIC,
	Teritory VARCHAR,
	businessentityID INT
)

AS $$

DECLARE
	cur_id	int;
	offset int;
	limit int;
	my_cursor CURSOR FOR
		SELECT  
		(CONCAT(pp.firstName, ' ', pp.middleName,' ', pp.lastName)) AS "fullName",
		hre.jobtitle AS "JobTitle",
		pea.emailAddress AS "Email",
		ssp.SalesQuota AS "SalesQuota",
		ssp.Bonus AS "Bonus",
		ssp.CommissionPct AS "CommissionPct",
		ssp.salesYTD AS "SalesYTD",
		ssp.SalesLastYear AS "SalesLastYear",
		sst.name AS "Teritory",
		ssp.businessentityID AS "ID"
	FROM sales.SalesPerson ssp
	JOIN person.Person pp USING  (businessentityID)
	JOIN sales.SalesTerritory sst USING (territoryID)
	JOIN humanResources.Employee hre USING (businessentityID)
	JOIN person.EmailAddress pea USING (businessentityID)
-- 	JOIN person.Person pp ON pp.businessentityID = ssp.businessentityID
-- 	JOIN sales.SalesTerritory sst ON sst.territoryID = ssp.territoryID
-- 	JOIN humanResources.Employee hre ON hre.businessentityID = pp.businessentityID 
-- 	JOIN person.EmailAddress pea ON pea.businessentityID = pp.businessentityID
	WHERE pp.firstName
	LIKE CONCAT('%',searching)
		 		OR pp.firstName
		 	LIKE concat(searching,'%')
		 		OR pp.firstName
		 	LIKE CONCAT('%',searching,'%')
				OR pp.middleName
		 	LIKE concat('%',searching)
		 		OR pp.middleName
		 	LIKE CONCAT('%',searching,'%')
				OR pp.middleName
		 	LIKE concat(searching,'%')
				OR pp.lastName
		 	LIKE concat('%',searching)
		 		OR pp.lastName
		 	LIKE CONCAT('%',searching,'%')
				OR pp.lastName
		 	LIKE concat(searching,'%')
				OR hre.jobtitle
			LIKE CONCAT('%',searching)
		 		OR hre.jobtitle
		 	LIKE CONCAT('%',searching,'%')
		 		OR hre.jobtitle
		 	LIKE CONCAT(searching,'%')
				OR pea.emailaddress
			LIKE CONCAT('%',searching)
		 		OR pea.emailaddress
		 	LIKE CONCAT('%',searching,'%')
		 		OR pea.emailaddress
			LIKE CONCAT(searching,'%');
BEGIN
	OPEN my_cursor;
	LOOP
		FETCH NEXT FROM my_cursor INTO 
		FullName,
		JobTitle,
		Email,
		SalesQuota,
		Bonus,
		CommissionPct,
		SalesYTD,
		SalesLastYear,
		Teritory,
		businessentityID;
		EXIT WHEN NOT FOUND;
		RETURN NEXT;
	END LOOP;
	CLOSE my_cursor;
END; $$
LANGUAGE PLPGSQL;
-- RUN 2
SELECT SearchSalesPerson('dez'); --search fullname

SELECT SearchSalesPerson('Sales'); --search jobtitle

SELECT SearchSalesPerson('ranjit'); --search email

SELECT SearchSalesPerson(''); --search all


-- Get Sales Person
-- RUN 1
CREATE OR REPLACE FUNCTION GetSalesPerson(offsets int, limits int)
RETURNS TABLE (
		FullName TEXT,
		JobTitle TEXT,
		Email TEXT,
		SalesQuota NUMERIC,
		Bonus NUMERIC,
		CommissionPct NUMERIC,
		SalesYTD NUMERIC,
		SalesLastYear NUMERIC,
		Teritory VARCHAR,
		businessentityID INT
)
AS $$

DECLARE
	cur_id	int;
	offset int;
	limit int;
	my_cursor CURSOR FOR
		SELECT  
		(CONCAT(pp.firstName, ' ', pp.middleName,' ', pp.lastName)) AS "fullName",
		hre.jobtitle AS "JobTitle",
		pea.emailAddress AS "Email",
		ssp.SalesQuota AS "SalesQuota",
		ssp.Bonus AS "Bonus",
		ssp.CommissionPct AS "CommissionPct",
		ssp.salesYTD AS "SalesYTD",
		ssp.SalesLastYear AS "SalesLastYear",
		sst.name AS "Teritory",
		ssp.businessentityID AS "ID"
	SELECT *FROM sales.SalesPerson ssp
	LEFT JOIN person.Person pp ON pp.businessentityID = ssp.businessentityID
	LEFT JOIN sales.SalesTerritory sst ON sst.territoryID = ssp.territoryID
	LEFT JOIN humanResources.Employee hre ON hre.businessentityID = pp.businessentityID 
	LEFT JOIN person.EmailAddress pea ON pea.businessentityID = pp.businessentityID
	WHERE ssp.businessentityID >= offsets AND ssp.businessentityID <= limits;
		
BEGIN
	OPEN my_cursor;
	LOOP
		FETCH NEXT FROM my_cursor INTO 
		FullName,
		JobTitle,
		Email,
		SalesQuota,
		Bonus,
		CommissionPct,
		SalesYTD,
		SalesLastYear,
		Teritory,
		businessentityID;
		EXIT WHEN NOT FOUND;
		RETURN NEXT;
	END LOOP;
	CLOSE my_cursor;
END; $$
LANGUAGE PLPGSQL;
-- RUN 2
SELECT * FROM GetSalesPerson(10,800)