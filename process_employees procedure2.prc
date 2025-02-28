CREATE OR REPLACE PROCEDURE process_employees(
p_branch_id IN EMPLOYEE.bid%TYPE
) IS
  CURSOR employee_cursor IS
    SELECT eid, ename, ephone_number
    FROM EMPLOYEE
    WHERE bid = p_branch_id;

BEGIN
  FOR employee_rec IN employee_cursor LOOP
    -- Process each employee
    -- Perform additional operations or business logic
    
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || employee_rec.eid);
    DBMS_OUTPUT.PUT_LINE('Name: ' || employee_rec.ename);
    DBMS_OUTPUT.PUT_LINE('Phone Number: ' || employee_rec.ephone_number);
    DBMS_OUTPUT.PUT_LINE('---------------------------');
  END LOOP;

END;
/
