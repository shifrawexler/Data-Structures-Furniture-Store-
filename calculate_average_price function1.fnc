CREATE OR REPLACE FUNCTION calculate_average_price
RETURN NUMBER
IS
  -- Declare variables
  v_total_price NUMBER := 0;
  v_total_count NUMBER := 0;
  v_average_price NUMBER := 0;

  -- Declare cursor
  CURSOR inventory_cursor IS
    SELECT price
    FROM INVENTORY;
BEGIN
  -- Loop through inventory items
  FOR inventory_rec IN inventory_cursor
  LOOP
    -- Increment total price and count
    v_total_price := v_total_price + inventory_rec.price;
    v_total_count := v_total_count + 1;
  END LOOP;
  
  -- Calculate average price
  IF v_total_count > 0 THEN
    v_average_price := v_total_price / v_total_count;
  END IF;
  
  -- Return the average price
  RETURN v_average_price;
  
EXCEPTION
  -- Handle exceptions
  WHEN OTHERS THEN
    RETURN -1; -- Return a negative value to indicate an error
END;
/
