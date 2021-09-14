DROP DATABASE IF EXISTS craigs_list;

CREATE DATABASE craigs_list;

\c craigs_list;

CREATE TABLE region (
    id SERIAL PRIMARY KEY,
    region_name TEXT UNIQUE NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    preferred_region INTEGER REFERENCES region NOT NULL
);

-- CREATE TABLE categories (
--     id SERIAL PRIMARY KEY,
--     category_name TEXT NOT NULL
-- )

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title VARCHAR(20) NOT NULL,
    category TEXT[] NOT NULL,
    body_text TEXT NOT NULL,
    posted_by INTEGER REFERENCES users NOT NULL,
    region INTEGER NOT NULL REFERENCES region,
    location TEXT 
);

--column with same name as table?
INSERT INTO region (region_name)
VALUES
('Boston'),
('Seattle'),
('Chicago'), 
('New York'), 
('Los Angeles'),
('Portland'), 
('Philly'),
('Sacremento'),
('San Diego');

INSERT INTO users (username, preferred_region)
VALUES
('ted', 1),
('bobby', 2),
('Mike', 3), 
('Sam', 4),
('Greg', 5),
('Samantha', 6),
('Kelly', 7), 
('Sarah', 8), 
('Susan', 9);

INSERT INTO posts (title, category, body_text, posted_by, region, location)
VALUES
('Favorite Movies', '{"Entertainment", "Movies"}', 'My three favorite movies are x, y and z', 1, 2, 'Seattle loc'),
('Favorite play', '{"Entertainment"}', 'My three favorite plays are x, y and z', 3, 4, 'Seattle loc'),
('Favorite sport', '{"Entertainment", "sports"}', 'My three favorite is basketball', 8, 4, 'Seattle loc'),
('Missing dog', '{"Help Wanted", "Pets"}', 'lost dog', 3, 8, 'Seattle loc'),
('cute cat', '{"Misc", "Pets"}', 'Look how cute my cat is', 3, 3, 'Seattle loc'),
('workout advice', '{"Advice"}', 'Whats the best gym?', 5, 2, 'Seattle loc'),
('help needed', '{"Help Wanted"}', 'Need help painting house', 6, 1, 'Seattle loc');


--Queries
SELECT title FROM posts
WHERE title ILIKE '%favorite%';

SELECT title, category FROM posts
WHERE category @> '{"Entertainment"}' AND title ILIKE '%sport%'; 

--posts per category
SELECT category, COUNT(*) AS num_posts FROM posts
GROUP BY category
ORDER BY num_posts DESC;

--posts per region
SELECT region_name, COUNT(*) FROM posts
JOIN region ON region.id = posts.id
GROUP BY region_name;

--posts with multiple categories
SELECT title FROM posts
WHERE array_length(category, 1) > 1;