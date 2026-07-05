-- Table structure for table Dogs

DROP TABLE IF EXISTS Dogs;
CREATE TABLE Dogs (
  DogId serial PRIMARY KEY,
  DogName varchar(45) NOT NULL,
  BreedId int DEFAULT NULL,
  DogGender boolean DEFAULT NULL,
  DogTattooNumber varchar(45) DEFAULT NULL,
  DogBirthDate date DEFAULT NULL,
  DogCoatColor varchar(45) DEFAULT NULL,
  ClientId int DEFAULT NULL,
  SalePrice decimal(10,0) DEFAULT NULL,
  SaleDate date DEFAULT NULL
);

-- Table structure for table Clients

DROP TABLE IF EXISTS Clients;
CREATE TABLE Clients (
  ClientId serial PRIMARY KEY,
  ClientLastName varchar(45) NOT NULL,
  ClientFirstName varchar(45) NOT NULL,
  ClientAddress varchar(45) NOT NULL,
  ClientPostalCode varchar(10) NOT NULL,
  ClientCity varchar(60) NOT NULL,
  ClientCountry varchar(45) NOT NULL,
  ClientPhone varchar(45) DEFAULT NULL,
  ClientEmail varchar(45) DEFAULT NULL
);

-- Table structure for table Breeds

DROP TABLE IF EXISTS Breeds;
CREATE TABLE Breeds (
  BreedId serial PRIMARY KEY,
  BreedName varchar(45) NOT NULL
);

-- Dumping data for table Dogs

INSERT INTO Dogs (DogName, BreedId, DogGender, DogTattooNumber, DogBirthDate, DogCoatColor, ClientId, SalePrice, SaleDate) VALUES 
  ('Wouf',5,true,'55260','2021-09-24','White',1,980,'2023-08-25'),
  ('Mentalo',6,false,NULL,'2017-09-15','White',2,966,'2023-10-25'),
  ('Maggie',6,true,'99279','2014-03-27','Brown',3,883,'2022-06-27'),
  ('Whisky',2,true,'35941','2020-03-11','Golden',4,543,'2023-02-05'),
  ('Bibi',6,true,'88123','2020-10-10','Beige',NULL,894,NULL),
  ('Buddy',4,true,NULL,'2019-02-05','Red',5,250,'2020-01-01'),
  ('Sophie',5,false,NULL,'2016-07-01','Golden',5,644,'2022-03-30'),
  ('Molly',2,false,'38281','2018-06-16','Gray',NULL,NULL,NULL),
  ('Padbol',7,false,NULL,'2014-02-27','White and Black',NULL,685,NULL),
  ('Buddy',4,true,NULL,'2019-02-05','Red',6,847,'2023-08-14'),
  ('Bibi',8,false,'61006','2018-06-30','Black',7,692,'2022-09-28'),
  ('Bibi',8,false,'705423','2010-04-15','White',8,197,'2021-02-22'),
  ('Whisky',8,true,NULL,'2019-09-25','Beige',NULL,NULL,NULL),
  ('Rocky',3,true,NULL,'2019-06-15','Black',NULL,NULL,NULL),
  ('Whisky',6,true,NULL,'2018-09-02','Gray',9,449,'2022-07-28'),
  ('Duke',2,true,NULL,'2019-06-13','Black and White',10,300,'2020-01-13'),
  ('Buddy',5,true,NULL,'2015-02-13','Brown',11,410,'2023-09-17'),
  ('Lucy',9,false,'56352','2019-10-01','Brown',3,363,'2022-03-14'),
  ('Whisky',10,true,NULL,'2017-08-03','Black',12,484,'2023-12-01'),
  ('Dora',5,false,'25536','2023-07-01','White',5,1000,'2022-03-30'),
  ('Shrek',1,true,NULL,'2018-09-02','Green',12,250,'2022-07-28');

-- Dumping data for table Clients

INSERT INTO Clients (ClientLastName, ClientFirstName, ClientAddress, ClientPostalCode, ClientCity, ClientCountry, ClientPhone, ClientEmail) VALUES 
  ('Moreau','Anne','9 Rue du Cleps','31000','Toulouse','France','0616273216','anne.moreau@orange.fr'),
  ('Mitchell','Eddy','97 Rue de Paris','75020','Paris','France','0158444288','e.mitchell@hotmail.fr'),
  ('Moreau','William','33 Rue de Crimée','75020','Paris','France','0163243007','william.moreau@free.fr'),
  ('Moreau','Lucia','20 Rue de la soif','75010','Paris','France','0142613306','lucia.moreau@orange.fr'),
  ('Johnson','Céline','52 Rue du sac à dos','69008','Lyon','France','0618490352','celine.johnson@gmail.com'),
  ('Thomas','Nathalie','76 Boulevard des Rousses','69002','Lyon','France ','0748072289','jean.martin@gmail.com'),
  ('Martin','Nathalie','102 Avenue Phoque','70010','Paris','France','0176091014','emilie.moreau@free.fr'),
  ('Gonzalez','Anne','49 Avenue de la joie','06118','Nice','France','0703825524','anne.gonzalez@hotmail.fr'),
  ('Hernandez','José','26 rue Chivas','58010','Donzy','France','0713522885','j.hernandez@gmail.com'),
  ('Hernandez','Samuel','15 rue des Violettes','75020','Paris','France','0167531477','youyou@hotmail.fr'),
  ('Rorbert','Sophia','43 Rue Désirée','69025','Lyon','France','0608507445','sophia.robert@gmail.com'),
  ('Hernandez','José','26 rue de la Modération','58010','Donzy','France','0614523296','j.hernandez2@gmail.com');

-- Dumping data for table Breeds

INSERT INTO Breeds (BreedName) VALUES 
  ('Pitbull'),
  ('Rottweiler'),
  ('Chihuahua'),
  ('Labrador'),
  ('Dalmatian'),
  ('Husky'),
  ('Yorkshire'),
  ('Poodle'),
  ('Fox Terrier'),
  ('Boxer');
