DROP DATABASE IF EXISTS array_prac;

CREATE DATABASE array_prac;

\c array_prac;

CREATE TABLE grades (
    student_id SERIAL PRIMARY KEY,
    email TEXT[][],
    test_scores INTEGER[]
);

INSERT INTO grades (email, test_scores)
VALUES
('{{"work", "work1@gmail.com"}, {"home", "home1@gmail.com"}}', '{92, 85, 96, 88}'),
('{{"work", "work2@gmail.com"}}', '{65, 45, 98, 100}'),
('{{"home", "home3@gmail.com"}}', '{87, 88, 44, 54}');

INSERT INTO grades (test_scores)
VALUES
('{{12, 24, 36, 48, 60}, {15, 30, 45, 60}}');

SELECT email[1][1] AS email_type, 
email[1][2] AS email_address,
test_scores[1]
FROM grades;

SELECT email[2][1] AS second_email_type, 
email[2][2] AS email_address,
test_scores
FROM grades;

SELECT email[1][1] AS email_type, 
email[1][2] AS email_address
FROM grades
WHERE email[1][1] = 'work';

SELECT email[1][1] AS email_type, 
email[1][2] AS email_address,
test_scores
FROM grades
WHERE 'home' = ANY (email);

--sql zoo CASE WHEN

SELECT r.mdate, r.team1, sum(r.score1) score1, r.team2, sum(r.score2) score2
FROM (
SELECT mdate,
  team1, 
   CASE 
       WHEN teamid=team1 THEN 1 
       ELSE 0 
   END score1,
   team2,
   CASE 
       WHEN teamid=team2 THEN 1 
       ELSE 0 
   END score2
FROM game JOIN goal ON matchid = id) r 
group by mdate, team1, team2

