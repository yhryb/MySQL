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

INSERT INTO employee (employee_id, employee_name, phone, email, position, salary, service_id) VALUES
                                                                                                  (10, 'Amy Johnson', '123-456-7890', 'amy.johnson@example.com', 'Hair Stylist', 2500.00, 1),
                                                                                                  (20, 'Mark Davis', '987-654-3210', 'mark.davis@example.com', 'Nail Technician', 1800.00, 2),
                                                                                                  (30, 'Lisa Smith', '555-123-4567', 'lisa.smith@example.com', 'Esthetician', 2000.00, 3),
                                                                                                  (40, 'David Wilson', '111-222-3333', 'david.wilson@example.com', 'Massage Therapist', 3000.00, 4),
                                                                                                  (50, 'Karen Brown', '444-555-6666', 'karen.brown@example.com', 'Receptionist', 1500.00, 5);

SELECT position, AVG(salary) AS average_salary
FROM employee
GROUP BY position
HAVING average_salary > 2000;

-- calculates the total payment amount of customers
-- c. is a shorthand for customer table
-- a. is a shorthand for appointment table
-- p. is a shorthand for payment table
SELECT c.customer_name, SUM(p.amount) AS total_payment_amount
FROM customer c
         JOIN appointment a ON c.customer_id = a.customer_id
         JOIN payment p ON a.appointment_id = p.appointment_id
GROUP BY c.customer_name
ORDER BY total_payment_amount DESC
    LIMIT 5; -- returns the top 5 customers with the highest total payment amounts

-- shows customers who made payments with Credit Card
SELECT c.customer_name, p.payment_id, p.amount, p.payment_method
FROM customer c
         JOIN appointment a ON c.customer_id = a.customer_id
         JOIN payment p ON a.appointment_id = p.appointment_id
WHERE p.payment_method = 'Credit Card';

-- additional query (payment method count)
SELECT payment_method, COUNT(payment_id) AS total_payments, SUM(amount) AS total_amount
FROM payment
GROUP BY payment_method