DROP TABLE IF EXISTS  "EmployeeDetails";

create table "EmployeeDetails"( 
id SERIAL NOT NULL,
name varchar(50) NOT NULL,
date_of_birth date NOT NULL,
department varchar(50) NOT NULL,
date_of_joining date NOT nULL,
salary money NOT NULL,
email varchar(255) NOT NULL
);
