--ALWAYS USE COMMIT TO SAVE

--REMOVE CONSTRAINT
ALTER TABLE PROFESSOR DROP CONSTRAINT FK_DEPT;
ALTER TABLE SCHOOL DROP CONSTRAINT fk_Prof_id;
ALTER TABLE DEPARTMENT DROP CONSTRAINT fk_profid;
ALTER TABLE DEPARTMENT DROP CONSTRAINT fk_SCode;
ALTER TABLE CLASS DROP CONSTRAINT fk_Crs_code;
ALTER TABLE CLASS DROP CONSTRAINT fk_Prfid;
ALTER TABLE CLASS DROP CONSTRAINT fk_SemCode;
ALTER TABLE STUDENT DROP CONSTRAINT fk_Depid;
ALTER TABLE STUDENT DROP CONSTRAINT fk_fk_Proid;
ALTER TABLE ENROLL DROP CONSTRAINT fk_ClsCode;
ALTER TABLE ENROLL DROP CONSTRAINT fk_enroll_reg_no;
ALTER TABLE PROGRAMME DROP CONSTRAINT fk_SC; 
ALTER TABLE PROGRAMME DROP CONSTRAINT fk_DepI;

--DROP
DROP TABLE PROGRAMME;
DROP TABLE STUDENT_VISA;
DROP TABLE ENROLL;
DROP TABLE STUDENT;
DROP TABLE SEMESTER;
DROP TABLE CLASS;
DROP TABLE COURSE;
DROP TABLE SCHOOL;
DROP TABLE PROFESSOR;
DROP TABLE DEPARTMENT;

--CREATE TABLE
create table PROFESSOR(Prof_id varchar(5),Prof_name varchar(20),Email varchar(20),Mobile number(10),Speciality varchar(10),Dept_id varchar(5));
create table SCHOOL(SCode varchar(5),Scl_name varchar(20),Prof_id varchar(5),Location varchar(10));
create table DEPARTMENT(Dept_id varchar(5),Dname varchar(20),Scode varchar(5),Prof_id varchar(5));
create table COURSE (Crs_code varchar(5),Crs_name varchar(10),Description varchar(30),Credits number(2),Hours number(2));
CREATE TABLE CLASS (Cls_code VARCHAR(5),Slot VARCHAR(5),Stime TIMESTAMP(0),Etime TIMESTAMP(0),Crs_code VARCHAR(5), Prof_id VARCHAR(5),Room_no VARCHAR(5), Sem_code VARCHAR(5), Day_of_week VARCHAR(10));
--In Oracle, the TIMESTAMP data type allows you to store date and time information with fractional seconds. The (0) in TIMESTAMP(0) specifies that there should be zero fractional seconds, meaning it will store the date and time without any fractional part of a second.
Create table SEMESTER(sem_code varchar(5),term varchar(6),Year varchar(4),Sdate date,Edate date);
Create table STUDENT(Reg_no varchar(5),Sname varchar(10),Address varchar(20),DoB date,Email varchar(20),Mobile varchar(10),Dept_id varchar(5),Prof_id varchar(5));
Create table ENROLL(Cls_code varchar(5),Reg_no varchar(5),Enroll_time timestamp(0), Grade CHAR(1) CHECK (Grade IN ('S', 'A', 'B', 'C', 'D')));
Create table STUDENT_VISA(Reg_no varchar(5),Visa_status Varchar(20));
Create table PROGRAMME(Prog_code varchar(5), Prog_name varchar(10), Prog_preamble varchar(50), Scode varchar(5), Dept_id varchar(5));



