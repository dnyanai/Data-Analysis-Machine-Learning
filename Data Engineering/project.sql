-- Project Group 1 : Employee Schema ---

-- Selecting Schema project_employee -- 
USE project_employee;

-- Create table Address_Type --
CREATE TABLE IF NOT EXISTS Address_Type(
	address_id int auto_increment PRIMARY KEY,
    address_type varchar(20) NOT NULL,
    c tinytext
    );

-- Create table Employee_Type --

CREATE TABLE IF NOT EXISTS Employee_Type (
    employee_type_id int auto_increment PRIMARY KEY,
    employee_type varchar(50),
    employee_type_desc tinytext,
    pay_type varchar(10),
    compensation_package decimal(12,2)
);

-- Create table Employee_Role --
CREATE TABLE IF NOT EXISTS Employee_Role (
    employee_role_id int PRIMARY KEY,
    role_name varchar(30) Not null,
    role_desc tinytext
);

-- Create table Organization --
CREATE TABLE IF NOT EXISTS Organization(
	organization_id int auto_increment primary KEY,
    client_org_name varchar(20) NOT NULL,
    client_org_code int(4) NOT NULL,
    superior_org_name varchar(20) ,
    availability_date DATE,
    top_level_name varchar(20) ,
    ISO_country_code varchar(20) 
    );
    
-- Create table Person --    
CREATE TABLE IF NOT EXISTS Person(
	person_id int auto_increment PRIMARY KEY, 
	first_name varchar(20) NOT NULL,
	middle_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	age INT NOT NULL,
	phone_number varchar(15) ,
    email_id varchar(100) NOT NULL,
    address_id int ,
    insurance_id varchar(20) ,
    device_type varchar(20) ,
	FOREIGN KEY (address_id) REFERENCES Address_Type (address_id) 
    );

-- Create table Employee --
CREATE TABLE IF NOT EXISTS Employee (
    employee_id int auto_increment PRIMARY KEY,
	employee_role_id int ,
	employee_type_id int ,
	organization_id int ,
	person_id int not null,
    home_country varchar(50),
    work_country varchar(50),
    gender Char(1), -- make a select list maybe
    DOB date, -- format type 
    martial_status varchar(20), -- letter based
    ethnicity varchar(20),
    FOREIGN KEY(organization_id)
        REFERENCES Organization(organization_id),
    
    FOREIGN KEY(employee_role_id) 
		references Employee_Role(employee_role_id),
    
    FOREIGN KEY(person_id) 
		references Person(person_id),
    
    FOREIGN KEY(employee_type_id)
		references Employee_Type(employee_type_id)
);

-- Load data into tables without stored procedure --
insert into employee_role values(1,'r1','rd1');
insert into address_type values(1,'a1','a1');
insert into person values ('1','a','a','a',10,'1234567891','e1',1,1,'d1');
insert into Employee_Type values('1','e1','ed1','p1',1.1);
insert into organization values(1,'r1','s1',1,'s1','2012-01-01','t1','o1','iso1');
INSERT INTO Employee values (null,1,1,1,1,'h1','w1','m','1997-01-01','s','I');

-- View employeeView with attributes from all tables --
desc organization;
desc address_type;
create view employeeView
as
select address_type.address_type_description, address_type.address_type, 
employee_type.employee_type, employee_type.compensation_package,
employee_role.role_name, employee_role.role_desc , 
organization.Client_org_name, organization.top_level_name,
person.first_name, person.middle_name, person.age,  
employee.home_country, employee.DOB , employee.employee_role_id
from address_type, employee_type, employee_role, organization, person, employee
where address_type.address_id  = Person.address_id and employee_type.employee_type_id = employee.employee_type_id and
employee_role.employee_role_id = employee.employee_role_id and organization.organization_id = employee.organization_id and
person.person_id = employee.person_id;

select * from employeeView;
-- View using Inner Join --

