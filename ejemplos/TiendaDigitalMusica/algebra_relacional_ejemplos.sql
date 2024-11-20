-- Unión
SELECT
  *
FROM
  artists
UNION
select
  *
from
  artists_archived;

-- Intersección
SELECT
  *
FROM
  artists
INTERSECT
SELECT
  *
FROM
  artists_archived;

-- Diferencia
SELECT
  *
FROM
  artists
EXCEPT
SELECT
  *
FROM
  artists_archived;

-- Producto cartesiano
SELECT
  *
FROM
  artists
  CROSS JOIN albums;

-- Selección
SELECT
  *
FROM
  albums
WHERE
  release_year = 2012;

-- Proyección
SELECT
  name,
  country
from
  artists;

-- Join
SELECT
  artists.name,
  albums.title,
  albums.release_year
FROM
  artists
  INNER JOIN albums ON artists.artist_id = albums.artist_id;

-- Renombrar
CREATE VIEW musicians AS
SELECT
  *
FROM
  artists;

SELECT
  *
from
  musicians;

-- Asignación
CREATE VIEW recent_albums AS
SELECT
  *
FROM
  albums
WHERE
  release_year = 2015;

SELECT
  *
FROM
  recent_albums;