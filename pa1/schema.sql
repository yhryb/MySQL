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
                         payment_date DATE NOT NULL
);

CREATE TABLE customer (
                          customer_id INT AUTO_INCREMENT PRIMARY KEY,
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
                          service_id INT NOT NULL,
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
                                  FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
                                  FOREIGN KEY (service_id) REFERENCES service(service_id)
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
)