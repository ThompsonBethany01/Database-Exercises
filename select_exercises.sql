-- Use the albums_db database.
USE albums_db;

-- Explore the structure of the albums table.
DESCRIBE albums;

-- Write queries to find the following information.
-- The name of all albums by Pink Floyd
SELECT artist, name
FROM albums
WHERE artist = 'Pink Floyd';

-- The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT artist, name, release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

-- The genre for the album Nevermind
SELECT artist, name, genre
FROM albums
WHERE name = 'Nevermind';

-- Which albums were released in the 1990s
SELECT artist, name, release_date
FROM albums
WHERE release_date BETWEEN 1990 and 1999;

-- Which albums had less than 20 million certified sales
SELECT artist, name, sales
FROM albums
WHERE sales < 20;

-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
SELECT artist, name, genre
FROM albums
WHERE genre = 'Rock';

SELECT artist, name, genre
FROM albums
WHERE genre = 'rock' OR genre = 'Hard Rock' OR genre = 'Progressive Rock' OR genre = 'Alternative Rock';

-- 'Rock' != 'Hard Rock', they are not equivalent

SELECT *
FROM albums
WHERE genre LIKE '%Rock';