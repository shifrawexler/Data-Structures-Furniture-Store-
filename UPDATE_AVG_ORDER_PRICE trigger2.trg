CREATE OR REPLACE TRIGGER UPDATE_AVG_ORDER_PRICE
AFTER INSERT OR UPDATE OR DELETE ON ORDERS
DECLARE
  avg_price NUMBER;
BEGIN
  -- Calculate average order price
  SELECT AVG(order_price) INTO avg_price FROM ORDERS;
  
  -- Update the average order price in COFFEE_SHOP table
  UPDATE COFFEE_SHOP SET avg_order_price = avg_price;
  
  -- Additional action: Print the updated average order price
  DBMS_OUTPUT.PUT_LINE('Average Order Price updated: ' || avg_price);
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    -- Handle the case when there are no orders
    UPDATE COFFEE_SHOP SET avg_order_price = NULL;
    
  WHEN OTHERS THEN
    -- Handle any other exceptions
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/
