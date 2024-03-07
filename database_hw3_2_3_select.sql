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