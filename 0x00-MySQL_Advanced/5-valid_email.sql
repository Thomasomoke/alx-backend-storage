-- Create a trigger that resets the valid_email flag if the email is changed
DELIMITER //

CREATE TRIGGER reset_valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email is being changed
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = 0;
    END IF;
END//

DELIMITER ;
