-- Use of prepared statement.
PREPARE insert_address FROM
'INSERT INTO address VALUES
(?, ?, ?, ?, ?);';

SET @d1 = 3;
SET @d2 = 'test';
SET @d3 = 'test';
SET @d4 = 'test';
SET @d5 = 400100;
EXECUTE insert_address USING @d1, @d2, @d3, @d4, @d5;

-- Creating the procedure CancelOrder.
CREATE DEFINER=`JaydeepGajera`@`%` PROCEDURE `CancelOrder`(
IN ID INT,
OUT msg VARCHAR(255)
)
BEGIN
  DELETE
  FROM `orders`
  WHERE `OrderID` = ID;
  SET msg = CONCAT("Order ", ID, " has been canceled.");
  SELECT @msg AS Confirmation;
END;

-- Creating the procedure GetMaxQuantity.
CREATE DEFINER=`JaydeepGajera`@`%` PROCEDURE `GetMaxQuantity`()
SELECT MAX(`Quantity`) AS 'Max Order Quantity'
    FROM `orders`;

