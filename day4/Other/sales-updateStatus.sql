-- RUN 1
CREATE OR REPLACE PROCEDURE updateSales(
	ID INT,
	u_orderQty INT,
	u_unitPrice NUMERIC,
	u_subTotal NUMERIC,
	u_taxamt NUMERIC,
	u_freight NUMERIC,
	u_totalDue NUMERIC,
	u_status INT
)
LANGUAGE PLPGSQL
AS $$
BEGIN
UPDATE sales.salesorderheader so
SET
	sd.orderQty = u_orderqty,
	sd.unitPrice = u_unitprice, 
	so.subTotal = u_subtotal,
	sotaxamt = u_taxamt,
	so.freight = u_freight,
	so.totalDue = u_totaldue,
	so.status = u_status
	FROM so
	JOIN sales.salesOrderDetail sd on sd.salesOrderID = so.salesOrderID
	WHERE so.salesOrderID = id;
	COMMIT;
END;$$

-- RUN 2
CALL updateSales(43659, 
				
				);


SELECT * FROM sales.salesOrderHeader 
WHERE salesOrderID = 43659
ORDER BY salesOrderID DESC