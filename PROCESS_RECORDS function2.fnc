CREATE OR REPLACE FUNCTION PROCESS_RECORDS(
  customer_id IN INTEGER 
) RETURN NUMBER IS
  -- Declare variables
  record_count NUMBER := 0;
  record_column orders.ordrid%TYPE; -- Replace "orders" with your actual table name

  CURSOR records_cursor IS
    SELECT ordrid
    FROM orders
    WHERE cid = customer_id; -- Filter orders by the inputted cid

BEGIN
  -- Open the cursor
  OPEN records_cursor;

  -- Start loop
  <<record_loop>>
  LOOP
    -- Fetch records from the cursor
    FETCH records_cursor INTO record_column;

    -- Exit the loop if there are no more records
    EXIT record_loop WHEN records_cursor%NOTFOUND;

    -- Process the record
    -- Apply the 10% discount to the order price
    UPDATE orders
    SET order_price = order_price * 0.9
    WHERE ordrid = record_column;

    -- Increment the record count
    record_count := record_count + 1;
  END LOOP record_loop;

  -- Close the cursor
  CLOSE records_cursor;

  -- Return the count of processed records
  RETURN record_count;
END;
/