--PRIMARY KEYS
ALTER TABLE PROFESSOR ADD CONSTRAINT pk_professor PRIMARY KEY (Prof_id);
ALTER TABLE SCHOOL ADD CONSTRAINT pk_school PRIMARY KEY (SCode);
ALTER TABLE DEPARTMENT ADD CONSTRAINT pk_department PRIMARY KEY (Dept_id);
ALTER TABLE COURSE ADD CONSTRAINT pk_course PRIMARY KEY (Crs_code);
ALTER TABLE CLASS ADD CONSTRAINT pk_class PRIMARY KEY (Cls_code);
ALTER TABLE SEMESTER ADD CONSTRAINT pk_semester PRIMARY KEY (Sem_code);
ALTER TABLE STUDENT ADD CONSTRAINT pk_student PRIMARY KEY (Reg_no);
ALTER TABLE ENROLL ADD CONSTRAINT pk_enroll PRIMARY KEY (Cls_code, Reg_no);
ALTER TABLE STUDENT_VISA ADD CONSTRAINT pk_student_visa PRIMARY KEY (Reg_no);
ALTER TABLE PROGRAMME ADD CONSTRAINT pk_programme PRIMARY KEY (Prog_code);

--Add FK
alter table PROFESSOR add constraint fk_Dept foreign key(Dept_id) references DEPARTMENT(Dept_id) deferrable initially deferred;
alter table SCHOOL add constraint fk_Prof_id foreign key(Prof_id) references PROFESSOR(Prof_id) deferrable initially deferred;
alter table DEPARTMENT add constraint fk_Profid foreign key(Prof_id) references PROFESSOR(Prof_id) deferrable initially deferred;
alter table DEPARTMENT add constraint fk_SCode foreign key(SCode) references SCHOOL(SCode) deferrable initially deferred;
alter table CLASS add constraint fk_Crs_code foreign key(Crs_code) references COURSE(Crs_code) deferrable initially deferred;
alter table CLASS add constraint fk_Prfid foreign key(Prof_id) references PROFESSOR (Prof_id) deferrable initially deferred;
alter table CLASS add constraint fk_SemCode foreign key(Sem_code) references Semester(Sem_code) deferrable initially deferred;
alter table STUDENT add constraint fk_Depid foreign key(Dept_id) references DEPARTMENT (Dept_id) deferrable initially deferred;
alter table STUDENT add constraint fk_Proid foreign key(Prof_id) references PROFESSOR (Prof_id) deferrable initially deferred;
alter table Enroll add constraint fk_ClsCode foreign key(Cls_code) references CLASS (Cls_code) deferrable initially deferred;
alter table Enroll add constraint fk_RegNo foreign key(Reg_no) references STUDENT (Reg_no) deferrable initially deferred;
alter table PROGRAMME add constraint fk_SC foreign key(Scode) references SCHOOL (SCode) deferrable initially deferred;
alter table PROGRAMME add constraint fk_DepI foreign key(Dept_id) references DEPARTMENT (Dept_id) deferrable initially deferred;
--ADD CONTRAiNT
alter table PROFESSOR add constraint uk_email unique(Email);
alter table PROFESSOR add constraint uk_Mobile unique(Mobile);
alter table PROFESSOR add constraint chk_Len CHECK(LENGTH(Prof_id)=5);
alter table PROFESSOR add constraint chk_Len_Mob CHECK(LENGTH(Mobile)=10);
alter table PROFESSOR add constraint chk_Email_atTheRate CHECK(Email like '%@%');

SELECT constraint_name, constraint_type FROM user_constraints WHERE table_name = 'PROFESSOR';


--SEMESTER
alter table SEMESTER add constraint chk_SemesCod CHECK(sem_code Like 'Win%' or sem_code like 'Fall%' );
alter table SEMESTER add constraint chk_Term CHECK(Term IN ('Winter', 'Fall') );

SELECT constraint_name, constraint_type FROM user_constraints WHERE table_name = 'SEMESTER';

--STUDENT
alter table STUDENT add constraint uk_stu_email unique(Email);
alter table STUDENT add constraint uk_stu_Mobile unique(Mobile);
alter table STUDENT add constraint chk_Len_StuMob CHECK(LENGTH(Mobile)=10);
alter table STUDENT add constraint chk_stuEmail_atTheRate CHECK(Email like '%@%');