create view employeeView_alternate
as
select 
employee_type.employee_type, employee_type.compensation_package,
employee_role.role_name, employee_role.role_desc , 
organization.Client_org_name,  organization.top_level_name,
person.first_name, person.middle_name, person.age,  
employee.home_country, employee.DOB,employee.employee_role_id
from address_type, employee, employee_type, organization, Person, employee_role
inner join address_type on address_type.address_id  = Person.address_id
inner join employee_type on  employee_type.employee_type_id = employee.employee_type_id
inner join employee_role on employee_role.employee_role_id = employee.employee_role_id
inner join organization on organization.organization_id = employee.organization_id 
inner join person on person.person_id = employee.person_id;

select * from employeeView_alternate;

-- Stored procedures --

-- Stored procedure for inserting data into table Address_Type -- 
DELIMITER $$
CREATE PROCEDURE insert_address_type(
	address_id int ,
    address_type varchar(20) ,
    address_type_description varchar(20) 
    )
BEGIN
    INSERT INTO Address_Type values (address_id, address_type, address_type_description );
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee -- 
DELIMITER $$
 
CREATE PROCEDURE insert_employee(
IN employee_id int   ,
IN employee_role_id int ,
IN employee_type_id int ,
IN organization_id int ,
IN person_id int,
IN home_country varchar(50),
IN work_country varchar(50),
IN gender Char(1), 
IN DOB date, 
IN martial_status varchar(20), 
IN ethnicity varchar(20)
)
BEGIN
    INSERT INTO Employee values (employee_id,
employee_role_id,
employee_type_id,
organization_id,
person_id,
home_country,
work_country,
gender,
DOB,
martial_status,
ethnicity);

END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee_Role -- 
DELIMITER $$
 
CREATE PROCEDURE insert_employee_role(
IN employee_role_id int,
IN role_name varchar(30),
IN role_desc tinytext
)
BEGIN
    INSERT INTO Employee_Role values ( employee_role_id, role_name,role_desc);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Employee_Type -- 
DELIMITER $$
 
CREATE PROCEDURE insert_employee_type(
employee_type_id int,
employee_type varchar(50),
employee_type_desc tinytext,
pay_type varchar(10),
compensation_package decimal(12,2)
)
BEGIN
    INSERT INTO Employee_Type values ( employee_type_id,
employee_type,
employee_type_desc,
pay_type,
compensation_package);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Organisation -- 
DELIMITER $$
 
CREATE PROCEDURE insert_organization(
organization_id int,
role_type_name varchar(20),
supervisory_org_name varchar(20),
supervisory_org_code int,
superior_org_name varchar(20),
availability_date DATE,
top_level_name varchar(20),
org_role_name varchar(20),
ISO_country_code varchar(20)
)
BEGIN
    INSERT INTO organization values (organization_id,
role_type_name,
supervisory_org_name,
supervisory_org_code,
superior_org_name,
availability_date,
top_level_name,
org_role_name,
ISO_country_code
);
END $$ 
DELIMITER ;

-- Stored procedure for inserting data into table Person -- 
DELIMITER $$
 
CREATE PROCEDURE insert_person(
person_id int,
first_name varchar(20),
middle_name varchar(20),
last_name varchar(20),
age INT,
phone_number varchar(15),
email_id varchar(100),
address_id int,
insurance_id varchar(20),
device_type varchar(20)

)
BEGIN
    INSERT INTO Person values (person_id,
first_name,
middle_name,
last_name,
age,
phone_number,
email_id,
address_id,
insurance_id,
device_type);
END $$ 
DELIMITER ;

-- Calling the Stored Procedures --

call insert_employee_role (2,'r1','rd1');
call insert_address_type (2,'a1','a1');
call insert_person ('2','a','a','a',10,'1234567891','e1',2,2,'d1');
call insert_Employee_Type ('2','e1','ed1','p1',1.1);
call insert_organization (2,'r1','s1',2,'s1','2012-01-01','t1','o1','iso1');
call insert_employee(null,2,2,2,2,'h1','w1','m','1997-01-01','s','I');



select * from address_type;
select * from employee;
select * from employee_role;	
select * from employee_type;
select * from organization;
select * from person;

select organization_id from organization where organization_id=null;
delete Client_org_name from organization where organization_id is null;
desc person;
desc employee;
 