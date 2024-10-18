-- Drop the database if it exists
DROP DATABASE IF EXISTS `password_manager`;
CREATE DATABASE `password_manager` DEFAULT CHARACTER SET utf8mb4;
USE `password_manager`;

-- Create the table for storing user information
CREATE TABLE IF NOT EXISTS user_information (
    database_id      SMALLINT        NOT NULL AUTO_INCREMENT,
    first_name       VARCHAR(20)     NOT NULL,
    last_name        VARCHAR(20)     NOT NULL,
    email            VARCHAR(50)     NOT NULL,
    notes            VARCHAR(500),
    PRIMARY KEY (database_id)
);

-- Create the table for storing website information
CREATE TABLE IF NOT EXISTS website (
    database_id      SMALLINT        NOT NULL AUTO_INCREMENT,
    website_name     VARCHAR(100)    NOT NULL,
    website_url      VARCHAR(200)    NOT NULL,
    PRIMARY KEY (database_id)
);

-- Create the table for storing login credentials
CREATE TABLE IF NOT EXISTS login_information (
    database_id      SMALLINT        NOT NULL AUTO_INCREMENT,
    username         VARCHAR(80)     NOT NULL,
    password         VARBINARY(250)  NOT NULL,
    time_created     DATETIME        DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (database_id)
);

-- Encryption setup for password management
SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('secure_encryption_key', 256));
SET @init_vector = RANDOM_BYTES(16);

-- Insert 10 users into the user_information table
INSERT INTO user_information (first_name, last_name, email, notes) VALUES
    ('Carlos', 'Garcia', 'carlos.garcia@example.com', 'work-related'),
    ('Maria', 'Hernandez', 'maria.hernandez@example.com', 'personal account'),
    ('James', 'Smith', 'james.smith@example.com', 'backup email'),
    ('Sophia', 'Johnson', 'sophia.johnson@example.com', 'secondary work email'),
    ('David', 'Brown', 'david.brown@example.com', 'gaming account'),
    ('Emily', 'Williams', 'emily.williams@example.com', 'social media account'),
    ('Michael', 'Martinez', 'michael.martinez@example.com', 'business-related'),
    ('Olivia', 'Anderson', 'olivia.anderson@example.com', 'private account'),
    ('Daniel', 'Wilson', 'daniel.wilson@example.com', 'professional account'),
    ('Isabella', 'Moore', 'isabella.moore@example.com', 'entertainment account');

-- Insert 10 websites into the website table
INSERT INTO website (website_name, website_url) VALUES
    ('LinkedIn', 'https://www.linkedin.com'),
    ('Twitter', 'https://www.twitter.com'),
    ('GitHub', 'https://www.github.com'),
    ('Medium', 'https://www.medium.com'),
    ('Pinterest', 'https://www.pinterest.com'),
    ('Facebook', 'https://www.facebook.com'),
    ('Instagram', 'https://www.instagram.com'),
    ('Reddit', 'https://www.reddit.com'),
    ('Netflix', 'https://www.netflix.com'),
    ('Spotify', 'https://www.spotify.com');

-- Insert 10 login credentials using AES encryption
INSERT INTO login_information (username, password, time_created) VALUES
    ('cgarcia', AES_ENCRYPT('linkedInSuper$456', @key_str, @init_vector), '2024-10-17 11:00:00'),
    ('mhernandez', AES_ENCRYPT('twitterFunPass!234', @key_str, @init_vector), '2024-09-29 10:20:00'),
    ('jsmith', AES_ENCRYPT('githubSecKey900%', @key_str, @init_vector), '2023-07-12 16:30:00'),
    ('sjohnson', AES_ENCRYPT('mediumPass1234!', @key_str, @init_vector), '2023-10-01 09:45:00'),
    ('dbrown', AES_ENCRYPT('pinterestLove789$', @key_str, @init_vector), '2022-05-10 12:00:00'),
    ('ewilliams', AES_ENCRYPT('facebookFunTime!123', @key_str, @init_vector), '2024-03-22 14:50:00'),
    ('mmartinez', AES_ENCRYPT('instaPass2021#$', @key_str, @init_vector), '2023-06-19 13:15:00'),
    ('oanderson', AES_ENCRYPT('redditSecret999$', @key_str, @init_vector), '2023-02-08 17:25:00'),
    ('dwilson', AES_ENCRYPT('netflixMaster555$', @key_str, @init_vector), '2024-08-15 11:35:00'),
    ('imoore', AES_ENCRYPT('spotifyBestMusic!$', @key_str, @init_vector), '2024-01-05 09:40:00');
