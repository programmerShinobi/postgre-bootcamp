-- RUN 1
CREATE OR REPLACE PROCEDURE sales.UpdateStatusSOHeader (
	c_salesOrderID INT,
	c_shipDate TIMESTAMP
)
LANGUAGE PLPGSQL
AS $$
BEGIN

UPDATE sales.salesOrderHeader
	SET status = 5, --status shipping
		shipDate = c_shipDate
	WHERE salesOrderID = c_salesOrderID;
COMMIT;
END; $$

-- RUN 2
SELECT * FROM sales.salesOrderHeader
ORDER BY salesOrderID DESC;

-- RUN 3
CALL sales.UpdateStatusSOHeader(
	75127 --salesOrderID
)
