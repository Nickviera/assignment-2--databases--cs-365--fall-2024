-- Use the password_manager database
USE `password_manager`;

-- Command 1: Add a new user and corresponding website entry
INSERT INTO user_information (first_name, last_name, email, notes)
VALUES ('Lucas', 'Mendoza', 'lucas.mendoza@example.com', 'new work account');

INSERT INTO website (website_name, website_url)
VALUES ('YouTube', 'https://www.youtube.com');

INSERT INTO login_information (username, password, time_created)
VALUES ('lmendoza', AES_ENCRYPT('ytSuperPass321$', @key_str, @init_vector), '2024-10-17 14:45:00');

-- Command 2: Retrieve the password for a specific website URL
SELECT CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) AS 'Decrypted Password'
FROM login_information
JOIN website ON login_information.database_id = website.database_id
WHERE website_url = 'https://www.github.com';

-- Command 3: Retrieve all login information from HTTPS websites
SELECT login_information.database_id, login_information.username, login_information.time_created
FROM login_information
JOIN website ON login_information.database_id = website.database_id
WHERE website_url LIKE 'https%';

-- Command 4: Update a website URL for a specific user based on password
UPDATE website
JOIN login_information ON website.database_id = login_information.database_id
SET website_url = 'https://www.twitch.tv'
WHERE CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) = 'linkedInSuper$456';

-- Command 5: Change a user password based on an old password
UPDATE login_information
SET password = AES_ENCRYPT('newSuperSecurePass$123', @key_str, @init_vector)
WHERE CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) = 'redditSecret999$';

-- Command 6: Delete a user account based on the website URL
DELETE user_information, login_information, website
FROM user_information
JOIN login_information ON user_information.database_id = login_information.database_id
JOIN website ON login_information.database_id = website.database_id
WHERE website_url = 'https://www.pinterest.com';

-- Command 7: Delete a user account based on the password
DELETE user_information, login_information, website
FROM user_information
JOIN login_information ON user_information.database_id = login_information.database_id
JOIN website ON login_information.database_id = website.database_id
WHERE CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) = 'netflixMaster555$';
