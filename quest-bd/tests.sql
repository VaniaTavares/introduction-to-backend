USE movies;
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `director` varchar(255) NOT NULL,
  `year` varchar(255) NOT NULL,
  `color` tinyint(1) NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
INSERT INTO
  `movies` (title, director, year, color, duration)
VALUES
  ('Citizen Kane', 'Orson Wells', '1941', 0, 120),
  (
    'The Godfather',
    'Francis Ford Coppola',
    '1972',
    1,
    180
  ),
  (
    'Pulp Fiction',
    'Quentin Tarantino',
    '1994',
    1,
    180
  ),
  (
    'Apocalypse Now',
    'Francis Ford Coppola',
    '1979',
    1,
    150
  ),
  (
    '2001 a space odyssey',
    'Stanley Kubrick',
    '1968',
    1,
    160
  ),
  (
    'The Dark Knight',
    'Christopher Nolan',
    '2008',
    1,
    150
  );
DROP TABLE IF EXISTS `registrations`;
CREATE TABLE `registrations` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(255) NOT NULL,
    `email` varchar(255) UNIQUE NOT NULL,
    `hashedPassword` varchar(255) NOT NULL,
    `token` varchar(255) NOT NULL,
    `createdAt` DATETIME default now(),
    `updatedAt` DATETIME default now(),
    PRIMARY KEY (`id`)
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

INSERT INTO
  `users`(`firstname`, `lastname`, `email`, `city`, `language`, `hashedPassword`)
VALUES
  (
    'Hillary',
    'Danger',
    'hill@example.com',
    'Miami',
    'English',
    "$argon2id$v=19$m=16,t=2,p=1$emVmZXpmemZlemVmZWR6ZXplZg$rqZkhxu5YbqCGHPNrjJZpQ"
  );
  
  SELECT * FROM users;
  
  SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE movies
ADD COLUMN user_id INT;
  
  ALTER TABLE movies
ADD CONSTRAINT fk_users_id
FOREIGN KEY (user_id)
REFERENCES users(id);

  ALTER TABLE users
  ADD COLUMN token VARCHAR(255) NOT NULL;
  
  INSERT INTO
  `users` (firstname, lastname, email, city, language, hashedPassword)
VALUES
  (
    'John',
    'Doe',
    'john.doe@example.com',
    'Paris',
    'English',
    "$argon2id$v=19$m=16,t=2,p=1$emVmZXpmemZlemVmZWR6ZXplZg$rqZkhxu5YbqCGHPNrjJZpQ"
  ),(
    'Valeriy',
    'Appius',
    'valeriy.ppius@example.com',
    'Moscow',
    'Russian',
    '$argon2id$v=19$m=16,t=2,p=1$emVmemVmemZlemZ6ZnpmZQ$eSetR6KPUNAGW+q+wDadcw'
  ),(
    'Ralf',
    'Geronimo',
    'ralf.geronimo@example.com',
    'New York',
    'Italian',
    '$argon2id$v=19$m=16,t=2,p=1$emVmemVmemZlemZ6ZnpmZXphZGF6ZGQ$a0bg5DZB6H6v3jjQC81DXg'
  ),(
    'Maria',
    'Iskandar',
    'maria.iskandar@example.com',
    'New York',
    'German',
    '$argon2id$v=19$m=16,t=2,p=1$emVmemVmemZlenplZHpkZnpmemZlemFkYXpkZA$V1qAnJDyMuuWG7g9yoGYXA'
  ),(
    'Jane',
    'Doe',
    'jane.doe@example.com',
    'London',
    'English',
    '$argon2id$v=19$m=16,t=2,p=1$emVmemVmemZlenplZHpkZGZ6ZnpmZXphZGF6ZGQ$VCzq45PL9t8khtc44Kk5iw'
  ),(
    'Johanna',
    'Martino',
    'johanna.martino@example.com',
    'Milan',
    'Spanish',
    '$argon2id$v=19$m=16,t=2,p=1$emVmemVmemVmemZlenplZHpkZGZ6ZnpmZXphZGF6ZGQ$UKaGZ9hGFn/S5SBQDMe/Uw'
  );

SELECT * FROM registrations;
TRUNCATE registrations;
UPDATE movies SET user_id=2 WHERE id=15;

ALTER TABLE users
DROP COLUMN token;

UPDATE registrations SET email="oly@email.com", updatedAt=now() WHERE id=2;

SELECT subdate(updatedAt) FROM registrations WHERE id=4;
SELECT DATE_ADD(updatedAt, INTERVAL 10 MINUTE) FROM registrations;

START TRANSACTION;  
SAVEPOINT initial;
INSERT INTO registrations(name, email, hashedPassword) VALUES ('Nolan Norris', 'noris@email.com', '$2b$10$FuTZ9PkI2r4CjrwguAQAcO0yOpPmlc8MjgcJRPIJxn1yC/lvo9beG');
SAVEPOINT my_savepoint;
SELECT now() < DATE_ADD(updatedAt, INTERVAL 10 MINUTE) FROM registrations;
UPDATE registrations SET name='Janna Morgan' WHERE id=1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE registrations SET name='Olivia Keen' WHERE id=2;
RELEASE SAVEPOINT my_savepoint;  
COMMIT;
SELECT * FROM registrations;
  
DELIMITER &&  
CREATE PROCEDURE create_user_init (IN vname VARCHAR(255), vemail VARCHAR(255), vhashedPassword VARCHAR(255))  
BEGIN 
START TRANSACTION;  
SAVEPOINT initial;
SET autocommit = OFF;
INSERT INTO registrations(`name`, `email`, `hashedPassword`) VALUES(vname, vemail, vhashedPassword);
SELECT * FROM registrations;
END &&  
DELIMITER ;  

DELIMITER &&  
CREATE PROCEDURE create_user_end ()  
BEGIN 
COMMIT;
SET autocommit = ON;
END &&  
DELIMITER ;  

DELIMITER &&  
CREATE PROCEDURE abort ()  
BEGIN 
ROLLBACK TO SAVEPOINT initial;
SELECT * FROM registrations;
COMMIT;
SET autocommit = ON;
END &&  
DELIMITER ;  

DROP PROCEDURE create_user_init;

CALL create_user_init('Valeria Gon', 'vg@mail.com', '$2b$10$JjJmp04QDK0qpRYSfZJd6usI14PULGC4v1EixQhTjWHROUY8Q/Yr2');

CALL abort();

CALL create_user_end();