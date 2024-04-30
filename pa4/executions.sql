-- Transactional mechanism with conditional logic
START TRANSACTION;

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
    ) > 0 THEN COMMIT;

ELSE ROLLBACK;

END IF;

-- IN
CREATE PROCEDURE GetEmployeeByServiceId (IN serviceId INT) BEGIN
SELECT
    *
FROM
    employee
WHERE
    service_id = serviceId;

END;

-- OUT
CREATE PROCEDURE GetTotalAppointmentsByEmployee (OUT totalAppointments INT) BEGIN
SELECT
    COUNT(appointment_id) INTO totalAppointments
FROM
    appointment;

END;

-- INOUT
CREATE PROCEDURE UpdatePrice (IN serviceId INT, INOUT newPrice DECIMAL(10, 2)) BEGIN DECLARE cost DECIMAL(10, 2);

SELECT
    cost INTO cost
FROM
    product
WHERE
    service_id = serviceId;

IF cost > 10 THEN
SET
  newPrice = newPrice * 1.1;

END IF;

-- bonus
START TRANSACTION;

UPDATE service
SET price = price * 1.1
WHERE service_id IN (
    SELECT service_id
    FROM product
    WHERE cost > 10
);

DECLARE @serviceCount INT;
SELECT @serviceCount = COUNT(*)
FROM service
WHERE price < 100;

INSERT INTO service (service_id, name, price)
VALUES (1001, 'New Service', 90.00);

UPDATE service
SET price = 120.00
WHERE service_id = 2001;

DELETE FROM service
WHERE service_id = 3001;

COMMIT;