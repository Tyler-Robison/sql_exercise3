DROP DATABASE IF EXISTS league;

CREATE DATABASE league;

\c league;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT UNIQUE NOT NULL,
    team_location TEXT UNIQUE NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    player_name TEXT NOT NULL,
    plays_for INTEGER REFERENCES teams
);


CREATE TABLE referees (
    id SERIAL PRIMARY KEY,
    ref_name TEXT NOT NULL
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    home_team INTEGER REFERENCES teams,
    away_team INTEGER REFERENCES teams,
    match_location TEXT REFERENCES teams(team_location),
    winner INTEGER REFERENCES teams,
    match_date DATE,
    refed_by INTEGER REFERENCES referees,
    season_id INTEGER REFERENCES seasons 
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    scoring_player INTEGER REFERENCES players,
    match_id INTEGER REFERENCES matches
);

INSERT INTO teams (team_name, team_location)
VALUES
('Boston FC', 'Boston'),
('Wildcats', 'Chicago'),
('Blazers', 'Portland'),
('Bears', 'New Hampshire'),
('Gators', 'Florida'),
('Bulls', 'Texas'),
('Eagles', 'Philly'),
('Stars', 'California');

INSERT INTO players (player_name, plays_for)
VALUES
('Mike Green', 1),
('Mike Brown', 2),
('Sam Smith', 3),
('Teddy Bear', 4), 
('Tyler Robison', 5),
('Will Robison', 6),
('Lindsey Robison', 7),
('Bobby green', 8);

INSERT INTO players (player_name)
VALUES
('Mean Joe'),
('Nice Joe');

INSERT INTO referees (ref_name)
VALUES
('Stripey'),
('Daniel Brown'),
('Michael Jordan');

INSERT INTO seasons (start_date, end_date)
VALUES
('2019-04-01', '2019-09-14'),
('2020-04-03', '2020-09-16'),
('2021-05-02', '2021-10-12');

--How to reference something other than id (example, match_location)
INSERT INTO matches (home_team, away_team, match_location, winner, match_date, refed_by, season_id)
VALUES
(1, 2, 'Boston', 1, '2019-04-14', 1, 1),
(3, 4, 'Portland', 3, '2019-05-28', 2, 1),
(5, 6, 'Florida', 6, '2019-07-11', 3, 1),
(7, 8, 'Philly', 7, '2020-08-18', 2, 2),
(4, 5, 'New Hampshire', 4, '2020-09-07', 2, 2),
(2, 7, 'Chicago', 7, '2021-05-10', 3, 3),
(8, 3, 'California', 8, '2021-07-23', 1, 3),
(6, 2, 'Texas', 6, '2021-09-18', 2, 3),
(7, 4, 'Philly', 4, '2021-09-19', 3, 3);

INSERT INTO goals (scoring_player, match_id)
VALUES
(1, 1),
(3, 2),
(3, 2), 
(4, 2),
(6, 3),
(6, 3),
(7, 4),
(4, 5), 
(4, 5), 
(5, 5),
(7, 7), 
(7, 7),
(2, 7),
(6, 8);

--queries
SELECT winner, team_name, COUNT(*) AS games_won FROM teams
JOIN matches ON teams.id = matches.winner
GROUP BY winner, team_name
ORDER BY games_won DESC;