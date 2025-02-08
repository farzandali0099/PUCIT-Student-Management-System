-- Trigger that no more than 20 students are enrolled in a course
CREATE OR REPLACE TRIGGER trg_CheckCourseEnrollmentLimit
BEFORE INSERT ON Enrollment
FOR EACH ROW
DECLARE
    v_enrolled_students NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_enrolled_students
    FROM Enrollment
    WHERE COURSE_CODE = :NEW.COURSE_CODE;
        IF v_enrolled_students >= 20 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Enrollment limit exceeded for this course. No more than 20 students can be enrolled.');
    END IF;
END;


-- Trigger to check if student has passed pre req
CREATE OR REPLACE TRIGGER trg_EnforcePrereqCompletion
BEFORE INSERT ON Enrollment
FOR EACH ROW
DECLARE
    v_prereq_completed NUMBER;
BEGIN
    
    SELECT COUNT(*)
    INTO v_prereq_completed
    FROM Enrollment e
    JOIN Pre_Requisite_Course p ON e.COURSE_CODE = p.PRE_REQ
    WHERE e.STUDENT_ID = :NEW.STUDENT_ID
    AND p.COURSE_CODE = :NEW.COURSE_CODE
    AND e.STATUS = 'PASS'; 

    IF v_prereq_completed = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Prerequisite courses not completed.');
    END IF;
END;
