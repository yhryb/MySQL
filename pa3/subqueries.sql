-- = service based on product
SELECT *
FROM service
WHERE service_id = (SELECT service_id FROM product WHERE product_id = 1);

-- UPDATE IN updates the price column in the service table
UPDATE service
SET price = price * 1.1
WHERE service_id IN (SELECT service_id FROM product WHERE cost > 10);

-- DELETE NOT IN removes customers whose customer_id is not found in the customer_id list from the appointment table
DELETE FROM customer
WHERE customer_id NOT IN (SELECT customer_id FROM appointment);

-- EXISTS selects employees where there exists at least one record in the Employee_Service table where the employee_id matches the employee's employee_id in the main table
SELECT *
FROM employee
WHERE EXISTS (SELECT 1 FROM Employee_Service es WHERE es.employee_id = es.employee_id);

-- NOT EXISTS selects services where there does not exist any record in the product table where the product.service_id matches the service_id in the service table
SELECT *
FROM service
WHERE NOT EXISTS (SELECT 1 FROM product WHERE product.service_id = service.service_id);

--  = retrieves all employee details where their service_id directly matches the service_id retrieved from an appointment
SELECT e.*
FROM employee e
         JOIN appointment a ON e.employee_id = a.employee_id;

-- IN retrieves all service details where the service_id is present in the list of service_ids retrieved from the Employee_Service table for a specific employee ID 
SELECT *
FROM service
WHERE service_id IN (SELECT service_id FROM Employee_Service WHERE employee_id = 1);


-- NOT IN retrieves all employee details but excludes those whose employee_id is present in the list of employee_ids retrieved from the Employee_Service table where the service_id is 1
SELECT *
FROM employee e
WHERE e.employee_id NOT IN (SELECT employee_id FROM Employee_Service WHERE service_id = 1);


-- EXISTS retrieves all service details where there exists at least one record in the Employee_Services table that matches the service_id in the service table
SELECT *
FROM service s
WHERE EXISTS (
    SELECT 1
    FROM Employee_Service es
    WHERE es.service_id = s.service_id
);


-- NOT EXISTS retrieves all employee details but excludes those where there exists at least one record in the appointment table that matches the employee's employee_id
SELECT *
FROM employee e
WHERE NOT EXISTS (SELECT 1 FROM appointment a WHERE a.employee_id = e.employee_id);


-- UNION returns a list of phone numbers with no duplicates, even if the same phone number exists for both a customer and an employee
SELECT customer_name, phone_number
FROM customer
UNION
SELECT employee_name, phone
FROM employee;

-- UNION ALL same as before but includes all rows, even duplicates
SELECT customer_name, phone_number
FROM customer
UNION ALL
SELECT employee_name, phone
FROM employee;


-- INTERSECT finds the intersection of email addresses that exist for both customers and employees
SELECT customer_name, email
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM employee e
    WHERE e.email = c.email
);
-- EXCEPT finds the difference between customer addresses and employee emails
SELECT customer_name, address
FROM customer
WHERE NOT EXISTS (
    SELECT employee_name, email
    FROM employee
)