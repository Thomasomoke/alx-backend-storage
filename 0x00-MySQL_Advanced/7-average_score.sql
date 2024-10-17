-- Create the stored procedure ComputeAverageScoreForUser
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(IN p_user_id INT)
BEGIN
    DECLARE v_average_score FLOAT;

    -- Calculate the average score for the given user
    SELECT AVG(score) INTO v_average_score
    FROM corrections
    WHERE user_id = p_user_id;

    -- Update the user's average_score in the users table
    UPDATE users
    SET average_score = v_average_score
    WHERE id = p_user_id;
END//

DELIMITER ;
