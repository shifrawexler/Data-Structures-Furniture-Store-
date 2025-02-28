CREATE OR REPLACE PROCEDURE process_orders (
  p_customer_id IN CUSTOMER.CID%TYPE
) IS
  -- Declare variables
  v_order_id ORDERS.ORDRID%TYPE;
  v_order_price ORDERS.ORDER_PRICE%TYPE;
  v_customer_name CUSTOMER.CNAME%TYPE;
  v_branch_name BRANCH.BNAME%TYPE;

  -- Declare cursor
  CURSOR order_cursor IS
    SELECT o.ORDRID, o.ORDER_PRICE, c.CNAME, b.BNAME
    FROM ORDERS o
    JOIN CUSTOMER c ON o.CID = c.CID
    JOIN BRANCH b ON o.EID = b.BID
    WHERE o.CID = p_customer_id;

BEGIN
  -- Open the cursor
  OPEN order_cursor;

  -- Fetch the first record
  FETCH order_cursor INTO v_order_id, v_order_price, v_customer_name, v_branch_name;

  -- Process each record in the loop
  LOOP
    -- Perform operations on the current record
    DBMS_OUTPUT.PUT_LINE('Processing order: ' || v_order_id);
    DBMS_OUTPUT.PUT_LINE('Order price: ' || v_order_price);
    DBMS_OUTPUT.PUT_LINE('Customer name: ' || v_customer_name);
    DBMS_OUTPUT.PUT_LINE('Branch name: ' || v_branch_name);

    -- Fetch the next record
    FETCH order_cursor INTO v_order_id, v_order_price, v_customer_name, v_branch_name;

    -- Exit the loop if no more records
    EXIT WHEN order_cursor%NOTFOUND;
  END LOOP;

  -- Close the cursor
  CLOSE order_cursor;

END;
/