--ENROLL
alter table Enroll add constraint chk_value CHECK(Grade IN ('S', 'A','B','C','D'));


--insert

--PROFESSOR
insert into PROFESSOR values('P0001','Barsha','barsha@gmail.com',9647008681,'Maths','D0001');
INSERT INTO PROFESSOR VALUES ('P0002', 'Anil', 'anil@gmail.com', 9876543210, 'Science', 'D0002');
INSERT INTO PROFESSOR VALUES ('P0003', 'Sita', 'sita@gmail.com', 8765432109, 'Arts', 'D0003');
INSERT INTO PROFESSOR VALUES ('P0004', 'Ravi', 'ravi@gmail.com', 7654321098, 'Commerce', 'D0004');
INSERT INTO PROFESSOR VALUES ('P0005', 'Geeta', 'geeta@gmail.com', 6543210987, 'Medical', 'D0005');
INSERT INTO PROFESSOR VALUES ('P0006', 'Mohan', 'mohan@gmail.com', 5432109876, 'Maths', 'D0001');
INSERT INTO PROFESSOR VALUES ('P0007', 'Lata', 'lata@gmail.com', 4321098765, 'Science', 'D0002');
INSERT INTO PROFESSOR VALUES ('P0008', 'Raj', 'raj@gmail.com', 3210987654, 'Arts', 'D0003');
INSERT INTO PROFESSOR VALUES ('P0009', 'Meena', 'meena@gmail.com', 2109876543, 'Commerce', 'D0004');
INSERT INTO PROFESSOR VALUES ('P0010', 'Vijay', 'vijay@gmail.com', 1098765432, 'Medical', 'D0005');
INSERT INTO PROFESSOR VALUES ('P0011', 'O''Brien', 'brien@gmail.com', 1098766432, 'Anotomy', 'D0006');


--SCHOOL
insert into SCHOOL values('S0001','Maths School','P0001', 'Building M');
INSERT INTO SCHOOL VALUES('S0002', 'Science School', 'P0002', 'Building S');
INSERT INTO SCHOOL VALUES('S0003', 'Arts School', 'P0003', 'Building A');
INSERT INTO SCHOOL VALUES('S0004', 'Commerce School', 'P0004', 'Building C');
INSERT INTO SCHOOL VALUES('S0005', 'Medical School', 'P0005', 'Building M');

--DEPARTMENT
insert into DEPARTMENT values('D0001','Maths','S0001','P0006');
INSERT INTO DEPARTMENT VALUES('D0002', 'Science Dept', 'S0002', 'P0007');
INSERT INTO DEPARTMENT VALUES('D0003', 'Arts Dept', 'S0003', 'P0008');
INSERT INTO DEPARTMENT VALUES('D0004', 'Commerce Dept', 'S0004', 'P0009');
INSERT INTO DEPARTMENT VALUES('D0005', 'Medical Dept', 'S0005', 'P0010');

INSERT INTO DEPARTMENT VALUES('D0006', 'English Dept', 'S0003', 'P0011');

-- UPDATE STUDENT
-- SET Dept_id = 'D0006'
-- WHERE Reg_no = '2BCA2';


--COURSE
insert into COURSE values('C0001','MCA','Computer Applications Study',30,90);
INSERT INTO COURSE VALUES ('C0002', 'MBA', 'Business Administration', 40, 85);
INSERT INTO COURSE VALUES ('C0003', 'B.Tech', 'Engineering', 50, 80);
INSERT INTO COURSE VALUES ('C0004', 'B.Sc', 'Science', 35, 75);
INSERT INTO COURSE VALUES ('C0005', 'B.Com', 'Commerce', 45, 88);
INSERT INTO COURSE VALUES ('C0006', 'M.Sc', 'Advanced Science', 25, 92);
INSERT INTO COURSE VALUES ('C0007', 'Database', 'database here', 11, 12);
INSERT INTO COURSE VALUES ('C0008', 'Operating', 'OS HERE', 20, 82);

