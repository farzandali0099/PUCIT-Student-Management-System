-- FUNCTION TO GET AVERAGE GRADE POINT IN A COURSE
CREATE OR REPLACE FUNCTION GetAVGGradePoint (
    p_course_code IN VARCHAR2
) RETURN NUMBER IS
    v_average_grade NUMBER;
BEGIN
    SELECT AVG(CASE
                  WHEN GRADE = 'A' THEN 4.0
                  WHEN GRADE = 'B' THEN 3.0
                  WHEN GRADE = 'C' THEN 2.0
                  WHEN GRADE = 'D' THEN 1.0
                  WHEN GRADE = 'F' THEN 0.0
               END)
    INTO v_average_grade
    FROM Enrollment
    WHERE COURSE_CODE = p_course_code;

    RETURN v_average_grade;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;


-- FUNCTION TO GET NUMBER OF COURSES BEING TAUGT BY A SPECIFIC INSTRUCTOR
CREATE OR REPLACE FUNCTION GetClassCountForTeacher (
    p_instructor_id IN CHAR
) RETURN NUMBER IS
    v_class_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_class_count
    FROM Class
    WHERE INSTRUCTOR_ID = p_instructor_id;

    RETURN v_class_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; 
END;


-- FUNCTION TO COUNT THE NUMBER OF GRADUATE STUDENTS IN A DEPARTMENT
CREATE OR REPLACE FUNCTION GetTotalGraduateStudentsInDept (
    p_deptno IN NUMBER
) RETURN NUMBER IS
    v_student_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_student_count
    FROM Graduate_Student gs
    JOIN Student s ON gs.STUDENT_ID = s.STUDENT_ID
    WHERE s.DEPTNO = p_deptno;

    RETURN v_student_count;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN -1; 
END;

