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




