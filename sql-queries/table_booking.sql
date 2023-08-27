DROP PROCEDURE IF EXISTS `CheckBooking`;
DELIMITER $$
CREATE PROCEDURE CheckBooking(
    IN date DATE,
    IN tableNo INT
)
BEGIN
    DECLARE x INT DEFAULT 0;
    SELECT COUNT(*) 
    INTO x 
    FROM `bookings`
    WHERE `date` = date AND `table_no` = tableNO;
    IF x > 0 THEN
        SELECT CONCAT('Table ', tableNo, ' is already booked on ', date) AS booking_status;
    ELSE
        SELECT CONCAT('Table ', tableNo, ' is available on ', date) AS booking_status;
    END IF;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER $$

CREATE PROCEDURE AddValidBooking(
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE booking_count INT;
    
    START TRANSACTION;

    SELECT COUNT(*) 
    INTO booking_count 
    FROM `bookings`
    WHERE `date` = booking_date AND `table_no` = table_number;

    INSERT INTO `bookings` (`date`, `table_no`) VALUES (booking_date, table_number);    

    IF booking_count > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', table_number, ' is already booked on ', booking_date, ' - booking cancelled') AS booking_status;
    ELSE
        COMMIT;
        SELECT CONCAT('Table ', table_number, ' booked for ', booking_date) AS booking_status;
    END IF;
END $$

DELIMITER ;

CALL `AddValidBooking`('2020-03-01', 7);
