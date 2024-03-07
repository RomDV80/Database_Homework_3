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