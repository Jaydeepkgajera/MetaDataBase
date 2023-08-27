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

-- AddBooking PROCEDURE
DROP PROCEDURE IF EXISTS `AddBooking`;
DELIMITER $$
CREATE PROCEDURE AddBooking(
  IN booking_date DATE,
  IN time_slot TIME,
  IN cust_id INT,
  IN table_no INT
)
BEGIN
INSERT INTO `bookings`
(`date`,`time`,`customer_id`,`table_no`) 
VALUES
(booking_date,time_slot,cust_id,table_no);
SELECT "New booking added" AS Confirmation;
END$$

DELIMITER;

-- UpdateBooking PROCEDURE
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER $$

CREATE PROCEDURE UpdateBooking(
  IN booking_id INT,
  IN booking_date DATE
)
BEGIN
UPDATE `bookings`
SET `date` = bookin_date
WHERE `booking_id` = booking_id;
SELECT CONCAT('Booking ', booking_id, ' updated') AS Confirmation;
END $$

DELIMITER ;

-- CancelBooking PROCEDURE
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER $$
CREATE PROCEDURE CancelBooking(
  IN booking_id INT
)
BEGIN
DELETE FROM `bookings`
WHERE `booking_id` = booking_id;
SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Confirmation;
END$$

DELIMITER ;



