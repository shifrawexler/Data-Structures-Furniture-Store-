CREATE OR REPLACE TRIGGER UPDATE_INVENTORY_PRICE
BEFORE INSERT ON INVENTORY
FOR EACH ROW
BEGIN
  IF :NEW.color = 'Red' THEN
    :NEW.price := :NEW.price + 10;
    
    -- Additional action: Update the notes column
    :NEW.notes := 'Item color is Red. Price increased by 10.';
    
    -- Additional feature: Raise an exception for high-priced items
    IF :NEW.price > 20000 THEN
      RAISE_APPLICATION_ERROR(-20001, 'High-priced items are not allowed!');
    END IF;
  END IF;
END;
/
