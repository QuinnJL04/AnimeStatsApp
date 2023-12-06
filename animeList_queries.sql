USE animeReviews;

SELECT animes.title AS anime_title, reviews.text AS review_text
FROM animes
LEFT JOIN reviews ON animes.uid = reviews.anime_uid;

INSERT INTO favorites_anime (profile_id, anime_uid)
SELECT p.profile_id, a.uid AS anime_uid
FROM profile p
JOIN animes a ON FIND_IN_SET(a.uid, p.favorites_anime)
WHERE p.profile_id = 1;

SELECT * FROM animes;

SELECT * FROM users;

SELECT * FROM reviews;

-- Gets the score of animes in ascending order
SELECT animes.title, reviews.score
FROM reviews
JOIN animes ON reviews.anime_uid = animes.uid
ORDER BY reviews.score ASC;

-- Gets the favorite anime of each user.
SELECT u.profile, a.title AS highest_rated_anime, r.highest_score
FROM users u
JOIN (
    SELECT profile, MAX(score) AS highest_score
    FROM reviews
    GROUP BY profile
) r ON u.profile = r.profile
JOIN reviews rev ON r.profile = rev.profile AND r.highest_score = rev.score
JOIN animes a ON rev.anime_uid = a.uid;


SELECT *
FROM users
WHERE profile = '0lba';

SELECT *
FROM users
WHERE profile = '34pokemon';


SELECT u.profile, r.score AS rating, a.title AS anime_title
FROM users u
JOIN reviews r ON u.profile = r.profile
JOIN animes a ON r.anime_uid = a.uid
WHERE u.profile = '0lba';

SELECT u.profile, r.score AS rating, a.title AS anime_title
FROM users u
JOIN reviews r ON u.profile = r.profile
JOIN animes a ON r.anime_uid = a.uid
WHERE u.profile = '34pokemon';

-- top ten highest rated anime
SELECT title, score
FROM animes
ORDER BY score DESC
LIMIT 10;

-- top ten most popular anime
SELECT title, popularity
FROM animes
ORDER BY popularity DESC
LIMIT 10;

-- ten most recently aired anime 
SELECT title, aired
FROM animes
ORDER BY aired DESC
LIMIT 10;

-- longest animes 
SELECT title, episodes
FROM animes
ORDER BY episodes DESC
LIMIT 10;

-- most interacted with animes
SELECT profile, COUNT(uid) AS review_count
FROM reviews
GROUP BY profile
ORDER BY review_count DESC
LIMIT 10;

-- average score per genre
SELECT genre, ROUND(AVG(score), 2) AS average_score
FROM animes
GROUP BY genre
ORDER BY average_score DESC;

CREATE TEMPORARY TABLE SimilarUsers AS
SELECT DISTINCT r1.profile AS user1, r2.profile AS user2
FROM reviews r1
JOIN reviews r2 ON r1.anime_uid = r2.anime_uid AND r1.profile <> r2.profile
WHERE r1.profile = "34pokemon";

-- Get a list of recommended anime based on what similar users have watched
SELECT DISTINCT a.title, a.genre, AVG(r.score) AS average_score
FROM SimilarUsers s
JOIN reviews r ON s.user2 = r.profile
JOIN animes a ON r.anime_uid = a.uid
WHERE s.user1 = "34pokemon"
GROUP BY a.title, a.genre
ORDER BY average_score DESC
LIMIT 10;

-- gets a specific users most watched genre 

SET @desired_user_profile := '34pokemon';

SELECT genre, COUNT(*) AS watch_count
FROM reviews r
JOIN animes a ON r.anime_uid = a.uid
WHERE r.profile = @desired_user_profile
GROUP BY genre
ORDER BY watch_count DESC
LIMIT 1;










