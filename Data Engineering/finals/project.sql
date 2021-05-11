-- Project Group 1 : Employee Schema ---

-- Selecting Schema project_employee -- 
USE project_employee;

-- Creating Tables --

-- Create table Address_Type --
CREATE TABLE IF NOT EXISTS Address_Type(
	address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_type VARCHAR(20) NOT NULL,
    address_type_description TINYTEXT
);

-- Create table Employee_Type --

CREATE TABLE IF NOT EXISTS Employee_Type (
    employee_type_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_type VARCHAR(50),
    employee_type_desc TINYTEXT,
    pay_type VARCHAR(10),
    compensation_package decimal(12,2)
);

-- Create table Employee_Role --
CREATE TABLE IF NOT EXISTS Employee_Role (
    employee_role_id INT PRIMARY KEY,
    role_name VARCHAR(30) NOT NULL,
    role_desc TINYTEXT
);

-- Create table Organization --
CREATE TABLE IF NOT EXISTS Organization(
	organization_id INT AUTO_INCREMENT PRIMARY KEY,
    client_org_name VARCHAR(20) NOT NULL,
    client_org_code INT(4) NOT NULL,
    superior_org_name VARCHAR(20) ,
    availability_date DATE,
    top_level_name VARCHAR(20) ,
    ISO_country_code VARCHAR(20) 
    );
    
-- Create table Person --    
CREATE TABLE IF NOT EXISTS Person(
	person_id INT AUTO_INCREMENT PRIMARY KEY, 
	first_name VARCHAR(20) NOT NULL,
	middle_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	age INT NOT NULL,
	phone_number VARCHAR(15) ,
    email_id VARCHAR(100) NOT NULL,
    address_id INT ,
    insurance_id VARCHAR(20) ,
    device_type VARCHAR(20) ,
	FOREIGN KEY (address_id) REFERENCES Address_Type (address_id) 
    );

-- Create table Employee --
CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
	employee_role_id INT ,
	employee_type_id INT ,
	organization_id INT ,
	person_id INT NOT NULL,
    home_country VARCHAR(50),
    work_country VARCHAR(50),
    gender CHAR(1), -- make a select list maybe
    DOB DATE, -- format type 
    martial_status VARCHAR(20), -- letter based
    ethnicity VARCHAR(20),
    FOREIGN KEY(organization_id)
        REFERENCES Organization(organization_id),
    
    FOREIGN KEY(employee_role_id) 
		REFERENCES Employee_Role(employee_role_id),
    
    FOREIGN KEY(person_id) 
		REFERENCES Person(person_id),
    
    FOREIGN KEY(employee_type_id)
		REFERENCES Employee_Type(employee_type_id)
);

-- Stored procedures --

-- Stored procedure for inserting data into table Address_Type -- 
DELIMITER $$
CREATE PROCEDURE insert_address_type(
IN address_id INT ,
IN address_type VARCHAR(20) ,
IN address_type_description VARCHAR(20) 
    )
BEGIN
    INSERT INTO Address_Type VALUES (address_id, address_type, address_type_description);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee -- 
DELIMITER $$
CREATE PROCEDURE insert_employee(
IN employee_id INT   ,
IN employee_role_id INT ,
IN employee_type_id INT ,
IN organization_id INT ,
IN person_id INT,
IN home_country VARCHAR(50),
IN work_country VARCHAR(50),
IN gender CHAR(1), 
IN DOB DATE, 
IN martial_status VARCHAR(20), 
IN ethnicity VARCHAR(20)
)
BEGIN
    INSERT INTO Employee VALUES (employee_id, employee_role_id, employee_type_id, organization_id, person_id, home_country, work_country, gender, DOB, martial_status, ethnicity);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee_Role -- 
