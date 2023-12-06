SHOW VARIABLES WHERE variable_name = 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';
SET GLOBAL local_infile = ON;

-- Create the database
DROP DATABASE IF EXISTS animeReviews;
CREATE DATABASE animeReviews;

-- Use the created database
USE animeReviews;

CREATE TABLE animes (
    uid INT PRIMARY KEY,
    title VARCHAR(255),
    synopsis TEXT,
    genre VARCHAR(255),
    aired VARCHAR(50),
    episodes INT,
    members INT,
    popularity INT,
    ranked INT,
    score FLOAT,
    img_url VARCHAR(255),
    link VARCHAR(255)
);

CREATE TABLE users (
    profile VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(10),
    favorites_anime TEXT,
    link VARCHAR(255)
);

CREATE TABLE reviews (
    uid INT PRIMARY KEY,
    profile VARCHAR(50),
    anime_uid INT,
    score INT,
    FOREIGN KEY (profile) REFERENCES users(profile),
    FOREIGN KEY (anime_uid) REFERENCES animes(uid)
);



LOAD DATA LOCAL
INFILE 'C:\\Users\\jaked\\Desktop\\CS3200\\animeData\\animes.csv'
INTO TABLE animes
FIELDS TERMINATED BY ',' -- Specify the delimiter
ENCLOSED BY '"' -- Specify THE WORDS
IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE 'C:\\Users\\jaked\\Desktop\\CS3200\\animeData\\profiles.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' -- Specify the delimiter
ENCLOSED BY '"' -- Specify THE WORDS
IGNORE 1 ROWS;

LOAD DATA LOCAL
INFILE 'C:\\Users\\jaked\\Desktop\\CS3200\\animeData\\reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ',' -- Specify the delimiter
ENCLOSED BY '"' -- Specify THE WORDS
IGNORE 1 ROWS;



