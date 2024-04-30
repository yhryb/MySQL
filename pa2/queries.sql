-- query 4 amount of appointments each employee has for a certain service
SELECT e.employee_name, s.service_name, COUNT(a.appointment_id) AS appointment_count
FROM Employee_Service es
         JOIN employee e ON es.employee_id = e.employee_id
         JOIN service s ON es.service_id = s.service_id
         JOIN appointment a ON e.employee_id = a.employee_id AND s.service_id = a.service_id
WHERE DATE(a.appointment_date) = DATE_SUB(DATE('2011-09-17 00:00:00'), INTERVAL 1 WEEK)
GROUP BY e.employee_id, s.service_id
ORDER BY appointment_count DESC;

-- query 5 shows customer preference.
SELECT c.customer_name, s.service_name, COUNT(appointment.appointment_id) AS appointment_count
FROM appointment
         JOIN customer c ON appointment.customer_id = c.customer_id
         JOIN service s ON appointment.service_id = s.service_id
GROUP BY c.customer_id, s.service_id
ORDER BY appointment_count DESC