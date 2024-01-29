# Итоговая аттестация

## Информация о проекте

Необходимо организовать систему учета для питомника, в котором живут
домашние и вьючные животные.

#### 1 Используя команду cat в терминале операционной системы Linux, создать два файла Домашние животные (заполнив файл собаками, кошками, хомяками) и Вьючные животными заполнив файл Лошадьми, верблюдами и ослы), а затем объединить их. Просмотреть содержимое созданного файла. Переименовать файл, дав ему новое имя (Друзья человека).

```
cat > "Домашние животные" <<EOL
Собаки
Кошки
Хомяки
EOL
```

```
cat > "Вьючные животные" <<EOL
Лошади
Верблюды
Ослы
EOL
```

Объеденил эти два файла

```
cat "Домашние животные" "Вьючные животные" > "Друзья человека"
```

Посмотрел содержимое

```
cat "Друзья человека"
```

Переименовал файл

```
mv "Друзья человека" "Лучшие друзья человека"
```

#### 2 Создать директорию, переместить файл туда.

Создал новую директорию

```
mkdir "Контрольная"
```

Переместил файлы в новую директорию

```
mv "Лучшие друзья человека" "Контрольная/"
```

#### 3 Подключить дополнительный репозиторий MySQL. Установить любой пакет из этого репозитория.

Добавил репозиторий

```
sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.17-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.17-1_all.deb
```

Обновил и установил пакет `mysql-server`

```
sudo apt-get update
sudo apt-get install mysql-server
```

#### 4 Установить и удалить deb-пакет с помощью dpkg.

Загрузил, установил, запустил пакет sl

```
wget http://ftp.us.debian.org/debian/pool/main/s/sl/sl_5.02-1_amd64.deb
sudo dpkg -i sl_5.02-1_amd64.deb
sl
```

Удалил пакет

```
sudo dpkg -r sl
```

#### 5 Выложить историю команд в терминале ubuntu

```
cat > "Домашние животные" <<EOL
cat > "Вьючные животные" <<EOL
cat "Домашние животные" "Вьючные животные" > "Друзья человека"
cat "Друзья человека"
mv "Друзья человека" "Лучшие друзья человека"
mkdir "Контрольная"
mv "Лучшие друзья человека" "Контрольная/"
sudo wget https://dev.mysql.com/get/mysql-apt-config_0.8.17-1_all.deb
sudo dpkg -i mysql-apt-config_0.8.17-1_all.deb
sudo apt-get update
sudo apt-get install mysql-server
wget http://ftp.us.debian.org/debian/pool/main/s/sl/sl_5.02-1_amd64.deb
sudo dpkg -i sl_5.02-1_amd64.deb
sl
sudo dpkg -r sl
```

#### 6 Нарисовать диаграмму, в которой есть класс родительский класс, домашние животные и вьючные животные, в составы которых в случае домашних животных войдут классы: собаки, кошки, хомяки, а в класс вьючные животные войдут: Лошади, верблюды и ослы).

```
                      Животные
                         |
              ---------------------
              |                   |
      Домашние животные   Вьючные животные
              |                   |
   -----------------       -----------------
   |       |       |       |       |       |
 Собаки  Кошки  Хомяки  Лошади  Верблюды  Ослы
```

#### 7 В подключённом MySQL репозитории создать базу данных “Друзья человека”

```
mysql -u amant -p
```

```
CREATE DATABASE PetsDatabase;
```

#### 8 Создать таблицы с иерархией из диаграммы в БД
```sql
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
```

10 Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.

```
DELETE FROM Camels;
```

```sql
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

```

#### 11 Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице

```sql
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


```

#### 12 Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.

```sql
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


```

# Далее код JAVA

##### 13. Создать класс с Инкапсуляцией методов и наследованием по диаграмме.

##### 14. Написать программу, имитирующую работу реестра домашних животных.<br><br>

    В программе должен быть реализован следующий функционал:

    14.1 Завести новое животное
    14.2 определять животное в правильный класс<br>
    14.3 увидеть список команд, которое выполняет животное<br>
    14.4 обучить животное новым командам<br>
    14.5 Реализовать навигацию по меню<br><br>
15. Создайте класс Счетчик, у которого есть метод add(), увеличивающий̆  значение внутренней̆ int переменной̆ на 1 при нажатии “Завести новое
    животное” Сделайте так, чтобы с объектом такого типа можно было работать в
    блоке try-with-resources. Нужно бросить исключение, если работа с объектом
    типа счетчик была не в ресурсном try и/или ресурс остался открыт. Значение
    считать в ресурсе try, если при заведении животного заполнены все поля
