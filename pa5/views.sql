-- View
CREATE VIEW employee_schedule_view AS
SELECT e.employee_name AS Employee_Name,
       GROUP_CONCAT(
           DISTINCT s.service_name
    ORDER BY s.service_name
  ) AS service_name,
       CONCAT (
               a.appointment_time,
               '-',
               ADDTIME(a.appointment_time, SEC_TO_TIME(s.duration * 60))
       ) AS Time_Slot,
       s.service_name AS Kind_of_Service
FROM
    employee e
        JOIN appointment a ON e.employee_id = a.employee_id
        JOIN service s ON a.service_id = s.service_id
WHERE a.appointment_date = CURDATE()
GROUP BY e.employee_id, e.position -- , s.service_name, a.appointment_time, s.duration
ORDER BY e.position DESC;

SELECT * FROM employee;
SELECT * FROM appointment;

SELECT ADDTIME(a.appointment_time, SEC_TO_TIME(s.duration * 60))
FROM appointment a
         INNER JOIN service s on a.service_id = s.service_id;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT * FROM employee_schedule_view;