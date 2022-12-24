-- Task 1 : AddToCart
-- Menampilkan data sales berdasarkan harga (price)
SELECT * 
FROM sales.SalesOrderHeader
ORDER BY salesOrderID ASC;

-- Create Procedure Sales.AddToCart
CREATE OR REPLACE PROCEDURE insert_cart
(
    salesOrderID INT,
    carrierTrackingNumber VARCHAR(25),
    orderQTY INT,
    product_id INT,
    specialOfferID INT, 
    unitPrice NUMERIC,
    unitPriceDiscount NUMERIC,
    rowguid UUID,
    modifedDate TIMESTAMP
) AS
$$
BEGIN
    INSERT INTO sales.salesOrderDetail (
        salesOrderDetailID,
        salesOrderID,
        carrierTrackingNumber,
        orderQTY,
        product_id,
        specialOfferID, 
        unitPrice,
        unitPriceDiscount,
        rowguid UUID,
        modifedDate
    ) VALUES (
        121318, --salesOrderDetailID
        1, --salesOrderID
        NULL, --carrierTrackingNumber
        3, --orderQTY
        1, --product_id
        1, --specialOfferID
        9999, --unitPrice
        10, --unitPriceDiscount
        UUID, --rowguid
        CURRENT_TIMESTAMP, --modifedDate
    )
END;
$$
LANGUAGE PLPGSQL;

-- 
-- 
-- 
-- Task 1 : AddToCart
-- Create Procedure Sales.AddToCart
CREATE OR REPLACE PROCEDURE insert_cart
(
    c_salesOrderID INT,
    c_carrierTrackingNumber INT,
    c_orderQTY INT,
    c_product_id INT,
    c_specialOfferID INT, 
    c_unitPrice INT,
    c_unitPriceDiscount INT,
    c_modifedDate TIMESTAMP,
	c_salesOrderDetailID INOUT INT
) 
LANGUAGE PLPGSQL AS
$$ 
BEGIN
    INSERT INTO sales.salesOrderDetail (
        salesOrderID,
        carrierTrackingNumber,
        orderQTY,
        product_id,
        specialOfferID, 
        unitPrice,
        unitPriceDiscount,
        modifedDate
    ) VALUES (
	c_salesOrderID,
    c_carrierTrackingNumber,
    c_orderQTY,
    c_product_id,
    c_specialOfferID, 
    c_unitPrice,
    c_unitPriceDiscount,
    c_modifedDate
    ) RETURNING salesOrderDetailID = c_salesOrderDetailID;
END 
$$;

CALL insert_cart(
        1, --salesOrderID
        1, --carrierTrackingNumber
        3, --orderQTY
        1, --product_id
        1, --specialOfferID
        9999, --unitPrice
        10, --unitPriceDiscount
        CURRENT_TIMESTAMP, --modifedDate
		121318 --salesOrderDetailID
    );


-- 
-- 
-- 