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