DELIMITER $$
CREATE PROCEDURE insert_employee_role(
IN employee_role_id INT,
IN role_name VARCHAR(30),
IN role_desc TINYTEXT
)
BEGIN
    INSERT INTO Employee_Role VALUES (employee_role_id, role_name,role_desc);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee_Type -- 
DELIMITER $$
CREATE PROCEDURE insert_employee_type(
IN employee_type_id INT,
IN employee_type VARCHAR(50),
IN employee_type_desc TINYTEXT,
IN pay_type VARCHAR(10),
IN compensation_package decimal(12,2)
)
BEGIN
    INSERT INTO Employee_Type VALUES (employee_type_id, employee_type, employee_type_desc, pay_type, compensation_package);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Organisation -- 
DELIMITER $$
CREATE PROCEDURE insert_organization(
IN organization_id INT,
IN client_org_name VARCHAR(20),
IN client_org_code INT,
IN client_org_domain VARCHAR(20),
IN availability_date DATE,
IN top_level_name VARCHAR(20),
IN ISO_country_code VARCHAR(20)
)
BEGIN
    INSERT INTO organization VALUES (organization_id, client_org_name, client_org_code, client_org_domain, availability_date, top_level_name, ISO_country_code);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Person -- 
DELIMITER $$
CREATE PROCEDURE insert_person(
IN person_id INT,
IN first_name VARCHAR(20),
IN middle_name VARCHAR(20),
IN last_name VARCHAR(20),
IN age INT,
IN phone_number VARCHAR(15),
IN email_id VARCHAR(100),
IN address_id INT,
IN insurance_id VARCHAR(20),
IN device_type VARCHAR(20)
)
BEGIN
    INSERT INTO Person VALUES (person_id, first_name, middle_name, last_name, age, phone_number, email_id, address_id, insurance_id, device_type);
END $$ 
DELIMITER ;

-- Calling the Stored Procedures --
CALL insert_employee_role (2,'r1','rd1');
CALL insert_address_type (2,'a1','a1');
CALL insert_person ('2','a','a','a',10,'1234567891','e1',2,2,'d1');
CALL insert_Employee_Type ('2','e1','ed1','p1',1.1);
CALL insert_organization (2,'r1','s1',2,'s1','2012-01-01','t1','o1','iso1');
CALL insert_employee(NULL,2,2,2,2,'h1','w1','m','1997-01-01','s','I');

-- View employeeView with attributes from all tables --

-- View using Where-- 
CREATE VIEW employeeView
AS
SELECT address_type.address_type_description, address_type.address_type, 
employee_type.employee_type, employee_type.compensation_package,
employee_role.role_name, employee_role.role_desc , 
organization.Client_org_name, organization.top_level_name,
person.first_name, person.middle_name, person.age,  
employee.home_country, employee.DOB , employee.employee_role_id
FROM address_type, employee_type, employee_role, organization, person, employee
WHERE address_type.address_id  = Person.address_id and employee_type.employee_type_id = employee.employee_type_id and
employee_role.employee_role_id = employee.employee_role_id and organization.organization_id = employee.organization_id and
person.person_id = employee.person_id;

SELECT * FROM employeeView;

-- View using Inner Join --
CREATE VIEW employeeView_alternate
AS
SELECT
employee_type.employee_type, employee_type.compensation_package,
employee_role.role_name, employee_role.role_desc , 
organization.Client_org_name,  organization.top_level_name,
person.first_name, person.middle_name, person.age,  
employee.home_country, employee.DOB,employee.employee_role_id
FROM address_type, employee, employee_type, organization, Person, employee_role
INNER JOIN address_type ON address_type.address_id  = Person.address_id
INNER JOIN employee_type ON  employee_type.employee_type_id = employee.employee_type_id
INNER JOIN employee_role ON employee_role.employee_role_id = employee.employee_role_id
INNER JOIN organization ON organization.organization_id = employee.organization_id 
INNER JOIN person ON person.person_id = employee.person_id;

SELECT * FROM employeeView_alternate;
 