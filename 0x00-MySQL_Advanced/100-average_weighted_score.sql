-- Create the stored procedure ComputeAverageWeightedScoreForUser
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weight INT;
    DECLARE weighted_sum FLOAT;
    DECLARE average_weighted_score FLOAT;

    -- Calculate the total weight of all projects for the user
    SELECT SUM(p.weight)
    INTO total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Calculate the weighted sum of scores for the user
    SELECT SUM(c.score * p.weight)
    INTO weighted_sum
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = user_id;

    -- Calculate the average weighted score
    SET average_weighted_score = weighted_sum / total_weight;

    -- Update the user's average_score in the users table
    UPDATE users
    SET average_score = average_weighted_score
    WHERE id = user_id;
END$$

DELIMITER ;
