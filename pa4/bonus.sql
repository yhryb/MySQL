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