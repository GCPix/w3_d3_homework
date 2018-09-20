DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS artists;


CREATE TABLE artists(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) -- the longest one I have found was 101 characters
);

CREATE TABLE albums(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(500), -- longest title 400 characters so giving some room for growth
  genre VARCHAR(255),
  artist_id INT4 REFERENCES artists(id)
);
