-- PROCEDURE TO SHOW THE RESULT OF A SPECIFIC STUDENT
CREATE OR REPLACE PROCEDURE Student_Result(
    p_STUDENT_ID CHAR
) IS
    CURSOR c_Enrollments IS
        SELECT e.COURSE_CODE, c.COURSE_TITLE, e.GRADE, e.STATUS
        FROM Enrollment e
        JOIN Course c ON e.COURSE_CODE = c.COURSE_CODE
        WHERE e.STUDENT_ID = p_STUDENT_ID;
        
    v_COURSE_CODE VARCHAR2(10);
    v_COURSE_TITLE VARCHAR2(50);
    v_GRADE CHAR(1);
    v_STATUS CHAR(4);
BEGIN
    OPEN c_Enrollments;
    LOOP
        FETCH c_Enrollments INTO v_COURSE_CODE, v_COURSE_TITLE, v_GRADE, v_STATUS;
        EXIT WHEN c_Enrollments%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Course Code: ' || v_COURSE_CODE);
        DBMS_OUTPUT.PUT_LINE('Course Title: ' || v_COURSE_TITLE);
        DBMS_OUTPUT.PUT_LINE('Grade: ' || v_GRADE);
        DBMS_OUTPUT.PUT_LINE('Status: ' || v_STATUS);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
    CLOSE c_Enrollments;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No enrollments found for the given Student ID.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows returned');
END;


-- Procedure to Insert a student
CREATE OR REPLACE PROCEDURE InsertStudent(
    p_STUDENT_ID CHAR,
    p_FIRST_NAME VARCHAR2,
    p_LAST_NAME VARCHAR2,
    p_CNIC CHAR,
    p_GENDER CHAR,
    p_DOB DATE,
    p_ADDRESS VARCHAR2,
    p_PHONE CHAR,
    p_DEPTNO NUMBER
) IS
BEGIN
    INSERT INTO Student (STUDENT_ID,FIRST_NAME,LAST_NAME,CNIC,
        GENDER,DOB,ADDRESS,PHONE,DEPTNO) VALUES 
(p_STUDENT_ID, p_FIRST_NAME,p_LAST_NAME,p_CNIC,p_GENDER, p_DOB,
 p_ADDRESS,p_PHONE,p_DEPTNO);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Too many Rows');
END;



--	PROCEDURE TO INSERT A RECORD IN ENROLLMENT TABLE AND CALCULATING GRADE BY MARKS
CREATE OR REPLACE PROCEDURE InsertGrade 
(
    p_student_id IN CHAR,
    p_course_id IN VARCHAR2,
    p_marks IN NUMBER
) AS
    v_grade CHAR(1);
    v_status CHAR(4);
BEGIN

    IF p_marks > 85 THEN
        v_grade := 'A';
        v_status := 'PASS';
    ELSIF p_marks > 75 THEN
        v_grade := 'B';
        v_status := 'PASS';
    ELSIF p_marks > 65 THEN
        v_grade := 'C';
        v_status := 'PASS';
    ELSIF p_marks > 50 THEN
        v_grade := 'D';
        v_status := 'PASS';
    ELSE
        v_grade := 'F';
        v_status := 'FAIL';
    END IF;
    INSERT INTO Enrollment (STUDENT_ID, COURSE_CODE, ENROLLMENT_DATE, GRADE, STATUS)
    VALUES (p_student_id, p_course_id, SYSDATE, v_grade, v_status);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Too many rows');
END;





