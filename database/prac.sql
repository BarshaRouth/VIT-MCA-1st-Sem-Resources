-- For practicingFunctions
--Emp2
create table EMP2(Empid varchar(6),Emp_name varchar(10),Phn_no number(10),Salary number(10));
ALTER TABLE EMP1 ADD CONSTRAINT emp_pk PRIMARY KEY (empid);

--Emp1(for practicinf functions)
INSERT INTO EMP1 VALUES ('E0001', '  Alice', 9876543210, 50000);
INSERT INTO EMP1 VALUES ('E0002', 'Bob  ', 9123456780, 60000);
INSERT INTO EMP1 VALUES ('E0003', '  Charlie ', 9988776655, 55000);
INSERT INTO EMP1 VALUES ('E0004', '  David', 9871234567, 62000);
INSERT INTO EMP1 VALUES ('E0005', 'Eva  ', 9765432109, 58000);

alter table emp1 add (BonusAmt number(5));
update emp1 set Bonusamt=3000 where empid='e0001';
update emp1 set Bonusamt=3000 where empid='E0001';
update emp1 set Bonusamt=60000 where empid='E0002';
update emp1 set Bonusamt=6000 where empid='E0003';
update emp1 set Bonusamt=62000 where empid='E0004';


SQL> update emp1 set Bonusamt=2000 where empid='E0005';

----------------------------------------------------

--lab 2 septtember

--CREATE TABLE
create table EMP(Empid varchar(6),Emp_name varchar(10),Salary number(10),Did varchar(6));
create table Dept(Did varchar(6),Dname varchar(10),Location varchar(10));
create table Project(Pid varchar(6),Pname varchar(10),Budget number(10));
create table Works(Empid varchar(6),Pid varchar(6));


--Primary key
ALTER TABLE EMP ADD CONSTRAINT empp_pk PRIMARY KEY (Empid);
ALTER TABLE Dept ADD CONSTRAINT dept_pk PRIMARY KEY (Did);
ALTER TABLE Project ADD CONSTRAINT Proj_pk PRIMARY KEY (Pid);
ALTER TABLE Works ADD CONSTRAINT works_pk PRIMARY KEY (empid,Pid);

--FORIEGN KEY
ALTER TABLE EMP add constraint fk_emp FOREIGN KEY(Did) references Dept(Did) deferrable initially deferred;
ALTER TABLE WORKS add constraint fk_works FOREIGN KEY(Empid) references Emp(Empid) deferrable initially deferred;
ALTER TABLE WORKS add constraint fk_works FOREIGN KEY(Pid) references Project(Pid) deferrable initially deferred;

--Values
--Emp
INSERT INTO Emp VALUES ('e101', 'Manoj', 1000, 'd101');
INSERT INTO Emp VALUES ('e102', 'Ravi', 1200, 'd102');
INSERT INTO Emp VALUES ('e103', 'Sita', 1500, 'd103');
INSERT INTO Emp VALUES ('e104', 'Priya', 1100, 'd104');
INSERT INTO Emp VALUES ('e105', 'Rahul', 1300, 'd105');

--dept
INSERT INTO Dept VALUES ('d101','HR','Chennai');
INSERT INTO Dept VALUES ('d102','HR','Mumbai');
INSERT INTO Dept VALUES ('d104', 'IT', 'Bangalore');
INSERT INTO Dept VALUES ('d105', 'Marketing', 'Chennai');
INSERT INTO Dept VALUES ('d106', 'Sales', 'Hyderabad');

--project
INSERT INTO Project VALUES ('P101', 'Project1', 4000);
INSERT INTO Project VALUES ('P102', 'Project2', 5000);
INSERT INTO Project VALUES ('P103', 'Project3', 6000);
INSERT INTO Project VALUES ('P104', 'Project4', 3000);
INSERT INTO Project VALUES ('P105', 'Project5', 4500);

--works
INSERT INTO Works VALUES ('e101', 'P101');
INSERT INTO Works VALUES ('e102', 'P102');
INSERT INTO Works VALUES ('e103', 'P102');