--CLASS
INSERT INTO CLASS VALUES('CL001', 'MOR', TO_TIMESTAMP('2021-02-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-02-11 09:00:00', 'YYYY-MM-DD HH24:MI:SS'),'C0001', 'P0001', 'A114', 'Win01', 'Monday');
INSERT INTO CLASS VALUES ('CL002', 'AFT', TO_TIMESTAMP('2021-03-15 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-03-16 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0002', 'P0002', 'B201', 'Win02', 'Tuesday');
INSERT INTO CLASS VALUES ('CL003', 'EVE', TO_TIMESTAMP('2021-04-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-04-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0003', 'P0003', 'C301', 'Win01', 'Wednesday');
INSERT INTO CLASS VALUES ('CL004', 'MOR', TO_TIMESTAMP('2021-05-25 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-26 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0004', 'P0004', 'D401', 'Fall1', 'Thursday');
INSERT INTO CLASS VALUES ('CL005', 'AFT', TO_TIMESTAMP('2021-06-30 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0005', 'P0005', 'E501', 'Fall1', 'Friday');
INSERT INTO CLASS VALUES ('CL006', 'EVE', TO_TIMESTAMP('2021-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0007', 'P0006', 'F609', 'Fall2', 'Tuesday');
INSERT INTO CLASS VALUES ('CL007', 'AFT', TO_TIMESTAMP('2021-06-30 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-07-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0008', 'P0005', 'E502', 'Fall2', 'Saturday');
INSERT INTO CLASS VALUES ('CL008', 'EVE', TO_TIMESTAMP('2017-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2018-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0007', 'P0006', 'F609', 'Win01', 'Tuesday');
INSERT INTO CLASS VALUES ('CL009', 'EVE', TO_TIMESTAMP('2017-07-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2018-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C0007', 'P0011', 'F609', 'Win01', 'Tuesday');



--SEMESTER
INSERT INTO SEMESTER VALUES ('Win01', 'Winter', '2016', TO_DATE('01-NOV-2016', 'DD-MON-YYYY'), TO_DATE('15-APR-2017', 'DD-MON-YYYY'));
INSERT INTO SEMESTER VALUES ('Fall1', 'Fall', '2016', TO_DATE('01-MAR-2016', 'DD-MON-YYYY'), TO_DATE('15-NOV-2016', 'DD-MON-YYYY'));
INSERT INTO SEMESTER VALUES ('Win02', 'Winter', '2017', TO_DATE('01-NOV-2017', 'DD-MON-YYYY'), TO_DATE('15-APR-2018', 'DD-MON-YYYY'));
INSERT INTO SEMESTER VALUES ('Fall2', 'Fall', '2017', TO_DATE('01-MAR-2017', 'DD-MON-YYYY'), TO_DATE('15-NOV-2017', 'DD-MON-YYYY'));
--STUDENT
INSERT INTO Student values('2MCA1','Barshaa','Asansol',TO_DATE('15-DEC-2002', 'DD-MON-YYYY'),'barsha7@gmail.com',9749806802,'D0001','P0001');
INSERT INTO Student VALUES ('2MBA1', 'Rahul', 'Mumbai', TO_DATE('20-JAN-2001', 'DD-MON-YYYY'), 'rahul123@gmail.com', 9876543210, 'D0003', 'P0003');
INSERT INTO Student VALUES ('2BTH1', 'Sneha', 'Delhi', TO_DATE('05-MAR-2000', 'DD-MON-YYYY'), 'sneha456@gmail.com', 9123456780, 'D0002', 'P0002');
INSERT INTO Student VALUES ('2BSC1', 'Amit', 'Kolkata', TO_DATE('10-JUL-2002', 'DD-MON-YYYY'), 'amit789@gmail.com', 9988776655, 'D0005', 'P0005');
INSERT INTO Student VALUES ('2BCM1', 'Priya', 'Chennai', TO_DATE('25-SEP-2001', 'DD-MON-YYYY'), 'priya101@gmail.com', 9871234567, 'D0004', 'P0004');
INSERT INTO Student VALUES ('2MSC1', 'Vikram', 'Bangalore', TO_DATE('15-NOV-2000', 'DD-MON-YYYY'), 'vikram202@gmail.com', 9765432109, 'D0001', 'P0007');
INSERT INTO Student VALUES ('2BBA1', 'Aadi', 'Katpadi', TO_DATE('15-NOV-2000', 'DD-MON-YYYY'), 'aadi202@gmail.com', 9765432009, 'D0002', 'P0006');
INSERT INTO Student VALUES ('2BCA1', 'Ayul', 'Katpadi', TO_DATE('15-NOV-2019', 'DD-MON-YYYY'), 'ayu202@gmail.com', 9765482009, 'D0003','P0006');
INSERT INTO Student VALUES ('2BCA2', 'Ayusla', 'Jammu', TO_DATE('15-NOV-2017', 'DD-MON-YYYY'), 'ayushla2@gmail.com', 9765772009, 'D0006','P0011');


--ENROLL
INSERT INTO enroll values('CL001','2MCA1',TO_TIMESTAMP('2024-02-11 09:00:00', 'YYYY-MM-DD HH24:MI:SS'),'A');
INSERT INTO enroll VALUES ('CL002', '2MBA1', TO_TIMESTAMP('2024-03-16 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'B');
INSERT INTO enroll VALUES ('CL003', '2BTH1', TO_TIMESTAMP('2024-04-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'A');
INSERT INTO enroll VALUES ('CL004', '2BSC1', TO_TIMESTAMP('2024-05-26 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C');
INSERT INTO enroll VALUES ('CL005', '2BCM1', TO_TIMESTAMP('2024-07-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'B');
INSERT INTO enroll VALUES ('CL006', '2MSC1', TO_TIMESTAMP('2017-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'A');
INSERT INTO enroll VALUES ('CL007', '2MSC1', TO_TIMESTAMP('2017-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'A');
INSERT INTO enroll VALUES ('CL006', '2BSC1', TO_TIMESTAMP('2017-11-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'A');
INSERT INTO enroll VALUES ('CL008', '2MSC1', TO_TIMESTAMP('2017-11-17 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'B');
INSERT INTO enroll VALUES ('CL009', '2BCA2', TO_TIMESTAMP('2017-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'B');
INSERT INTO enroll VALUES ('CL007', '2BCA2', TO_TIMESTAMP('2017-07-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'S');


-- bcom-->BCM

--STUDENT_VISA
INSERT INTO STUDENT_VISA values('2MCA1','APPLIED');

INSERT INTO STUDENT_VISA VALUES ('2MBA1', 'APPROVED');
INSERT INTO STUDENT_VISA VALUES ('2BTH1', 'PENDING');
INSERT INTO STUDENT_VISA VALUES ('2BSC1', 'REJECTED');
INSERT INTO STUDENT_VISA VALUES ('2BCM1', 'APPLIED');
INSERT INTO STUDENT_VISA VALUES ('2MSC1', 'APPROVED');

--PROGRAMME

INSERT INTO PROGRAMME values('PROG1','MCA','comprehensive understanding of computer science','S0001','D0001');

INSERT INTO PROGRAMME VALUES ('PROG2', 'MBA', 'in-depth knowledge of business administration', 'S0003', 'D0003');
INSERT INTO PROGRAMME VALUES ('PROG3', 'B.Tech', 'extensive training in engineering principles', 'S0002', 'D0002');
INSERT INTO PROGRAMME VALUES ('PROG4', 'B.Sc', 'broad understanding of scientific concepts', 'S0002', 'D0002');
INSERT INTO PROGRAMME VALUES ('PROG5', 'B.Com', 'comprehensive study of commerce and trade', 'S0004', 'D0004');
INSERT INTO PROGRAMME VALUES ('PROG6', 'M.Sc', 'advanced exploration of scientific disciplines', 'S0002', 'D0002');


----------------------------------------------------------
--------------------------
--to fit properly on screen
-- set linesize 180;

--display
Select * from PROFESSOR;
Select * from SCHOOL;
Select * from DEPARTMENT;
Select * from COURSE;
SELECT Cls_code, Slot, TO_CHAR(Stime, 'HH24:MI') AS Start_Time, TO_CHAR(Etime, 'HH24:MI') AS End_Time, Crs_code, Prof_id, Room_no, Sem_code, Day_of_week FROM CLASS;
Select * from SEMESTER;
Select * from STUDENT;
SELECT Cls_code, Reg_no, TO_CHAR(Enroll_time, 'HH24:MI') AS Enroll_Time, Grade FROM ENROLL;
Select * from STUDENT_VISA;
Select * from PROGRAMME;


----------------------------------------------------------------------
-- Formating column



-- Q4 i)
SELECT UPPER(Sname) FROM STUDENT;
SELECT LOWER(Sname) FROM STUDENT;
SELECT INITCAP(Visa_status) FROM STUDENT_VISA;
SELECT LENGTH(Dname) FROM DEPARTMENT;
SELECT LPAD(Visa_status,12,'*') FROM STUDENT_VISA;
SELECT RPAD(Visa_status,12,'*') FROM STUDENT_VISA;
SELECT TRIM(emp_name) FROM Emp1;
SELECT RTRIM(emp_name,' ') FROM Emp1;
SELECT LTRIM(emp_name, ' ') FROM Emp1;

--Q4 .ii)
select Empid,emp_name,nvl(BonusAmt,0) as BonusAmt from emp1;
select Empid,emp_name,salary,bonusamt,nullif(salary,Bonusamt) as TotalAmt from emp1;  --not returning null when not equal

--Q4 .iii)
select sname from student where extract(month from DOB)=12;

--Q4 .iv)
select sname from student where DOB = TO_DATE('20-JAN-2001', 'DD-MON-YYYY');

--Q4 .v)
select TO_CHAR('Day , Month dd,yyyy') from student where sname='Barshaa';

--Q4 .vi)
SELECT 
    TO_CHAR(Stime, 'HH24:MI') AS Start_Time,
    TO_CHAR(Etime, 'HH24:MI') AS End_Time
FROM CLASS
WHERE Slot = 'MOR'; 

--Q4 .vii)
SELECT 
    TO_CHAR(Sdate, 'Day') AS Start_Day,
    TO_CHAR(Edate, 'Day') AS End_Day
FROM SEMESTER
WHERE Term = 'Winter' 
  AND Year = '2017';


--Q4 .viii)
SELECT ROUND((Edate - Sdate) / 7) AS Duration_Weeks FROM SEMESTER WHERE Term = 'Winter' AND Year = '2017';

--Q4 .ix)
SELECT sname, TO_CHAR(DOB, 'DD/MM/YY') AS NewDob FROM student;

--Q4 .x)
SELECT CEIL(AVG(Credits)) FROM COURSE;
SELECT FLOOR(AVG(Credits)) FROM COURSE;
SELECT TRUNC(AVG(Credits), 1) FROM COURSE;
SELECT MIN(Credits) FROM COURSE;
SELECT MAX(Credits) FROM COURSE;
SELECT AVG(Credits) FROM COURSE;
SELECT COUNT(*) FROM ENROLL;

-- Q5.i)
SELECT sname, Email, Address FROM Student WHERE Address = 'Katpadi' AND sname LIKE '___l%';
-- ii)
SELECT sname, Email, Address FROM Student WHERE Address != 'Tamil Nadu';
-- iii)
SELECT STUDENT.SNAME, STUDENT.EMAIL,STUDENT.ADDRESS FROM STUDENT INNER JOIN STUDENT_VISA ON STUDENT.REG_NO = STUDENT_VISA.REG_NO;
--iv)
SELECT PROFESSOR.PROF_NAME, PROFESSOR.SPECIALITY FROM PROFESSOR INNER JOIN SCHOOL ON SCHOOL.SCL_NAME = 'Medical School' AND SCHOOL.PROF_ID = PROFESSOR.PROF_ID;
--v)
SELECT SCHOOL.SCL_NAME, PROFESSOR.PROF_NAME FROM PROFESSOR INNER JOIN SCHOOL ON SCHOOL.PROF_ID = PROFESSOR.PROF_ID;
--vi)
SELECT CRS_CODE,CRS_NAME, DESCRIPTION FROM COURSE ORDER BY CRS_CODE;
--vii)
UPDATE STUDENT SET MOBILE='&MOBILE' WHERE REG_NO='&REG_NO';
--viii)
SAVEPOINT BEFORE_del;
DELETE FROM ENROLL WHERE REG_NO='&REG_NO';
ROLLBACK TO BEFORE_del;
--ix)
CREATE TABLE COURSE_DUPLICATE AS SELECT * FROM COURSE;
SELECT * FROM COURSE_DUPLICATE;

--x)

CREATE VIEW STUDENT_COURSE_VIEW AS
SELECT STUDENT.REG_NO, STUDENT.SNAME, COURSE.CRS_NAME, PROFESSOR.PROF_NAME FROM STUDENT INNER JOIN ENROLL ON ENROLL.REG_NO = STUDENT.REG_NO INNER JOIN CLASS ON ENROLL.CLS_CODE = CLASS.CLS_CODE INNER JOIN COURSE ON COURSE.CRS_CODE = CLASS.CRS_CODE
INNER JOIN PROFESSOR ON PROFESSOR.PROF_ID = CLASS.PROF_ID;

SELECT * FROM STUDENT_COURSE_VIEW;

--xi)
SELECT ROOM_NO, SLOT, STIME, ETIME, EXTRACT (HOUR FROM ETIME - STIME) AS "DURATION" FROM CLASS WHERE DAY_OF_WEEK = 'Wednesday' ORDER BY ROOM_NO DESC;

--xii)
SELECT STUDENT.SNAME, COURSE.CRS_NAME, ENROLL.GRADE FROM STUDENT INNER JOIN ENROLL ON ENROLL.REG_NO = STUDENT.REG_NO INNER JOIN CLASS ON CLASS.CLS_CODE = ENROLL.CLS_CODE INNER JOIN COURSE ON COURSE.CRS_CODE = CLASS.CRS_CODE INNER JOIN SEMESTER ON SEMESTER.SEM_CODE = CLASS.SEM_CODE AND SEMESTER.TERM = 'Fall' AND SEMESTER.YEAR = 2017;

--xiii)
SELECT STUDENT.SNAME FROM STUDENT INNER JOIN ENROLL
ON ENROLL.REG_NO = STUDENT.REG_NO INNER JOIN CLASS
ON CLASS.CLS_CODE = ENROLL.CLS_CODE
INNER JOIN COURSE
ON CLASS.CRS_CODE = COURSE.CRS_CODE
AND COURSE.CRS_CODE IN ('C0007',
'C0008')
INNER JOIN SEMESTER
ON SEMESTER.SEM_CODE = CLASS.SEM_CODE
AND SEMESTER.TERM = 'Fall'
AND SEMESTER.YEAR = 2017
GROUP BY
STUDENT.SNAME
HAVING
COUNT(DISTINCT COURSE.CRS_CODE) = 2;

--xiv)

SELECT STUDENT.SNAME, COURSE.CRS_CODE FROM STUDENT 
INNER JOIN ENROLL ON ENROLL.REG_NO = STUDENT.REG_NO 
INNER JOIN CLASS ON ENROLL.CLS_CODE = CLASS.CLS_CODE
INNER JOIN COURSE ON COURSE.CRS_CODE = CLASS.CRS_CODE AND COURSE.CRS_CODE IN ('C0007','C0008') 
INNER JOIN SEMESTER ON SEMESTER.SEM_CODE = CLASS.SEM_CODE AND SEMESTER.YEAR = 2017
AND SEMESTER.TERM = 'Winter' 
MINUS
SELECT STUDENT.SNAME, COURSE.CRS_CODE FROM STUDENT 
INNER JOIN ENROLL ON ENROLL.REG_NO = STUDENT.REG_NO
INNER JOIN CLASS ON ENROLL.CLS_CODE = CLASS.CLS_CODE
INNER JOIN COURSE ON COURSE.CRS_CODE = CLASS.CRS_CODE
AND COURSE.CRS_CODE = 'C0008' INNER JOIN SEMESTER ON SEMESTER.SEM_CODE = CLASS.SEM_CODE AND SEMESTER.YEAR = 2018
AND SEMESTER.TERM = 'Win01';


-- xv)
SELECT STUDENT.REG_NO, STUDENT.SNAME FROM STUDENT, ENROLL,CLASS, COURSE WHERE
STUDENT.REG_NO = ENROLL.REG_NO AND CLASS.CLS_CODE = ENROLL.CLS_CODE AND CLASS.CRS_CODE = COURSE.CRS_CODE GROUP BY STUDENT.REG_NO, STUDENT.SNAME HAVING SUM(COURSE.CREDITS) = 26;

-- xvi)
SELECT COURSE.CRS_NAME, COUNT(ENROLL.REG_NO), SLOT FROM COURSE, ENROLL, CLASS WHERE ENROLL.CLS_CODE = CLASS.CLS_CODE AND CLASS.CRS_CODE = COURSE.CRS_CODE GROUP BY ENROLL.REG_NO, COURSE.CRS_NAME, SLOT;

-- xvii)
SELECT STUDENT.SNAME FROM STUDENT, PROFESSOR, CLASS, ENROLL WHERE ENROLL.CLS_CODE = CLASS.CLS_CODE AND ENROLL.REG_NO = STUDENT.REG_NO AND CLASS.PROF_ID = PROFESSOR.PROF_ID AND PROFESSOR.PROF_NAME = 'O''Brien';

