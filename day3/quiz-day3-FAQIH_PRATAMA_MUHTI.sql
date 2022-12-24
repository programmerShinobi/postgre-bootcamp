-- Modul Person
---- 1. SELECT PersonType, GroupName, TotalPerson
SELECT pp.personType AS "PersonType",
	(CASE
		WHEN pp.personType = 'IN' THEN 'Individual Customer'
		WHEN pp.personType = 'GC' THEN 'General Contact'
		WHEN pp.personType = 'EM' THEN 'Employee'
		WHEN pp.personType = 'VC' THEN 'Vendor Contact'
		WHEN pp.personType = 'SP' THEN 'Sales Person'
		WHEN pp.personType = 'SC' THEN 'Sales Contact'

	END) AS "PersonType",
	COUNT(pp.personType) AS "TotalPerson"
	FROM person.person pp
	GROUP BY pp.personType;
	
---- 2. SELECT businessentityId, FullName, EmailAddress, PhoneNumber, Address, AddressType
SELECT pp.businessentityId AS "BusinessentityId",
	pp.lastName AS "FullName",
	pea.EmailAddress AS "EmailAddress", 
	ppp.phonenumber AS "PhoneNumber",
	CONCAT(pa.addressline1, ' ',pa.addressline2, ', ', pa.city, ', ', psp.name, ', ', pcr.name) AS "Address",
	ppnt.name AS "AddressType"
	FROM person.person pp
	JOIN person.EmailAddress pea ON pea.businessentityId = pp.businessentityId
	JOIN person.PersonPhone ppp ON ppp.businessentityId = pp.businessentityId
	JOIN person.BusinessEntity pbe ON pbe.businessentityId = pp.businessentityId
	JOIN person.BusinessEntityAddress pbea ON pbea.businessentityId = pp.businessentityId
	JOIN person.Address pa ON pa.addressId = pbea.addressId
	JOIN person.StateProvince psp ON psp.stateProvinceID = pa.stateProvinceID
	JOIN person.CountryRegion pcr ON pcr.CountryRegionCode = psp.CountryRegionCode
	JOIN person.PhoneNumberType ppnt ON ppnt.phoneNumberTypeID = ppp.phoneNumberTypeID
	WHERE pcr.CountryRegionCode = 'US'
	GROUP BY pp.businessentityId, "FullName", pea.EmailAddress, ppp.phonenumber, "Address", "AddressType"
	ORDER BY pp.businessentityId ASC;


---- 3.	Menampilkan total person yang di group berdarkan personType & Country
----	SELECT countryRegionCode, countryName, PersonTypeDesc, totalPerson
SELECT pcr.countryRegionCode AS "CountryRegionCode",
		pcr.name AS "CountryName",
		(CASE
			WHEN pp.personType = 'IN' THEN 'Individual Customer'
			WHEN pp.personType = 'GC' THEN 'General Contact'
			WHEN pp.personType = 'EM' THEN 'Employee'
			WHEN pp.personType = 'VC' THEN 'Vendor Contact'
			WHEN pp.personType = 'SP' THEN 'Sales Person'
			WHEN pp.personType = 'SC' THEN 'Sales Contact'
		END) AS "PersonTypeDesc",
		COUNT(pp.businessEntityID) AS "TotalPerson"
		FROM person.Person pp
		JOIN person.BusinessEntity pbe ON pbe.businessEntityID = pp.businessEntityID
		JOIN person.BusinessEntityAddress pbea ON pbea.businessEntityID = pbe.businessEntityID
		JOIN person.Address pa ON pa.addressID = pbea.addressID
		JOIN person.StateProvince psp ON psp.StateProvinceID = pa.StateProvinceID
		JOIN person.CountryRegion pcr ON pcr.countryRegionCode = psp.countryRegionCode
		GROUP BY pcr.countryRegionCode, pp.personType
		ORDER BY pcr.countryRegionCode ASC;
		

---- 4.	SELECT CountryRegionCode, Name, Individual Customer, Employee, Sales Person, Sales Contact, Vendor Contact
SELECT pcr.countryRegionCode AS "CountryRegionCode",
	pcr.name AS "Name",
	(SUM(CASE
		WHEN pp.personType = 'IN' THEN 1
	  	ELSE 0
	END)) AS "Individual Customer",
	(SUM(CASE
		WHEN pp.personType = 'EM' THEN 1
		ELSE 0
	END)) AS "Employee",
	(SUM(CASE
		WHEN pp.personType = 'SP' THEN 1
		ELSE 0
	END)) AS "Sales Person",
	(SUM(CASE
		WHEN pp.personType = 'SC' THEN 1
		ELSE 0
	END)) AS "Sales Contact",
	(SUM(CASE
		WHEN pp.personType = 'VC' THEN 1
		ELSE 0
	END)) AS "Vendor Contact",
	(SUM(CASE
		WHEN pp.personType = 'GC' THEN 1
		ELSE 0
	END)) AS "General Contact"
	FROM person.CountryRegion pcr
	JOIN person.StateProvince psp ON psp.countryRegionCode = pcr.countryRegionCode
	JOIN person.Address pa ON pa.StateProvinceID = psp.stateProvinceID
	JOIN person.BusinessEntityAddress pbea ON pbea.addressID = pa.addressID
	JOIN person.BusinessEntity pbe ON pbe.businessEntityID = pbea.businessEntityID
	JOIN person.person pp ON pp.businessEntityID = pbe.businessEntityID
	GROUP BY pcr.countryRegionCode
	ORDER BY pcr.countryRegionCode ASC;


