-- Table structure for table Dogs

DROP TABLE IF EXISTS Dogs;
CREATE TABLE Dogs (
  DogName varchar(255) DEFAULT NULL,
  DogBreed varchar(255) DEFAULT NULL,
  DogGender boolean DEFAULT NULL,
  DogTattooed boolean DEFAULT NULL,
  DogTattooNumber int DEFAULT NULL,
  DogBirthDate date DEFAULT NULL,
  DogCoatColor varchar(255) DEFAULT NULL,
  ClientLastName varchar(255) DEFAULT NULL,
  ClientFirstName varchar(255) DEFAULT NULL,
  ClientAddress text,
  ClientPhone varchar(20) DEFAULT NULL,
  ClientEmail varchar(255) DEFAULT NULL,
  SalePrice decimal(10,2) DEFAULT NULL,
  SaleDate date DEFAULT NULL
);

-- Dumping data for table Dogs

INSERT INTO Dogs VALUES 
  ('Wouf','Dalmatian',true,true,55260,'2021-09-24','White','Moreau','Anne','9 Rue du Cleps, 31000, Toulouse, France','0616273216','anne.moreau@orange.fr',980.00,'2023-08-25'),
  ('Mentalo','Husky',false,false,NULL,'2017-09-15','White','Mitchell','Eddy','97 Rue de Paris, 75020, Paris, France','0158444288','e.mitchell@hotmail.fr',966.00,'2023-10-25'),
  ('Maggie','Husky',true,true,99279,'2014-03-27','Brown','Moreau','William','33 Rue de Crimée, 75020, Paris, France','0163243007','william.moreau@free.fr',883.00,'2022-06-27'),
  ('Whisky','Rottweiler',true,true,35941,'2020-03-11','Golden','Moreau','Lucía','20 Rue de la Soif, 75010, Paris, France','0142613306','lucia.moreau@orange.fr',543.00,'2023-02-05'),
  ('Bibi','Huski',true,true,88123,'2020-10-10','Beige',NULL,NULL,NULL,NULL,NULL,894.00,NULL),
  ('Buddy','Labrador',true,false,NULL,'2019-02-05','Red','Johnson','Céline','52 Rue des Pins, 35010, Rennes, France','0618490352','celine.johnson@gmail.com',250.00,'2020-01-01'),
  ('Sophie','Dalmatian',false,false,NULL,'2016-07-01','Golden','Johnson','Céline','52 Impasse du Coiffeur, 69008, Lyon, France','0618490352','celine.johnson@gmail.com',644.00,'2022-03-30'),
  ('Molly','Rottveiler',false,true,38281,'2018-06-16','Gray',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
  ('Padbol','Yorkshire',false,false,NULL,'2014-02-27','White and Black',NULL,NULL,NULL,NULL,NULL,685.00,NULL),
  ('Buddy','Labrador',true,false,NULL,'2019-02-05','Red','Thomas','Nathalie','76 Boulevard des Rousses, 69002, Lyon, France','0748072289','jean.martin@gmail.com',847.00,'2023-08-14'),
  ('Bibi','Poodle',false,false,61006,'2018-06-30','Black','Martin','Nathalie','102 rue de Paris, 75020, Paris, France','0176091014','emilie.moreau@free.fr',692.00,'2022-09-28'),
  ('Bibi','Poodle',false,true,705423,'2010-04-15','White','Gonzalez','Anne','26 rue de la Chance, 58010, Donzy, France','0703825524','anne.gonzalez@hotmail.com',197.00,'2021-02-22'),
  ('Whisky','Poodle',true,false,NULL,'2019-09-25','Beige',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
  ('Rocky','Chihuahua',true,false,NULL,'2019-06-15','Black',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
  ('Whisky','Husky',true,true,NULL,'2018-09-02','Gray','Hernandez','José','26 rue Chivas, 58010, Donzy, France','0713522885','j.hernandez@gmail.com',449.00,'2022-07-28'),
  ('Duke','Rottweiler',true,false,NULL,'2019-06-13','Black and White','Hernandez','Samuel','15 rue des Violettes, 75020, Paris, France','0167531477','youyou@hotmail.fr',300.00,'2020-01-13'),
  ('Buddy','Dalmatian',true,false,NULL,'2015-02-13','Brown','Robert','Sofía','43 Rue Désirée, 69025, Lyon, France','0608507445','sofia.robert@gmail.com',410.00,'2023-09-17'),
  ('Lucy','Fox Terrier',false,false,56352,'2019-10-01','Brown','Moreau','William','88 Boulevard Debouchage, 06000, Nice, France','0629039017','william.moreau@gmail.com',363.00,'2022-03-14'),
  ('Whisky','Boxer',true,false,NULL,'2017-08-03','Black','Hernandez','José','26 rue de la Modération, 58010, Donzy, France','0713522885','j.hernandez@gmail.com',484.00,'2022-12-01'),
  ('Dora','Dalmatian',false,true,25536,'2023-07-01','White','Johnson','Céline','52 rue du sac à dos, 69001, Lyon, France','0618490352','celine.johnson@gmail.com',1000.00,'2022-03-30');
