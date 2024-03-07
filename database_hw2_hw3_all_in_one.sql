CREATE TABLE IF NOT EXISTS Genres (
  ID_genre SERIAL PRIMARY KEY,
  genre_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Singers (
  ID_singer SERIAL PRIMARY KEY,
  singer_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums (
  ID_album SERIAL PRIMARY KEY,
  album_name VARCHAR(100) NOT NULL,
  release_year INTEGER CHECK (release_year >= 1950) NOT NULL
);

CREATE TABLE IF NOT EXISTS Songs (
  ID_song SERIAL PRIMARY KEY,
  song_name VARCHAR(100) NOT NULL,
  duration INTERVAl NOT NULL,
  ID_album INTEGER,
  FOREIGN KEY (ID_album) REFERENCES Albums(ID_album)
);

CREATE TABLE IF NOT EXISTS Collections (
  ID_collection SERIAL PRIMARY KEY,
  collection_name VARCHAR(100) NOT NULL,
  release_year INTEGER CHECK (release_year >= 1950) NOT NULL
);

CREATE TABLE IF NOT EXISTS Singers_Genres (
  ID_singer INTEGER,
  ID_genre INTEGER,
  FOREIGN KEY (ID_singer) REFERENCES Singers(ID_singer),
  FOREIGN KEY (ID_genre) REFERENCES Genres(ID_genre),
  PRIMARY KEY (ID_singer, ID_genre)
);

CREATE TABLE IF NOT EXISTS Singers_Albums (
  ID_singer INTEGER,
  ID_album INTEGER,
  FOREIGN KEY (ID_singer) REFERENCES Singers(ID_singer),
  FOREIGN KEY (ID_album) REFERENCES Albums(ID_album),
  PRIMARY KEY (ID_singer, ID_album)
);

CREATE TABLE IF NOT EXISTS Collections_Songs (
  ID_collection INTEGER,
  ID_song INTEGER,
  FOREIGN KEY (ID_collection) REFERENCES Collections(ID_collection),
  FOREIGN KEY (ID_song) REFERENCES Songs(ID_song),
  PRIMARY KEY (ID_collection, ID_song)
);

INSERT INTO Genres (genre_name) VALUES 
('Поп'),
('Рок'),
('Рэп');

INSERT INTO Singers (singer_name) VALUES
('ВанХельсинг'),
('Глафира Иванова'),
('Джон'),
('Кэти Меш'),
('Рэчл'),
('Саймон');

INSERT INTO Albums (album_name, release_year) VALUES
('Попса гоп ца ца', 2016),
('Рэпер', 2017),
('Живем Рэпом', 2018),
('Рок между строк', 2019),
('Рок-Н-рольщик', 2020),
('Попсовый слэм', 2021),
('Рокер', 2021);

INSERT INTO Songs (song_name, duration, ID_album) VALUES
('Под попсу', '00:03:40', 1),
('Pop dance my dream', '00:03:45', 6),
('Рок навсегда', '00:04:30', 4),
('Рок - это мы', '00:05:20', 5),
('Мой рэп', '00:03:25', 2),
('Улицы с рэпом', '00:03:10', 3),
('my own', '00:04:40', 7),
('own my', '00:03:50', 1),
('my', '00:02:40', 6),
('oh my god', '00:04:25', 4),
('myself', '00:03:45', 5),
('by myself', '00:02:45', 2),
('bemy self', '00:05:25', 3),
('myself by', '00:04:45', 7),
('by myself by', '00:02:55', 1),
('beemy', '00:04:55', 6),
('premyne', '00:03:55', 4);

INSERT INTO Collections (collection_name, release_year) VALUES
('Всяко разно', 2017),
('Меломания', 2018),
('Все жанры тут', 2019),
('Кайфуем', 2021);

INSERT INTO Singers_Genres (ID_singer, ID_genre) VALUES
(1, 2),
(2, 1),
(3, 3),
(4, 3),
(5, 1),
(6, 2);

INSERT INTO Singers_Albums (ID_singer, ID_album) VALUES
(1, 4),
(2, 1),
(3, 2),
(4, 3),
(5, 6),
(6, 5),
(6, 7);

INSERT INTO Collections_Songs (ID_collection, ID_song) VALUES
(1, 1),
(2, 5),
(2, 6),
(3, 3),
(4, 2),
(4, 4),
(4, 7),
(1, 8),
(2, 9),
(2, 10),
(3, 11),
(4, 12),
(4, 13),
(4, 14),
(1, 15),
(2, 16),
(2, 17);

-- Название и продолжительность самого длительного трека
SELECT song_name, duration
FROM Songs
WHERE duration = (SELECT MAX(duration) FROM Songs);

-- Название треков, продолжительность которых не менее 3,5 минут
SELECT song_name
FROM Songs
WHERE duration >= '00:03:30';

-- Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT collection_name
FROM Collections
WHERE release_year BETWEEN 2018 AND 2020;

-- Исполнители, чьё имя состоит из одного слова
SELECT singer_name
FROM Singers
WHERE singer_name NOT LIKE '% %';

-- Название треков, которые содержат слово «мой» или «my»
SELECT song_name
FROM Songs
WHERE song_name ILIKE 'мой %'
OR song_name ILIKE '% мой'
OR song_name ILIKE '% мой %'
OR song_name ILIKE 'my'
OR song_name ILIKE 'my %'
OR song_name ILIKE '% my'
OR song_name ILIKE '% my %';

-- Количество исполнителей в каждом жанре
SELECT g.genre_name, COUNT(sg.ID_singer) AS num_singers
FROM Genres g
LEFT JOIN Singers_Genres sg ON g.ID_genre = sg.ID_genre
GROUP BY g.genre_name;

-- Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(*) AS num_tracks
FROM Songs s
JOIN Albums a ON s.ID_album = a.ID_album
WHERE a.release_year BETWEEN 2019 AND 2020;

-- Средняя продолжительность треков по каждому альбому
SELECT a.album_name, AVG(EXTRACT(EPOCH FROM s.duration)) AS avg_duration_seconds
FROM Albums a
JOIN Songs s ON a.ID_album = s.ID_album
GROUP BY a.album_name;

-- Все исполнители, которые не выпустили альбомы в 2020 году
SELECT singer_name
FROM Singers
WHERE ID_singer NOT IN (SELECT DISTINCT ID_singer FROM Singers_Albums sa JOIN Albums a ON sa.ID_album = a.ID_album WHERE a.release_year = 2020);

-- Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами)
SELECT c.collection_name
FROM Collections c
JOIN Collections_Songs cs ON c.ID_collection = cs.ID_collection
JOIN Songs s ON cs.ID_song = s.ID_song
JOIN Albums a ON s.ID_album = a.ID_album
JOIN Singers_Albums sa ON a.ID_album = sa.ID_album
JOIN Singers si ON sa.ID_singer = si.ID_singer
WHERE si.singer_name = 'ВанХельсинг';