---- 5.	Menampilkan menampilkan total employee tiap department
----	SELECT DepartmentID, Name, TotalEmployee
SELECT hrd.departmentID AS "DepartmentID", 
	hrd.name AS "Name",
	COUNT(hre.businessEntityID) AS "TotalEmployee"
	FROM humanResources.department hrd
	JOIN humanResources.EmployeeDepartmentHistory hred ON hred.departmentID = hrd.departmentID
	JOIN humanResources.Employee hre ON hre.businessEntityID = hred.businessEntityID
	GROUP BY hrd.departmentID
	ORDER BY hrd.name ASC;


---- 6. Menampilkan jumlah pegawai tiap department yang digroup berdasarkan shift nya
----	SELECT Name, Day, Evening, Night
SELECT hrd.name AS "Name",
	(SUM(CASE
		WHEN hredh.shiftId = 1 THEN 1
	 	ELSE 0
	END)) AS "Day",
	(SUM(CASE
		WHEN hredh.shiftId = 2 THEN 1
	 	ELSE 0
	END)) AS "Evening",
	(SUM(CASE
		WHEN hredh.shiftId = 3 THEN 1
	 	ELSE 0
	END)) AS "Night"
	FROM humanResources.department hrd
	JOIN humanResources.EmployeeDepartmentHistory hredh ON hredh.departmentID = hrd.departmentID
	GROUP BY hrd.name
	ORDER BY hrd.name ASC;
	

---- 7. Menampilkan data PurchaseOrder Vendor (order by status [Completed]) berdasarkan status-nya [1=Pending | 2=Approved | 3=Rejected | 4=Complete]
----	SELECT AccountNumber, VendorName, Pending, Approved, Reject, Completed
SELECT pv.accountNumber AS "AccountNumber", 
	pv.name AS "VendorName",  
	(SUM(CASE
		WHEN ppoh.status = 1 THEN 1
		ELSE 0
	END)) AS "Pending",
	(SUM(CASE
		WHEN ppoh.status = 2 THEN 1
		ELSE 0
	END)) AS "Approved",
	(SUM(CASE
		WHEN ppoh.status = 3 THEN 1
		ELSE 0
	END)) AS "Reject",
	(SUM(CASE
		WHEN ppoh.status = 4 THEN 1
		ELSE 0
	END)) AS "Completed"
	FROM purchasing.vendor pv
	LEFT JOIN purchasing.ProductVendor ppv ON ppv.businessEntityID = pv.businessEntityID 
	LEFT JOIN production.Product pp ON pp.productID = ppv.productID
	LEFT JOIN purchasing.PurchaseOrderDetail ppod ON ppod.productID = pp.productID
	LEFT JOIN purchasing.PurchaseOrderHeader ppoh ON ppoh.purchaseOrderID = ppod.purchaseOrderID
	GROUP BY pv.accountNumber, pv.name
	ORDER BY "Completed" DESC;
	

---- 8.	Menampilkan data salesorder yang di order oleh customer dan tampilkan statusnya [1=InProcess | 2=Approved| 3=BackOrdered| 4=Rejected | 5 = Shipped | 6=Cancelled]
----	SELECT CustomerID, CustomerName, InProcess, Approved, BackOrdered, Rejected, Shipped, Cancelled
SELECT sc.customerID AS "CustomerID",
	(CONCAT(pp.firstName, ' ', pp.middleName, ' ', pp.lastName)) AS "CustomerName",
	(SUM(CASE
		WHEN ssoh.status = 1 THEN 1
		ELSE 0
	END)) AS "InProcess",
	(SUM(CASE
		WHEN ssoh.status = 2 THEN 1
		ELSE 0
	END)) AS "Approved",
	(SUM(CASE
		WHEN ssoh.status = 3 THEN 1
		ELSE 0
	END)) AS "BackOrdered",
	(SUM(CASE
		WHEN ssoh.status = 4 THEN 1
		ELSE 0
	END)) AS "Rejected",
	(SUM(CASE
		WHEN ssoh.status = 5 THEN 1
		ELSE 0
	END)) AS "Shipped",
	(SUM(CASE
		WHEN ssoh.status = 6 THEN 1
		ELSE 0
	END)) AS "Cancelled"
	FROM sales.SalesOrderHeader ssoh
	JOIN sales.Customer sc ON ssoh.customerID = sc.customerID
	JOIN person.Person pp ON pp.businessEntityID = sc.personID
	GROUP BY sc.customerID, "CustomerName"
	ORDER BY "CustomerName" ASC;

