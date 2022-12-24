SELECT * FROM sales.salesOrderHeader
ORDER BY salesOrderID DESC

-- RUN 1
CREATE OR REPLACE PROCEDURE sales.insert_salesOrderHeader
(
		c_salesOrderID INT,
		c_revisionNumber INT,
		c_orderDate TIMESTAMP,
		c_dueDate TIMESTAMP,
		c_status INT,
		c_customerID INT,
		c_billToAddressID INT,
		c_shipToAddressID INT,
		c_shipMethodID INT,
		c_subTotal NUMERIC,
		c_taxamt NUMERIC,
		c_freight NUMERIC
) 
LANGUAGE PLPGSQL AS
$$ 
BEGIN
    INSERT INTO sales.salesOrderHeader
	(
		salesOrderID,
		revisionNumber,
		orderDate,
		dueDate,
		status, 
		customerID,
		billToAddressID,
		shipToAddressID,
		shipMethodID,
		subTotal,
		taxamt,
		freight
		
	) VALUES (
		c_salesOrderID,
		c_revisionNumber,
		c_orderDate,
		c_dueDate,
		c_status,
		c_customerID,
		c_billToAddressID,
		c_shipToAddressID,
		c_shipMethodID,
		c_subTotal,
		c_taxamt,
		c_freight
    );
	COMMIT;
END 
$$;

-- RUN 2
CALL sales.insert_salesOrderHeader (
       	75124, --c_salesOrderID INT,
		8, --c_revisionNumber INT,
		'2023/01/01', --c_orderDate TIMESTAMP,
		'2023/01/12',--c_dueDate TIMESTAMP,
		1, --c_status INT, 
		18759, --c_customerID INT,
		24967, --c_billToAddressID INT,
		24967, --c_shipToAddressID INT,
		1, --c_shipMethodID INT,
		2, --c_subTotal NUMERIC,
		2, --c_taxamt NUMERIC,
		0 --c_freight NUMERIC
    );
	
-- RUN 3
SELECT * FROM sales.salesOrderHeader
WHERE salesOrderID = 75124


-- RUN 4
CREATE OR REPLACE PROCEDURE sales.insert_cart
(
	c_salesOrderDetailID INT,
    c_salesOrderID INT,
    c_carrierTrackingNumber VARCHAR,
    c_orderQTY INT,
    c_productid INT,
    c_specialOfferID INT, 
    c_unitPrice INT,
    c_unitPriceDiscount INT
) 
LANGUAGE PLPGSQL AS
$$ 
BEGIN
    INSERT INTO sales.salesOrderDetail
	(
		salesOrderDetailID,
		salesOrderID,
		carrierTrackingNumber,
		orderQTY,
		productid,
		specialOfferID, 
		unitPrice,
		unitPriceDiscount
	) VALUES (
	c_salesOrderDetailID,
	c_salesOrderID,
    c_carrierTrackingNumber,
    c_orderQTY,
    c_productid,
    c_specialOfferID, 
    c_unitPrice,
    c_unitPriceDiscount
    );
	COMMIT;
END 
$$;

-- RUN 5
CALL sales.insert_cart (
		121326, --salesOrderDetailID
        75124, --salesOrderID
        NULL, --carrierTrackingNumber
        3, --orderQTY
        776, --productID
        1, --specialOfferID
        9999, --unitPrice,
        10 --unitPriceDiscount
    );
	
-- RUN 6
SELECT * FROM sales.salesOrderDetail
WHERE salesOrderDetailID = 121326


