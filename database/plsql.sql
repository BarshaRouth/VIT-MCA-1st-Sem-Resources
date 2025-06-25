create table CUSTOMER(c_id varchar(5),c_name varchar(20),Salary number(8),Mobile number(10));

ALTER TABLE Customer ADD CONSTRAINT pk_customer PRIMARY KEY (c_id);

insert into customer values('1','Akash',1000,9768990022);
insert into customer values('2','kashi',8000,9768990082);
insert into customer values('3','kuhi',9000,9968990082);
---------------------
set serveroutput on;

DECLARE
    id customer.c_id%type:=1;
    name customer.c_name%type;
    -- c_addr customer.c_Address%type;
    sal customer.Salary%type;
BEGIN
    select c_name,salary INTO name,sal FROM customer WHERE c_id=id;
    dbms_output.put_line('Customer '||name||' earns '||sal);
End;
/

-------------------------------------------------------------------------------

 Declare
  x number(2):=3;
  BEGIN
     If(x between 2 and 7) then
             dbms_output.put_line('True');
     ELSE
             dbms_output.put_line('False');
     END IF;
  END;
 /
-------------------
DECLARE
  id customer.c_id%TYPE := 1;
  sal customer.salary%TYPE;
BEGIN
  -- Select the salary into the variable 'sal' from the 'customer' table where c_id matches 'id'
  SELECT salary INTO sal FROM customer WHERE c_id = id;

  -- Conditional check to update salary if it is less than or equal to 2000
  IF sal <= 2000 THEN
    UPDATE customer
    SET salary = salary + 10000
    WHERE c_id = id;
    
    dbms_output.put_line('Salary updated');
  END IF;
END;
/
----------------------
DECLARE 
    x number(2):=40;
BEGIN
    IF(x=10)then
    dbms_output.put_line('number is 10');
    ELSif(x=40) then
    dbms_output.put_line('number is 40');
    ELSE
    dbms_output.put_line('not number');
    END if;
    dbms_output.put_line('Exact value='||x);
END;
/

-------------------------------------------

DECLARE
    grade char(1) := 'A';
BEGIN
    case grade
        when 'A' then
        dbms_output.put_line('EXceleent');
        when 'B' then
        dbms_output.put_line('Good');
        when 'C' then
        dbms_output.put_line('not nice');
        ELSE
        dbms_output.put_line('EXceleent');
        End case;
END;
/

--------------------------------

DECLARE
    x number(2) := 20;
BEGIN
    LOOP
    dbms_output.put_line(x);
    x:=x+10;
    exit when x>60;
    dbms_output.put_line(x);
    END LOOP;
END;
/



-------------------------------------- CYCLESHEET--------------------------------
-- Q1.1.Write a PL/SQL block to get the student register number and print the student
-- details such as sname, address, dob, email and mobile number.
DECLARE
    stu_regNo student.reg_no%type:='&reg_no';
    stu_name student.Sname%type;
    stu_addr student.Address%type;
    stu_dob student.DOB%type;
    stu_email student.email%type;
    stu_mob student.mobile%type;
BEGIN
    select Sname,Address,DOB,email,mobile INTO stu_name,stu_addr,stu_dob,stu_email,stu_mob FROM Student WHERE reg_no=stu_regNo;
    dbms_output.put_line('Student name is: '||stu_name||', He lives in '||stu_addr||' , He was born on '||stu_dob||', His email IS '||stu_email||' ,His phone number:'||stu_mob);
End;
/

-- Q2.Write a PL/SQL block the get the professor id and update the mobile number of the professor
DECLARE
    id professor.PROF_ID%type:='&PROF_ID';
    mob professor.MOBILE%type;
BEGIN
    UPDATE Professor set Mobile =9199009966 where PROF_ID=id; 
    Select Mobile INTO mob FROM Professor where prof_id=id;
    dbms_output.put_line('Professor with id: '||id||'New Mobile number is'||mob);
End;
/

-- Q3.Write a PL/SQL procedure to display the message as ‘Excellent’, ‘Good’, and ‘Fair’
-- depending on the Grade of a student in a course
DECLARE
    reg_num Student.reg_no%type:='&reg_no';
    v_grade_message varchar(15);
BEGIN
    Select s.sname as Student_name,
    CASE
        when e.grade='S' then 'Excellent'
        when e.grade='A' then 'Good'
        when e.grade='B' then 'fair'
        ELSE 'Invalid'
        End AS Grade_message
    INTO v_grade_message
    from Student s JOIN Enroll e On s.reg_no=e.reg_no 
    JOIN Class c On e.Cls_code=c.Cls_code
    JOIN COURSE crs On c.Crs_code=crs.Crs_code
    where s.reg_no=reg_num;

    dbms_output.put_line(v_grade_message);
End;
/

-- correct it





-----------------
-- 1 Write a PL/SQL block to get the
--  student register number and print the student details such as sname, address, dob, email and mobile number

Declare 
    REG STUDENT.reg_no%TYPE:='&REG_NO';
    NAME STUDENT.SNAME%TYPE;
    ADD STUDENT.ADDRESS%TYPE;
    DATEOFB STUDENT.DOB%TYPE;
    MAIL STUDENT.EMAIL%TYPE;
    MOB STUDENT.MOBILE%TYPE;
BEGIN
    SELECT sname, address, dob, email, mobile INTO NAME,ADD,DATEOFB,MAIL,MOB FROM STUDENT WHERE REG_NO=REG;
    dbms_output.put_line(NAME||' '||ADD||' '||DATEOFB||' '||' '||MAIL||' '||MOB);
END;

---------------------
-- Write a PL/SQL block the get the professor id and update the mobile number of the professor.

DECLARE 
    PROF Professor.PROF_ID%TYPE:='&PROF_ID';
    MOB Professor.MOBILE%TYPE:='&MOBILE';
BEGIN
    UPDATE Professor SET MOBILE=MOB WHERE PROF_ID=PROF;
END;
/

--------
--Write a PL/SQL procedure to display the message as ‘Excellent’, ‘Good’, and ‘Fair’ depending on the Grade of a 
--student in a course.

BEGIN
    FOR REC IN(
        SELECT GRADE FROM 
        STUDENT,Enroll,Class,COURSE
        WHERE 
        student.reg_no=Enroll.reg_no AND
        Enroll.Cls_code = class.Cls_code AND
        class.Crs_code = course.Crs_code AND
        student.reg_no='2BCA'
    )LOOP
    if rec.Grade ='S' then
        dbms_output.put_line('Excellent');
    elsif rec.Grade ='A' then
        dbms_output.put_line('GOOD');
    ELSif rec.Grade ='B' then
        dbms_output.put_line('FAIR');
    ELSE
        dbms_output.put_line('OKAY');
    END IF;
    END LOOP;
END;
/


--------
 CREATE OR REPLACE FUNCTION HODName1(id department.dept_id%type)
 return varchar2
 is
 name varchar2;
 dept_id=id;
begin
select prof_name into name from professor p inner join department d on p.prof_id=d.prof_id where p.prof_id=dept_id;
dbms_output.put_line(name);
END;
/