---- 9.	Menampilkan informasi category product yang dibeli oleh customer
----	SELECT CustomerId, CustomerName, Accessories, Bikes, Components, Clothing
SELECT sc.customerId AS "CustomerId", 
	CONCAT(pp.firstName, ' ',pp.middleName, ' ', pp.lastName)AS "CustomerName",
	(SUM(CASE
		WHEN pps.productCategoryId = 4 THEN 1
		ELSE 0
	END)) AS "Accessories",
	(SUM(CASE
		WHEN pps.productCategoryId = 1 THEN 1
		ELSE 0
	END)) AS "Bikes",
	(SUM(CASE
		WHEN pps.productCategoryId = 2 THEN 1
		ELSE 0
	END)) AS "Components",
	(SUM(CASE
		WHEN pps.productCategoryId = 3 THEN 1
		ELSE 0
	END)) AS "Clothing"
	FROM sales.Customer sc
	JOIN person.Person pp ON pp.businessEntityID = sc.personID
	JOIN sales.SalesOrderHeader ssoh ON ssoh.customerID = sc.customerID
	JOIN sales.SalesOrderDetail ssod ON ssod.salesOrderID = ssoh.salesOrderID
	JOIN production.Product prod ON prod.productID = ssod.productID
	JOIN production.ProductSubcategory pps ON pps.ProductSubcategoryID = prod.ProductSubcategoryID
	GROUP BY sc.customerID, "CustomerName"
	ORDER BY "CustomerName" ASC

---- 10. Menampilkan product yang sudah dilakukan discount per tahun dan bulan, pastikan type special offer <> ‘No Discount’ 	
----	SELECT ProductID, ProductName, discountPct, Year Discount, January, February, Maret, April, May, June, July, August, September, October, November, Desember
SELECT prod.productID AS "ProductID", 
	prod.name AS "ProductName", 
	(CASE
		WHEN sso.discountPct IS NULL THEN 0
		WHEN sso.discountPct = 0 THEN 0
		ELSE sso.discountPct
	END) AS "discountPct", 
	(CASE 
		WHEN (SELECT EXTRACT(YEAR FROM sso.startDate)) IS NULL THEN 0
	 	WHEN (SELECT EXTRACT(YEAR FROM sso.startDate)) = 0 THEN 0
		ELSE (SELECT EXTRACT(YEAR FROM sso.startDate)) 
	 END) AS "Year Discount",
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 1 THEN 1
		ELSE 0
	END)) AS "January",
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 2 THEN 1
		ELSE 0
	END)) AS "February", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 3 THEN 1
		ELSE 0
	END)) AS "Maret", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 4 THEN 1
		ELSE 0
	END)) AS "April", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 5 THEN 1
		ELSE 0
	END)) AS "May", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 6 THEN 1
		ELSE 0
	END)) AS "June", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 7 THEN 1
		ELSE 0
	END)) AS "July", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 8 THEN 1
		ELSE 0
	END)) AS "August", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 9 THEN 1
		ELSE 0
	END)) AS "September", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 10 THEN 1
		ELSE 0
	END)) AS "October", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 11 THEN 1
		ELSE 0
	END)) AS "November", 
	(SUM(CASE
		WHEN (SELECT EXTRACT(MONTH FROM sso.startDate)) = 12 THEN 1
		ELSE 0
	END)) AS "Desember"
	FROM production.Product prod
	JOIN sales.SpecialOfferProduct ssop ON ssop.productID = prod.productID 
	JOIN sales.SpecialOffer sso ON sso.specialOfferID = ssop.specialOfferID
	WHERE sso.type <> 'No Discount'
	GROUP BY "ProductID", "ProductName", "discountPct", "Year Discount"
	ORDER BY "Year Discount" DESC;
	

	

---- SELECT *
SELECT * FROM person.person

SELECT * FROM person.EmailAddress

SELECT * FROM person.PersonPhone

SELECT * FROM person.BusinessEntity

SELECT * FROM person.BusinessEntityAddress

SELECT * FROM person.Address

SELECT * FROM person.StateProvince

SELECT * FROM person.CountryRegion

SELECT * FROM person.PhoneNumberType

SELECT * FROM humanResources.department

SELECT * FROM humanResources.EmployeeDepartmentHistory

SELECT * FROM humanResources.employee

SELECT * FROM humanResources.Shift

SELECT * FROM purchasing.ProductVendor

SELECT * FROM purchasing.PurchaseOrderHeader

SELECT * FROM production.product

SELECT * FROM production.ProductCategory

SELECT * FROM production.ProductSubcategory

SELECT * FROM production.Document

SELECT * FROM sales.salesOrderDetail

SELECT * FROM sales.SalesOrderHeader

SELECT * FROM sales.SpecialOfferProduct

SELECT * FROM sales.store

SELECT * FROM sales.customer

SELECT * FROM production.product