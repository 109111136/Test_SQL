CREATE TABLE Users (
    UserID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FirstName NVARCHAR2(50),
    LastName NVARCHAR2(50),
    Email NVARCHAR2(100) UNIQUE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Music (
    MusicID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Title NVARCHAR2(255) NOT NULL,
    Artist NVARCHAR2(255) NOT NULL,
    Album NVARCHAR2(255),
    Genre NVARCHAR2(100),
    ReleaseDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO Music (Title, Artist, Album, Genre, ReleaseDate)
VALUES (
    'Song' || RAWTOHEX(DBMS_RANDOM.VALUE) ,
    'Artist' || RAWTOHEX(DBMS_RANDOM.VALUE),
    'Album' || RAWTOHEX(DBMS_RANDOM.VALUE),
    'Pop',
    SYSDATE - FLOOR(DBMS_RANDOM.VALUE * 3650)
);

--prepare
INSERT INTO Music (Title, Artist, Album, Genre, ReleaseDate)
VALUES (:Title, :Artist, :Album, :Genre, SYSDATE - FLOOR(DBMS_RANDOM.VALUE * 3650))

${__Random(10000,99999,)}, ${__Random(10000,99999,)}, ${__Random(10000,99999,)}
12, 12, 12, 12 
Title, Artist, Album