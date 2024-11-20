-- Crear la tabla de artistas
CREATE TABLE artists (
  artist_id INT PRIMARY KEY,
  name VARCHAR(100),
  country VARCHAR(50)
);

-- Crear la tabla artists_archived
CREATE TABLE artists_archived (
  artist_id INT PRIMARY KEY,
  name VARCHAR(100),
  country VARCHAR(50)
);

-- Crear la tabla de álbumes
CREATE TABLE albums (
  album_id INT PRIMARY KEY,
  title VARCHAR(100),
  release_year INT,
  artist_id INT,
  FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

-- Crear la tabla de canciones
CREATE TABLE songs (
  song_id INT PRIMARY KEY,
  title VARCHAR(100),
  duration INT,
  album_id INT,
  FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

-- Insertar datos en la tabla artists
INSERT INTO
  artists (artist_id, name, country)
VALUES
  (1, 'Taylor Swift', 'USA'),
  (2, 'BTS', 'South Korea'),
  (3, 'Adele', 'UK'),
  (4, 'Ed Sheeran', 'UK');

-- Insertar datos en la tabla artists_archived
INSERT INTO
  artists_archived (artist_id, name, country)
VALUES
  (1, 'Taylor Swift', 'USA'),
  -- Artista que también está en artists
  (3, 'Adele', 'UK'),
  -- Artista que también está en artists
  (5, 'Coldplay', 'UK');

-- Artista que no está en artists
-- Insertar datos en la tabla albums
INSERT INTO
  albums (album_id, title, release_year, artist_id)
VALUES
  (1, 'Red', 2012, 1),
  (2, 'Map of the Soul: 7', 2020, 2),
  (3, '25', 2015, 3),
  (4, 'Divide', 2017, 4);

-- Insertar datos en la tabla songs
INSERT INTO
  songs (song_id, title, duration, album_id)
VALUES
  (1, 'All Too Well', 330, 1),
  (2, 'Boy With Luv', 230, 2),
  (3, 'Hello', 295, 3),
  (4, 'Shape of You', 240, 4);