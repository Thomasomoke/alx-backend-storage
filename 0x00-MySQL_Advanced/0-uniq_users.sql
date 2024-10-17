-- SQL script that create a table users
-- with id,emaIl and name as attributes
CREATE TABLE IF NOT EXISTS users (
	-- create a table if it does not exist
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(255) NOT NULL UNIQUE,
	name VARCHAR(255)
);
