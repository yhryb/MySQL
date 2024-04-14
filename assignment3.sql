CREATE TABLE service (
                         service_id INT AUTO_INCREMENT PRIMARY KEY,
                         service_name VARCHAR(50) NOT NULL,
                         description TEXT,
                         duration INT NOT NULL,
                         price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE product (
                         product_id INT AUTO_INCREMENT PRIMARY KEY,
                         service_id INT,
                         product_name VARCHAR(50) NOT NULL,
                         description TEXT,
                         quantity INTEGER NOT NULL,
                         cost DECIMAL(10, 2) NOT NULL,
                         FOREIGN KEY (service_id) REFERENCES service(service_id)
);

CREATE TABLE payment (
                         payment_id INT AUTO_INCREMENT PRIMARY KEY,
                         customer_id INT,
                         appointment_id INT,
                         amount DECIMAL(10, 2) NOT NULL,
                         payment_method VARCHAR(50) NOT NULL,
                         payment_date DATE NOT NULL,
);

CREATE TABLE customer (
                          product_id INT AUTO_INCREMENT PRIMARY KEY,
                          appointment_id INT,
                          payment_id INT,
                          customer_name VARCHAR(50) NOT NULL,
                          phone_number VARCHAR(15),
                          email VARCHAR(50),
                          address VARCHAR(100),
                          FOREIGN KEY (payment_id) REFERENCES payment(payment_id)
);

CREATE TABLE employee (
                          employee_id INT AUTO_INCREMENT PRIMARY KEY,
                          employee_name VARCHAR(50) NOT NULL,
                          phone VARCHAR(15),
                          email VARCHAR(50),
                          position VARCHAR(50) NOT NULL,
                          salary DECIMAL(10, 2),
                          service_id int not null,
                          FOREIGN KEY (service_id) REFERENCES service(service_id)
);

CREATE TABLE appointment (
                             appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                             customer_id INT,
                             service_id INT,
                             employee_id INT,
                             appointment_date DATE NOT NULL,
                             appointment_time TIME,
                             FOREIGN KEY (service_id) REFERENCES service(service_id),
                             FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE Employee_Service (
                                  employee_id INT NOT NULL,
                                  service_id INT NOT NULL,
                                  PRIMARY KEY (employee_id, service_id),
                                  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
                                  FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE services2products_unique (
                                          service_id INT NOT NULL,
                                          product_id INT NOT NULL,
                                          PRIMARY KEY (service_id, product_id),
                                          FOREIGN KEY (service_id) REFERENCES service(service_id),
                                          FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE customers2appointments_unique (
                                               customer_id INT NOT NULL,
                                               appointment_id INT NOT NULL,
                                               PRIMARY KEY (customer_id, product_id),
                                               FOREIGN KEY (customer_id) REFERENCES appointment(customer_id),
                                               FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);

INSERT INTO service (service_id, service_name, duration, price) VALUES
                                                                    (1, 'Haircut', 30, 25.00),
                                                                    (2, 'Manicure', 45, 15.00),
                                                                    (3, 'Pedicure', 60, 20.00),
                                                                    (4, 'Facial', 45, 30.00),
                                                                    (5, 'Massage', 60, 40.00);

INSERT INTO product (product_id, product_name, quantity, cost) VALUES
                                                                   (1, 'Shampoo', 50, 10.00),
                                                                   (2, 'Conditioner', 40, 8.00),
                                                                   (3, 'Nail Polish', 100, 5.00),
                                                                   (4, 'Moisturizer', 30, 15.00),
                                                                   (5, 'Massage Oil', 20, 20.00);

INSERT INTO customer (customer_id, customer_name, phone_number, email) VALUES
                                                                           (1, 'John Doe', '123-456-7890', 'john.doe@example.com'),
                                                                           (2, 'Jane Smith', '987-654-3210', 'jane.smith@example.com'),
                                                                           (3, 'Mike Johnson', '555-123-4567', 'mike.johnson@example.com'),
                                                                           (4, 'Emily Davis', '111-222-3333', 'emily.davis@example.com'),
                                                                           (5, 'Sarah Wilson', '444-555-6666', 'sarah.wilson@example.com');

INSERT INTO appointment (appointment_id, customer_id, service_id, appointment_date, appointment_time) VALUES
                                                                                                          (1, 1, 1, '2022-01-01', '10:00:00'),
                                                                                                          (2, 2, 2, '2022-01-02', '14:30:00'),
                                                                                                          (3, 3, 3, '2022-01-03', '11:15:00'),
                                                                                                          (4, 4, 4, '2022-01-04', '16:45:00'),
                                                                                                          (5, 5, 5, '2022-01-05', '09:30:00');

INSERT INTO payment (payment_id, appointment_id, payment_date, amount, payment_method) VALUES
                                                                                           (1, 1, '2022-01-01', 25.00, 'Cash'),
                                                                                           (2, 2, '2022-01-02', 15.00, 'Credit Card'),
                                                                                           (3, 3, '2022-01-03', 20.00, 'Cash'),
                                                                                           (4, 4, '2022-01-04', 30.00, 'Credit Card'),
                                                                                           (5, 5, '2022-01-05', 40.00, 'Cash');

INSERT INTO employee (employee_id, employee_name, phone, email, position, salary) VALUES
                                                                                      (1, 'Amy Johnson', '123-456-7890', 'amy.johnson@example.com', 'Hair Stylist', 2500.00),
                                                                                      (2, 'Mark Davis', '987-654-3210', 'mark.davis@example.com', 'Nail Technician', 1800.00),
                                                                                      (3, 'Lisa Smith', '555-123-4567', 'lisa.smith@example.com', 'Esthetician', 2000.00),
                                                                                      (4, 'David Wilson', '111-222-3333', 'david.wilson@example.com', 'Massage Therapist', 3000.00),
                                                                                      (5, 'Karen Brown', '444-555-6666', 'karen.brown@example.com', 'Receptionist', 1500.00);

--
SELECT position, AVG(salary) AS average_salary
FROM employee
GROUP BY position
HAVING average_salary > 2000;

--calculates the total payment amount of customers
--c. is a shorthand for customer table
--a. is a shorthand for appointment table
--p. is a shorthand for payment table
SELECT c.customer_name, SUM(p.amount) AS total_payment_amount
FROM customer c
         JOIN appointment a ON c.customer_id = a.customer_id
         JOIN payment p ON a.appointment_id = p.appointment_id
GROUP BY c.customer_name
ORDER BY total_payment_amount DESC
    LIMIT 5; -- returns the top 5 customers with the highest total payment amounts

--shows customers who made payments with Credit Card
SELECT c.customer_name, p.payment_id, p.amount, p.payment_method
FROM customer c
         JOIN appointment a ON c.customer_id = a.customer_id
         JOIN payment p ON a.appointment_id = p.appointment_id
WHERE p.payment_method = 'Credit Card';

--additional query (payment method count)
SELECT payment_method, COUNT(payment_id) AS total_payments, SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method;

--query 4 amount of appointments each employee has for a certain service
SELECT e.employee_name, s.service_name, COUNT(a.appointment_id) AS appointment_count
FROM Employee_Services
         JOIN employee e ON es.employee_id = e.employee_id
         JOIN service s ON es.service_id = s.service_id
         JOIN appointment a ON e.employee_id = a.employee_id AND s.service_id = a.service_id
WHERE (DATE(date) = date_sub(date('2011-09-17 00:00:00'), INTERVAL 1 week));
GROUP BY e.employee_id, s.service_id
ORDER BY appointment_count DESC;

--query 5 shows customer preference.
SELECT c.customer_name, s.service_name, COUNT(a.appointment_id) AS appointment_count
FROM Appointment 
         JOIN Customer c ON a.customer_id = c.customer_id
         JOIN Service s ON a.service_id = s.service_id
GROUP BY c.customer_id, s.service_id
ORDER BY appointment_count DESC;

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
WHERE EXISTS (SELECT 1 FROM Employee_Service es WHERE es.employee_id = e.employee_id);

-- NOT EXISTS selects services where there does not exist any record in the product table where the product.service_id matches the service_id in the service table
SELECT *
FROM service
WHERE NOT EXISTS (SELECT 1 FROM product WHERE product.service_id = service.service_id);

--  = retrieves all employee details where their service_id directly matches the service_id retrieved from an appointment
SELECT *
FROM employee
WHERE e.service_id = (SELECT service_id FROM appointment a WHERE a.employee_id = e.employee_id);

-- IN retrieves all service details where the service_id is present in the list of service_ids retrieved from the Employee_Service table for a specific employee ID 
SELECT *
FROM service
WHERE service_id IN (SELECT service_id FROM Employee_Services WHERE es.employee_id = 1);

-- NOT IN retrieves all employee details but excludes those whose employee_id is present in the list of employee_ids retrieved from the Employee_Service table where the service_id is 1
SELECT *
FROM employee
WHERE e.employee_id NOT IN (SELECT employee_id FROM Employee_Services WHERE es.service_id = 1);

-- EXISTS retrieves all service details where there exists at least one record in the Employee_Services table that matches the service_id in the service table
SELECT *
FROM service
WHERE EXISTS (SELECT 1 FROM Employee_Services WHERE es.service_id = s.service_id);

-- NOT EXISTS retrieves all employee details but excludes those where there exists at least one record in the appointment table that matches the employee's employee_id
SELECT *
FROM employee
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
FROM customer
INTERSECT
SELECT employee_name, email
FROM employee;

-- EXCEPT finds the difference between customer addresses and employee emails
SELECT customer_name, address
FROM customer
EXCEPT
SELECT employee_name, email
FROM employee;


-- Transactional mechanism with conditional logic
START TRANSACTION;

UPDATE service
SET price = price * 1.1
WHERE service_id IN (
        SELECT service_id
        FROM product
        WHERE cost > 10
    );

IF(
SELECT COUNT(*)
FROM service
WHERE price < 100 
    ) > 0 THEN COMMIT;

ELSE ROLLBACK;

END IF;

-- IN
CREATE PROCEDURE GetEmployeeByServiceId (IN serviceId INT) BEGIN
SELECT *
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

SELECT cost INTO cost
FROM product
WHERE service_id = serviceId;

IF cost > 10 THEN
SET
  newPrice = newPrice * 1.1;

END IF;

END;


-- View
CREATE VIEW employee_schedule AS
SELECT e.employee_name AS "Employee Name",
    GROUP_CONCAT(
        DISTINCT s.service_name
    ORDER BY s.service_name
  ) AS "Services Provided",
    CONCAT (
            a.appointment_time,
            '-',
            ADDTIME (a.appointment_time, INTERVAL s.duration MINUTE)
    ) AS "Time Slot",
    s.service_name AS "Kind of Service"
FROM
    employee e
        JOIN appointment a ON e.employee_id = a.employee_id
        JOIN service s ON a.service_id = s.service_id
WHERE DATE(a.appointment_date) = CURDATE ()
      GROUP BY e.employee_id
      ORDER BY e.position DESC;