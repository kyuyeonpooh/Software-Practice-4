CREATE DATABASE IF NOT EXISTS cinema;

SHOW schemas;

USE cinema;

DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS reservations;

CREATE TABLE members(
   id   varchar(20),
    pwd   VARCHAR(50),
    n   VARCHAR(50),
    contact   varchar(13),
    reservecnt int,
    PRIMARY KEY(id)
) DEFAULT CHARACTER SET = 'utf8';

CREATE TABLE movies(
    title      varchar(20),
    showtime   varchar(6),
    imageroot   varchar(200),
   remainseat   int DEFAULT 156
) DEFAULT CHARACTER SET = 'utf8';

CREATE TABLE reservations(
	id			varchar(20),
    title		varchar(20),
    showtime	varchar(6),
    selectseat	varchar(5),
    PRIMARY KEY (title, showtime, selectseat)
)DEFAULT CHARACTER SET = 'utf8';

INSERT INTO members VALUES('admin', 'admin', '관리자', '000-0000-0000', 0);
INSERT INTO members VALUES('lion721', '0000', '김연재', '010-2550-7505', 0);
INSERT INTO members VALUES('kyuyeonpooh', 'vnqrbdus96', '김규연', '010-5394-4792', 0);

INSERT INTO movies VALUES('말리피센트', '12:00', '../image/MALEFICENT.jpg', 155);
INSERT INTO movies VALUES('말리피센트', '09:00', '../image/MALEFICENT.jpg', 154);
INSERT INTO movies VALUES('범죄도시', '12:00', '../image/범죄도시.jpg', 154);
INSERT INTO movies VALUES('말리피센트', '10:00', '../image/MALEFICENT.jpg', 156);
INSERT INTO movies VALUES('변호인', '04:00', '../image/변호인.jpg', 155);

INSERT INTO reservations VALUES('lion721', '말리피센트', '12:00', 'A1');
INSERT INTO reservations VALUES('lion721', '범죄도시', '12:00', 'G3');
INSERT INTO reservations VALUES('kyuyeonpooh', '범죄도시', '12:00', 'C1');
INSERT INTO reservations VALUES('kyuyeonpooh', '범죄도시', '12:00', 'C3');
INSERT INTO reservations VALUES('lion721', '변호인', '04:00', 'D1');
INSERT INTO reservations VALUES('lion721', '말리피센트', '09:00', 'B1');
INSERT INTO reservations VALUES('kyuyeonpooh', '말리피센트', '09:00', 'G7');

SELECT * FROM members;
SELECT * FROM movies;
SELECT * FROM reservations;