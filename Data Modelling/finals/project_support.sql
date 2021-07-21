
DELIMITER $$
CREATE PROCEDURE load_data()
BEGIN
	call insert_employee_role (1,'IT','Support Maintanance');
	call insert_address_type (1,'Home','3234 Lacos Street');
	call insert_person ('1','Jack','Taylor','Albert',34,'878756778','taylor1@gmail.com',1,1,'Desktop');
	call insert_Employee_Type ('1','Part-time','Emp Desc','Hourly', 25.5);
	call insert_organization (1,'Developer','PM',1,'DIR1','2012-01-01','Jameson','Manager','3166-2');
	call insert_employee(1,1,1,1,1,'USA','USA','M','1997-01-01','Single','American');
    
	call insert_employee_role (2,'IT','Support Maintanance');
	call insert_address_type (2,'Home','2422 Sentinal Street');
	call insert_person ('2','Liam','B','Tatt',27,'878756778','Liam1@gmail.com',2,1,'Desktop');
	call insert_Employee_Type ('2','Full-time','Emp Desc','Hourly', 25.5);
	call insert_organization (2,'Developer','PM',2,'DIR1','2012-01-01','Jameson','Manager','3166-2');
	call insert_employee(2,2,2,2,2,'USA','USA','M','1999-01-05','Single','American');
	
    call insert_employee_role (3,'Pro Services','Support Maintanance');
	call insert_address_type (3,'Home','686 Wallster Street');
	call insert_person ('3','Kate','Late','A',30,'878256778','Kate@gmail.com',3,1,'Desktop');
	call insert_Employee_Type ('3','Full-time','Emp Desc','Hourly', 30.5);
	call insert_organization (3,'Developer','PM',3,'DIR1','2012-03-01','Jameson','Manager','3166-2');
	call insert_employee(3,3,3,3,3,'USA','USA','F','1999-03-05','Married','American');
    
	call insert_employee_role (4,'DSC','Pre Sale Support');
	call insert_address_type (4,'Home','343 Frank Street');
	call insert_person ('4','Anderson','Bu','Pat',29,'878756778','Anderson1@gmail.com',4,1,'Desktop');
	call insert_Employee_Type ('4','Full-time','Emp Desc','Hourly', 25.5);
	call insert_organization (4,'Developer','PM',4,'DIR1','2012-01-01','Jameson','Manager','3166-2');
	call insert_employee(4,4,4,4,4,'USA','USA','M','1999-01-05','Single','American');
    
	call insert_employee_role (5,'IT','Support Maintanance');
	call insert_address_type (5,'Home','2422 Sentinal Street');
	call insert_person ('5','Liam','B','Tatt',25,'878756735','Liam2@gmail.com',5,1,'Desktop');
	call insert_Employee_Type ('5','Full-time','Emp Desc','Hourly', 25.5);
	call insert_organization (5,'Developer','PM',5,'DIR1','2012-01-01','Jameson','Manager','3166-2');
	call insert_employee(5,5,5,5,5,'USA','USA','M','1999-06-05','Single','American');
    
END $$
DELIMITER ;

call load_data();




select * from employeeview;

select * from employee;
select * from employee_role;
select * from address_type;
select * from person;
select * from  Employee_Type;
select * from organization ;
select * from employee;

truncate address_type;

ALTER TABLE Person
  DROP FOREIGN KEY person_ibfk_1;
  
ALTER TABLE Person 
    ADD CONSTRAINT fk_constraint_addressID
    FOREIGN KEY(address_id)
    REFERENCES Address_Type(address_id);
    
    
	call insert_employee_role (2,'IT','Support Maintanance');
	call insert_address_type (2,'Home','2422 Sentinal Street');
	call insert_person ('2','Liam','B','Tatt',34,'878756778','taylor1@gmail.com',1,1,'Desktop');
	call insert_Employee_Type ('2','Full-time','Emp Desc','Hourly', 25.5);
	call insert_organization (2,'Developer','PM',1,'DIR1','2012-01-01','Jameson','Manager','3166-2');
	call insert_employee(2,2,2,2,2,'USA','USA','M','1999-01-05','Single','American');