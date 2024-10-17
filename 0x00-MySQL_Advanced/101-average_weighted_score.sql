DELIMITER $$

-- Create the stored procedure ComputeAverageWeightedScoreForUsers
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_user_id INT;

    -- Declare a cursor to iterate through all users
    DECLARE user_cursor CURSOR FOR
        SELECT id FROM users;

    -- Declare a handler to end the loop when there are no more users
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Open the cursor
    OPEN user_cursor;

    user_loop: LOOP
        -- Fetch the current user id
        FETCH user_cursor INTO current_user_id;

        -- Exit the loop if no more users
        IF done THEN
            LEAVE user_loop;
        END IF;

        -- Compute the average weighted score for the current user
        CALL ComputeAverageWeightedScoreForUser(current_user_id);
    END LOOP;

    -- Close the cursor
    CLOSE user_cursor;
END$$

DELIMITER ;