-- xviii)
SELECT STUDENT.REG_NO 
    FROM STUDENT, ENROLL, CLASS, COURSE 
    WHERE ENROLL.REG_NO = STUDENT.REG_NO 
    AND ENROLL.CLS_CODE = CLASS.CLS_CODE 
    AND CLASS.CRS_CODE = COURSE.CRS_CODE
    AND TO_CHAR(ENROLL.ENROLL_TIME, 'DD-MM-YYYY') = '17-11-2017'
    AND COURSE.CRS_NAME = 'Database';

-- xix)Write a query to display the grade of a student given his/her registration number and the 
-- course name for Fall semester 17–18.
--2MSC1
SELECT ENROLL.REG_NO 
    FROM ENROLL, CLASS, SEMESTER 
    WHERE ENROLL.CLS_CODE = CLASS.CLS_CODE 
    AND CLASS.SEM_CODE = SEMESTER.SEM_CODE
    AND SEMESTER.SEM_CODE LIKE 'Fall%'
    AND SEMESTER.YEAR = '2017'
    AND ENROLL.REG_NO LIKE '&REG_NO';
-- SELECT ENROLL.GRADE FROM ENROLL,CLASS WHERE ENROLL.CLS_CODE = CLASS.CLS_CODE
-- AND CLASS.SEM_CODE = 'FALL1' AND ENROLL.REG_NO = '2BSC1' AND CLASS.CRS_CODE = 'C0004';

-- xx)List the name of departments and the name professors who is in charge of the department


------------------
--Display name, email address and address for those
-- students who are not from Tamil Nadu. 
select sname,email,address from STUDENT where address != 'Tamil nadu'; 

--List course code, course name and course 
--description in alphabetic order of course code

select crs_code, crs_name ,description from course 
order by crs_code; 

