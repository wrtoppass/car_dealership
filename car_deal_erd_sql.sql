CREATE TABLE Salesperson (
  salesperson_id INT PRIMARY KEY,
  name VARCHAR(255),
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE Customer (
  customer_id INT PRIMARY KEY,
  name VARCHAR(255),
  phone VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE Car (
  serial_number INT PRIMARY KEY,
  make VARCHAR(255),
  model VARCHAR(255),
  year INT
);

CREATE TABLE Invoice (
  invoice_id INT PRIMARY KEY,
  date DATE,
  total_amount DECIMAL(10,2),
  salesperson_id INT,
  customer_id INT,
  FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE ServiceTicket (
  service_ticket_id INT PRIMARY KEY,
  date DATE,
  problem_description VARCHAR(255),
  customer_id INT,
  car_serial_number INT,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
  FOREIGN KEY (car_serial_number) REFERENCES Car(serial_number)
);

CREATE TABLE Mechanic (
  mechanic_id INT PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE ServiceRecord (
  service_record_id INT PRIMARY KEY,
  service_ticket_id INT,
  car_serial_number INT,
  mechanic_id INT,
  date DATE,
  FOREIGN KEY (service_ticket_id) REFERENCES ServiceTicket(service_ticket_id),
  FOREIGN KEY (car_serial_number) REFERENCES Car(serial_number),
  FOREIGN KEY (mechanic_id) REFERENCES Mechanic(mechanic_id)
  );
  
-- Testing my tables
 
INSERT INTO Customer (customer_id, name, phone, email)
VALUES (1, 'Fred Wilson', '8325554444', 'fredwilson@fake.com');

INSERT INTO Salesperson (salesperson_id, name, phone, email)
VALUES (1, 'Mary Jenkins', '2814445555', 'maryjenkins@fake.com');

INSERT INTO Car (serial_number, make, model, year)
VALUES (101607, 'Toyota', 'Camry', 2021);

INSERT INTO Invoice (invoice_id, date, total_amount, salesperson_id, customer_id)
VALUES (1, '2022-03-14', 26000, 1, 1);

INSERT INTO ServiceTicket (service_ticket_id, date, problem_description, customer_id, car_serial_number)
VALUES (1, '2022-03-15', 'Dented door', 1, 101607);

INSERT INTO ServiceTicket (service_ticket_id, date, problem_description, customer_id, car_serial_number)
VALUES (2, '2022-03-20', 'Broken mirror', 1, 101607);

INSERT INTO Mechanic (mechanic_id, name)
VALUES (1, 'Roger Moore');

INSERT INTO ServiceRecord (service_record_id, service_ticket_id, car_serial_number, mechanic_id, date)
VALUES (1, 1, 101607, 1, '2022-03-15');

INSERT INTO ServiceRecord (service_record_id, service_ticket_id, car_serial_number, mechanic_id, date)
VALUES (2, 2, 101607, 1, '2022-03-20');



-- Function test

--update customers email

CREATE OR REPLACE FUNCTION cahnge_customer_email( 
	_customer_id INTEGER
	new_email VARCHAR(150)
)
RETURNS VARCHAR(150) AS 
$$
	BEGIN 
		UPDATE customer 
		SET email = new_email
		WHERE customer_id = _customer_id;
		RETURN new_email;
	END;
$$
LANGUAGE plpgsql;

SELECT change_customer_email(1, 'newfredwilson@fake.com');