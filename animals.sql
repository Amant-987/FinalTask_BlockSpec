-- Создание базы данных
CREATE DATABASE PetsDatabase;

USE PetsDatabase;

-- Создание таблицы Pets
CREATE TABLE Pets (
    id INT AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY (id)
);

-- Создание таблиц для домашних животных
CREATE TABLE DomesticPets (
    id INT,
    type VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE Dogs (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES DomesticPets(id)
);

CREATE TABLE Cats (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES DomesticPets(id)
);

CREATE TABLE Hamsters (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES DomesticPets(id)
);

-- Создание таблиц для вьючных животных
CREATE TABLE BeastsOfBurden (
    id INT,
    type VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE Horses (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES BeastsOfBurden(id)
);

CREATE TABLE Camels (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES BeastsOfBurden(id)
);

CREATE TABLE Donkeys (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES BeastsOfBurden(id)
);

-- Заполнение иерархических таблиц
INSERT INTO Pets(id, name)
VALUES  (1, 'DomesticPets'),
		(2,'BeastsOfBurden');

INSERT INTO DomesticPets(id,type)
VALUES (1,'Dogs'),(2,'Cats'),(3,'Hamsters');

INSERT INTO BeastsOfBurden(id,type)
VALUES (1,'Horses'),(2,'Camels'),(3,'Donkeys');

-- Заполнение таблицы Dogs
INSERT INTO Dogs (id, name, commands, birth_date) VALUES
(1, 'Rex', 'Sit, Stay, Fetch', '2020-01-01'),
(2, 'Fido', 'Sit, Paw, Roll over', '2019-03-15'),
(3, 'Spot', 'Stay, Fetch, Spin', '2021-06-30');

-- Заполнение таблицы Cats
INSERT INTO Cats (id, name, commands, birth_date) VALUES
(1, 'Whiskers', 'Sit, Purr, Ignore', '2018-07-07'),
(2, 'Fluffy', 'Purr, Nap, Ignore', '2020-02-14'),
(3, 'Mittens', 'Nap, Purr, Ignore', '2019-11-01');

-- Заполнение таблицы Hamsters
INSERT INTO Hamsters (id, name, commands, birth_date) VALUES
(1, 'Squeaky', 'Run, Eat, Sleep', '2021-04-01'),
(2, 'Nibbles', 'Eat, Sleep, Run', '2021-05-15'),
(3, 'Peanut', 'Sleep, Run, Eat', '2021-08-30');

-- Заполнение таблицы Horses
INSERT INTO Horses (id, name, commands, birth_date) VALUES
(1, 'Thunder', 'Gallop, Trot, Jump', '2018-01-01'),
(2, 'Lightning', 'Trot, Gallop, Jump', '2017-03-15'),
(3, 'Storm', 'Jump, Gallop, Trot', '2019-06-30');

-- Заполнение таблицы Camels
INSERT INTO Camels (id, name, commands, birth_date) VALUES
(1, 'Sandy', 'Walk, Run, Sit', '2016-07-07'),
(2, 'Dusty', 'Run, Walk, Sit', '2018-02-14'),
(3, 'Rocky', 'Sit, Walk, Run', '2017-11-01');

-- Заполнение таблицы Donkeys
INSERT INTO Donkeys (id, name, commands, birth_date) VALUES
(1, 'Stubborn', 'Stand, Walk, Run', '2019-04-01'),
(2, 'Silly', 'Walk, Stand, Run', '2020-05-15'),
(3, 'Dopey', 'Run, Stand, Walk', '2018-08-30');

DELETE FROM Camels;

-- Создание новой таблицы HorsesAndDonkeys
CREATE TABLE HorsesAndDonkeys (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    type ENUM('Horse', 'Donkey'),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES BeastsOfBurden(id)
);

-- Заполнение таблицы HorsesAndDonkeys данными из таблицы Horses
INSERT INTO HorsesAndDonkeys (id, name, commands, birth_date, type)
SELECT id, name, commands, birth_date, 'Horse' FROM Horses;

-- Заполнение таблицы HorsesAndDonkeys данными из таблицы Donkeys
INSERT INTO HorsesAndDonkeys (id, name, commands, birth_date, type)
SELECT id, name, commands, birth_date, 'Donkey' FROM Donkeys;

-- Создание новой таблицы YoungAnimals
CREATE TABLE YoungAnimals AS
SELECT *, TIMESTAMPDIFF(MONTH, birth_date, CURDATE()) AS age_in_months
FROM (
    SELECT * FROM Dogs
    UNION ALL
    SELECT * FROM Cats
    UNION ALL
    SELECT * FROM Hamsters
    UNION ALL
    SELECT * FROM Horses
    UNION ALL
    SELECT * FROM Donkeys
) AS AllAnimals
WHERE TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 1 AND 3;

-- Создание новой таблицы AllAnimals
CREATE TABLE AllAnimals (
    id INT,
    name VARCHAR(255),
    commands VARCHAR(255),
    birth_date DATE,
    type ENUM('Dog', 'Cat', 'Hamster', 'Horse', 'Donkey'),
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES Pets(id)
);

-- Заполнение таблицы AllAnimals данными из всех таблиц с животными
INSERT INTO AllAnimals (id, name, commands, birth_date, type)
SELECT id, name, commands, birth_date, 'Dog' FROM Dogs
UNION ALL
SELECT id, name, commands, birth_date, 'Cat' FROM Cats
UNION ALL
SELECT id, name, commands, birth_date, 'Hamster' FROM Hamsters
UNION ALL
SELECT id, name, commands, birth_date, 'Horse' FROM Horses
UNION ALL
SELECT id, name, commands, birth_date, 'Donkey' FROM Donkeys;

