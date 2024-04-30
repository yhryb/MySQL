-- Transactional mechanism with conditional logic
START TRANSACTION; -- updating the service table based on conditions

UPDATE service
SET price = price * 1.1
WHERE service_id IN (
    SELECT service_id
    FROM product
    WHERE cost > 10
);

IF (
SELECT COUNT(*)
FROM service
WHERE price < 100
    ) > 0 THEN
COMMIT;
ELSE -- if there are no services with prices less than 100 it means the transaction wasn't successful
ROLLBACK;
END IF;

END;


-- IN
DELIMITER //
CREATE PROCEDURE get_employee_by_service_id (IN service_id INT) BEGIN
SELECT *
FROM
    employee
WHERE
    service_id = service_id;
END //
DELIMITER ;

-- OUT
DELIMITER //
CREATE PROCEDURE get_total_appointments (OUT total_appointments INT)
BEGIN
SELECT COUNT(appointment_id) INTO total_appointments FROM appointment; -- counts the total number of appointments
END //
DELIMITER ;

-- INOUT
DELIMITER //
CREATE PROCEDURE update_price (IN service_id INT, INOUT new_price DECIMAL(10, 2))
BEGIN
    SET @cost := (SELECT cost FROM product WHERE service_id = service_id); -- gets out the stored cost of the chosen service
    IF @cost > 10 THEN
        SET new_price = new_price * 1.1;
END IF;
END //
DELIMITER ;