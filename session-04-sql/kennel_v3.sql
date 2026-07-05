-- Table structure for table Dogs

DROP TABLE IF EXISTS Dogs;
CREATE TABLE Dogs (
  DogId serial PRIMARY KEY,
  DogName varchar(255) DEFAULT NULL,
  DogBreed varchar(255) DEFAULT NULL,
  DogGender boolean DEFAULT NULL,
  DogTattooed boolean DEFAULT NULL,
  DogTattooNumber int DEFAULT NULL,
  DogBirthDate date DEFAULT NULL,
  DogCoatColor varchar(255) DEFAULT NULL,
  SalePrice decimal(10,2) DEFAULT NULL,
  SaleDate date DEFAULT NULL,
  ClientId int DEFAULT NULL
);

-- Table structure for table Clients

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients (
  ClientId serial PRIMARY KEY,
  ClientLastName varchar(255) DEFAULT NULL,
  ClientFirstName varchar(255) DEFAULT NULL,
  ClientAddress text,
  ClientPhone varchar(20) DEFAULT NULL,
  ClientEmail varchar(255) DEFAULT NULL
);

-- Dumping data for table Dogs

INSERT INTO Dogs (DogName, DogBreed, DogGender, DogTattooed, DogTattooNumber, DogBirthDate, DogCoatColor, SalePrice, SaleDate, ClientId) VALUES 
  ('Wouf','Dalmatian',true,true,55260,'2021-09-24','White',980.00,'2023-08-25',1),
  ('Mentalo','Husky',false,false,NULL,'2017-09-15','White',966.00,'2023-10-25',2),
  ('Maggie','Husky',true,true,99279,'2014-03-27','Brown',883.00,'2022-06-27',3),
  ('Whisky','Rottweiler',true,true,35941,'2020-03-11','Golden',543.00,'2023-02-05',4),
  ('Bibi','Huski',true,true,88123,'2020-10-10','Beige',894.00,NULL,NULL),
  ('Buddy','Labrador',true,false,NULL,'2019-02-05','Red',250.00,'2020-01-01',5),
  ('Sophie','Dalmatian',false,false,NULL,'2016-07-01','Golden',644.00,'2022-03-30',5),
  ('Molly','Rottveiler',false,true,38281,'2018-06-16','Gray',NULL,NULL,NULL),
  ('Padbol','Yorkshire',false,false,NULL,'2014-02-27','White and Black',685.00,NULL,NULL),
  ('Buddy','Labrador',true,false,NULL,'2019-02-05','Red',847.00,'2023-08-14',6),
  ('Bibi','Poodle',false,false,61006,'2018-06-30','Black',692.00,'2022-09-28',7),
  ('Bibi','Poodle',false,true,705423,'2010-04-15','White',197.00,'2021-02-22',8),
  ('Whisky','Poodle',true,false,NULL,'2019-09-25','Beige',NULL,NULL,NULL),
  ('Rocky','Chihuahua',true,false,NULL,'2019-06-15','Black',NULL,NULL,NULL),
  ('Whisky','Husky',true,true,NULL,'2018-09-02','Gray',449.00,'2022-07-28',9),
  ('Duke','Rottweiler',true,false,NULL,'2019-06-13','Black and White',300.00,'2020-01-13',10),
  ('Buddy','Dalmatian',true,false,NULL,'2015-02-13','Brown',410.00,'2023-09-17',11),
  ('Lucy','Fox Terrier',false,false,56352,'2019-10-01','Brown',363.00,'2022-03-14',3),
  ('Whisky','Boxer',true,false,NULL,'2017-08-03','Black',484.00,'2023-12-01',12),
  ('Dora','Dalmatian',false,true,25536,'2023-07-01','White',1000.00,'2022-03-30',5),
  ('Shrek','Pitbull',true,false,NULL,'2018-09-02','Green',250.00,'2022-07-28',12);

-- Dumping data for table Clients

INSERT INTO Clients (ClientLastName, ClientFirstName, ClientAddress, ClientPhone, ClientEmail) VALUES 
  ('Moreau','Anne','9 Rue du Cleps,31000,Toulouse,France','0616273216','anne.moreau@orange.fr'),
  ('Mitchell','Eddy','97 Rue de Paris,75020,Paris,France','0158444288','e.mitchell@hotmail.fr'),
  ('Moreau','William','33 Rue de Crimée,75020,Paris,France','0163243007','william.moreau@free.fr'),
  ('Moreau','Lucia','20 Rue de la soif,75010,Paris,France','0142613306','lucia.moreau@orange.fr'),
  ('Johnson','Céline','52 Rue du sac à dos,69008,Lyon,France','0618490352','celine.johnson@gmail.com'),
  ('Thomas','Nathalie','76 Boulevard des Rousses,69002,Lyon,France ','0748072289','jean.martin@gmail.com'),
  ('Martin','Nathalie','102 Avenue Phoque, Paris,France','0176091014','emilie.moreau@free.fr'),
  ('Gonzalez','Anne','49 Avenue de la joie, 06118, Nice, France','0703825524','anne.gonzalez@hotmail.com'),
  ('Hernandez','José','26 rue Chivas, 58010, Donzy, France','0713522885','j.hernandez@gmail.com'),
  ('Hernandez','Samuel','15 rue des Violettes, 75020, Paris, France','0167531477','youyou@hotmail.fr'),
  ('Rorbert','Sophia','43 Rue Désirée, 69025, Lyon, France','0608507445','sophia.robert@gmail.com'),
  ('Hernandez','José','26 rue de la Modération, 58010, Donzy, France','0614523296','j.hernandez2@gmail.com');
