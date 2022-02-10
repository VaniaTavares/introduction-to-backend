use sqladvanced;
show tables;

SELECT firstname, lastname, age FROM Person;

 SELECT firstname, lastname, age, k.name as Kingdom FROM Person p
 JOIN Kingdom k ON p.kingdom_id=k.id;
 
  SELECT AVG(age) AS AVG_AGE FROM Person;
  
  SELECT k.name AS kingdom, COUNT(firstname) as people FROM Person  p
  RIGHT JOIN Kingdom k ON p.kingdom_id=k.id
  GROUP BY 1;
  
  SELECT role, ROUND(AVG(age),0) AS avg_age FROM Person p
  JOIN Role r ON r.id=p.role_id
  GROUP BY 1;
  
  SELECT ROUND(AVG(age), 0) as avg_age FROM Person p
  LEFT JOIN Role r ON r.id=p.role_id
  WHERE NOT role='magicien';
  
  SELECT firstname, lastname, age, role, name as Kingdom FROM Person p
  JOIN Role r on r.id=p.role_id
  LEFT JOIN Kingdom k ON p.kingdom_id=k.id;
  
  SELECT k.name AS Kingdom, COUNT(*) as People FROM Person p
  JOIN Kingdom k ON k.id=p.kingdom_id
  GROUP BY k.name
  HAVING COUNT(*) > 1;
  
  CREATE DATABASE humming;
  USE humming;
  SET FOREIGN_KEY_CHECKS = 0;
  DROP TABLE IF EXISTS playlists;  
  DROP TABLE IF EXISTS tracks;
  CREATE TABLE playlists(
  `id` INT NOT NULL UNIQUE AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL PRIMARY KEY
  );
  CREATE TABLE tracks(
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `trackId` VARCHAR(100) NOT NULL,
  `artistName` VARCHAR(100) NOT NULL,
  `artistId` VARCHAR(100) NOT NULL,
  `albumName` VARCHAR(100) NOT NULL,
  `albumId` VARCHAR(100) NOT NULL,
  `previewUrl` VARCHAR(255) NOT NULL,
  `uri` VARCHAR(100) NOT NULL,
  CONSTRAINT fk_playlist FOREIGN KEY(uri) REFERENCES playlists(name)
  );
  SET FOREIGN_KEY_CHECKS = 1;
  
  

