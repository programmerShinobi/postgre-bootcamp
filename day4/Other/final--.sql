CREATE TABLE sales.AddToCart (
    salesOrderDetailID INT, 
	salesOrderID INT,
    carrierTrackingNumber VARCHAR(25),
    orderQTY INT,
    productID INT,
    specialOfferID INT, 
    unitPrice NUMERIC,
    unitPriceDiscount NUMERIC,
    modifedDate TIMESTAMP,
	PRIMARY KEY (salesOrderDetailID),
	FOREIGN KEY (salesOrderID) REFERENCES sales.salesOrderHeader(salesOrderID),
	FOREIGN KEY (productID) REFERENCES production.product(productID),
	FOREIGN KEY (specialOfferID) REFERENCES sales.specialOffer
);


-- Task 1 : AddToCart
-- Create Procedure Sales.AddToCart
CREATE PROCEDURE insert_cart
(
	c_salesOrderDetailID INT,
    c_salesOrderID INT,
    c_carrierTrackingNumber INT,
    c_orderQTY INT,
    c_product_id INT,
    c_specialOfferID INT, 
    c_unitPrice INT,
    c_unitPriceDiscount INT,
	c_rowguid VARCHAR(255),
    c_modifedDate TIMESTAMP
) 
LANGUAGE PLPGSQL AS
$$ 
BEGIN
    INSERT INTO sales.salesOrderDetail VALUES (
	c_salesOrderDetailID,
	c_salesOrderID,
    c_carrierTrackingNumber,
    c_orderQTY,
    c_product_id,
    c_specialOfferID, 
    c_unitPrice,
    c_unitPriceDiscount,
	c_rowguid,
    c_modifedDate
    );
	COMMIT;
END 
$$;

CALL insert_cart(
		121319, --salesOrderDetailID
        43659, --salesOrderID
        1, --carrierTrackingNumber
        3, --orderQTY
        1, --product_id
        1, --specialOfferID
        9999, --unitPrice,
		1,
        10, --unitPriceDiscount
        CURRENT_DATE --modifedDate
    );
	

SELECT * FROM sales.salesOrderDetail
SELECT * FROM sales.salesOrderHeader
ORDER BY salesOrderID DESC
INSERT INTO sales.salesOrderHeader (
	salesOrderID,
	revisiOnNumber,
	orderDate,
	dueDate,
	shipDate,
	status,
	onlineOrderFlag,
	purchaseOrderNumber,
	accountNumber,
	customerID,
	salesPersonID,
	territoryID,
	billToAddressID,
	shipToAddressID,
	shipMethodID,
	creditCardID,
	creditCardApprovalCode,
	currencyRateID,
	subTotal,
	taxamt,
	freight,
	totalDue,
	comment,
	rowguid,
	modifiedDate
)



CREATE TABLE sales.AddToCart (
    salesOrderDetailID INT, 
	salesOrderID INT,
    carrierTrackingNumber VARCHAR(25),
    orderQTY INT,
    productID INT,
    specialOfferID INT, 
    unitPrice NUMERIC,
    unitPriceDiscount NUMERIC,
    modifedDate TIMESTAMP,
	PRIMARY KEY (salesOrderDetailID),
	FOREIGN KEY (salesOrderID) REFERENCES sales.salesOrderHeader(salesOrderID),
	FOREIGN KEY (productID) REFERENCES production.product(productID),
	FOREIGN KEY (specialOfferID) REFERENCES sales.specialOffer
);

-- Task 1 : AddToCart
-- Create Procedure Sales.AddToCart
CREATE PROCEDURE insert_cart
(
	c_salesOrderDetailID INT,
    c_salesOrderID INT,
    c_carrierTrackingNumber INT,
    c_orderQTY INT,
    c_product_id INT,
    c_specialOfferID INT, 
    c_unitPrice INT,
    c_unitPriceDiscount INT,
    c_modifedDate TIMESTAMP
) 
LANGUAGE PLPGSQL AS
$$ 
BEGIN
    INSERT INTO sales.addToCart VALUES (
	c_salesOrderDetailID,
	c_salesOrderID,
    c_carrierTrackingNumber,
    c_orderQTY,
    c_product_id,
    c_specialOfferID, 
    c_unitPrice,
    c_unitPriceDiscount,
    c_modifedDate
    );
	commit;
END 
$$;

CALL insert_cart(
		121319, --salesOrderDetailID
        43659, --salesOrderID
        1, --carrierTrackingNumber
        3, --orderQTY
        1, --product_id
        1, --specialOfferID
        9999, --unitPrice
        10, --unitPriceDiscount
        CURRENT_DATE --modifedDate
    );
	
	SELECT * FROM sales.addtocart
	
	SELECT * FROM sales.salesOrderDetail
	ORDER BY salesorderID DESC



    -- 
    -- 
    -- 
    -- 
CREATE OR REPLACE PROCEDURE sales.insert_cart
(
	c_salesOrderDetailID INT,
    c_salesOrderID INT,
    c_carrierTrackingNumber VARCHAR,
    c_orderQTY INT,
    c_product_id INT,
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
		product_id,
		specialOfferID, 
		unitPrice,
		unitPriceDiscount
	) VALUES (
	c_salesOrderDetailID,
	c_salesOrderID,
    c_carrierTrackingNumber,
    c_orderQTY,
    c_product_id,
    c_specialOfferID, 
    c_unitPrice,
    c_unitPriceDiscount
    );
	COMMIT;
END 
$$;

CALL sales.insert_cart (
		121319, --salesOrderDetailID
        43659, --salesOrderID
        'approved', --carrierTrackingNumber
        3, --orderQTY
        1, --product_id
        1, --specialOfferID
        9999, --unitPrice,
		1,
        10 --unitPriceDiscount
    );