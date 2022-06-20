CREATE DATABASE STUDIO
COLLATE Polish_100_CI_AS; 
GO

USE [STUDIO]

CREATE TABLE [dbo].[Artyœci](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (100) NOT NULL,
	[PESEL] [nvarchar] (20) NOT NULL,
	[Email] [nvarchar] (250) NOT NULL,
	[Telefon] [nvarchar] (20) NOT NULL)
CREATE TABLE [dbo].[StatusyRezerwacji](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL)

CREATE TABLE [dbo].[StatusyKlienta](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Nazwa] [nvarchar] (250) UNIQUE NOT NULL)
CREATE TABLE [dbo].[Klienci](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Imie] [nvarchar] (50) NOT NULL,
	[Nazwisko] [nvarchar] (100) NOT NULL,
	[Email] [nvarchar] (250) NOT NULL,
	[Telefon] [nvarchar] (20) NOT NULL,
	[StatusKlienta] [int] FOREIGN KEY REFERENCES StatusyKlienta(ID))
CREATE TABLE [dbo].[Rezerwacje](
	[ID] [int] PRIMARY KEY IDENTITY,
	[KlientID] [int] FOREIGN KEY REFERENCES Klienci(ID),
	[ArtystaID] [int] FOREIGN KEY REFERENCES Artyœci(ID),
	[DataRezerwacji] [datetime] NOT NULL,
	[DataSesji] [datetime] NOT NULL, 
	[CzasSesji] [time] NOT NULL,
	[StatusRezerwacjiID] [int] FOREIGN KEY REFERENCES StatusyRezerwacji(ID))
CREATE TABLE [dbo].[Sesje](
	[ID] [int] PRIMARY KEY IDENTITY,
	[RezerwacjaID] [int] FOREIGN KEY REFERENCES Rezerwacje(ID),
	[KlientID] [int] NOT NULL FOREIGN KEY REFERENCES Klienci(ID),
	[ArtystaID] [int] NOT NULL FOREIGN KEY REFERENCES Artyœci(ID),
	[OpisTatua¿u] [nvarchar] (200),
	[DataSesji] [datetime] NOT NULL, 
	[CzasSesji] [time] NOT NULL,
	[KwotaDoZaplaty] [int])

CREATE TABLE [dbo].[RabatyOkresowe](
	[ID] [int] PRIMARY KEY IDENTITY,
	[Obowi¹zujeOd] [datetime],
    [Obowi¹zujeDo] [datetime],
	[Procent] [int] CHECK ([Procent] IN (5,10,15,20,25,30) ) DEFAULT 5)


CREATE TABLE [dbo].[Tatua¿e](
	[ID] [int] PRIMARY KEY IDENTITY,
	[ArtystaID] [int] NOT NULL FOREIGN KEY REFERENCES  Artyœci(ID),
	[CenaBazowa] [int] NOT NULL,
	[Opis] [nvarchar] (1000))

CREATE TABLE [dbo].[Urlopy](
	[ID] [int] PRIMARY KEY IDENTITY,
	[ArtystaID] [int] FOREIGN KEY REFERENCES Artyœci(ID),
	[Pocz¹tekUrlopu] [datetime] NOT NULL, 
	[KoniecUrlopu] [datetime] NOT NULL)

INSERT INTO Artyœci(Imie, Nazwisko, PESEL, Email, Telefon) 
VALUES ('Kamila', 'Bala', '75092908342', 'kamila.bala@onet.pl', '884317743'),
('Joanna', 'Strojak', '83110523423', 'joanna.strojak@gmail.com', '513518635'),
('Jadwiga', 'Bilecka', '70101023456', 'jadwiga.bilecka@onet.pl', '884815648'),
('Krzysztof', 'Masztaler', '61050512398', 'krzysztof.masztaler@onet.pl', '885716657')

INSERT INTO StatusyRezerwacji(Nazwa)
VALUES ('Op³acona'),
('Nieop³acona'),
('Anulowana')
INSERT INTO StatusyKlienta(Nazwa)
VALUES ('CzarnaLista'),
('Zwyk³yKlientt')
INSERT INTO Klienci (Imie, Nazwisko, Email, Telefon, StatusKlienta) 
VALUES ('Elwira', 'Policzawska', 'elwira.policzawska@onet.pl', '884215842', 2),
('Edward', 'Zelgowski', 'edward.zelgowski@gmail.com', '514016740', 1),
('Jadwiga', 'Derilecka', 'jadwiga.derilecka@onet.pl', '885018850', 2),
('Jadwiga', 'Fulecka', 'jadwiga.fulecka@onet.pl', '885217852', 2),
('Boles³aw', 'Bryndza', 'boles³aw.bryndza@gmail.com', '512819128', 2),
('Adam', 'Dertucha', 'adam.dertucha@gmail.com', '512418624', 2),
('Adam', 'Fodecki', 'adam.fodecki@gmail.com', '512615226', 2),
('Marek', 'Linda', 'marek.linda@gmail.com', '513716237', 2),
('Krzysztof', 'Ibisz', 'krzysztof.ibisz@gmail.com', '513916139', 2),
('Robert', 'Dido', 'robert.dido@onet.pl', '884416344', 2),
('Piotr', 'Forbek', 'piotr.forbek@onet.pl', '884418544', 2),
('Robert', 'Moczysko', 'robert.moczysko@onet.pl', '885515255', 2),
('Pawe³', 'Policzek', 'pawe³.policzek@onet.pl', '885519855', 2),
('Wiktor', 'Dudziak', 'wiktor.dudziak@onet.pl', '885114851', 2),
('Zbigniew', 'Chrupek', 'zbigniew.chrupek@gmail.com', '512516925', 2),
('Andrzej', 'Twardowski', 'andrzej.twardowski@gmail.com', '512617626', 1)

INSERT INTO [RabatyOkresowe] (Obowi¹zujeOd, Obowi¹zujeDo, Procent) 
VALUES ('2021-12-26', '2021-12-31', 30),
('2022-01-01', '2022-01-31', 20),
('2022-06-30', '2022-08-31', 15)


INSERT INTO Urlopy(ArtystaID, Pocz¹tekUrlopu, KoniecUrlopu)
VALUES (1, '2022-07-01', '2022-07-14'),
(2, '2022-03-14', '2022-03-21'),
(2, '2022-06-15', '2022-06-22'),
(3, '2022-07-15', '2022-07-18')

INSERT INTO Tatua¿e(ArtystaID, CenaBazowa, Opis)
VALUES (1, 200, 'Neotradycyjny'),
(2, 250, 'Realistyczny'),
(3, 150, 'Linearny'),
(4, 250, 'Tradycyjny')

INSERT INTO Rezerwacje(KlientID, ArtystaID, DataRezerwacji, DataSesji, CzasSesji, StatusRezerwacjiID) 
VALUES (1,2 ,'2021-09-01' ,'2021-09-13' ,'03:00:00' ,1),
(1,2 ,'2021-09-07' ,'2021-09-16' ,'04:00:00' ,1),
(1,3 ,'2021-09-08' ,'2021-09-18' ,'05:00:00' ,1),
(1,4 ,'2021-09-15' ,'2021-09-30' ,'02:00:00' ,1),
(2,1 ,'2021-10-01' ,'2021-10-10' ,'02:00:00' ,3),
(3,4 ,'2021-10-03' ,'2021-10-15' ,'03:00:00' ,1),
(4,2 ,'2021-10-04' ,'2021-10-18' ,'06:00:00' ,1),
(5,1 ,'2021-10-10' ,'2021-10-30' ,'04:00:00' ,1),
(6,3 ,'2021-10-15' ,'2021-11-05' ,'05:00:00' ,1),
(7,4 ,'2021-10-25' ,'2021-11-12' ,'08:00:00' ,1),
(8,1 ,'2021-11-03' ,'2021-11-14' ,'06:00:00' ,1),
(9,2 ,'2021-11-04' ,'2021-11-17' ,'03:00:00' ,1),
(10,3 ,'2021-11-17' ,'2021-12-01' ,'03:00:00' ,1),
(11,4 ,'2021-12-12' ,'2021-12-20' ,'04:00:00' ,1),
(12,1 ,'2021-12-13' ,'2021-12-27' ,'05:00:00' ,1),
(13,2 ,'2021-12-14' ,'2022-01-05' ,'01:00:00' ,1),
(14,3 ,'2021-12-20' ,'2022-01-10' ,'02:00:00' ,1),
(15,1 ,'2022-01-03' ,'2022-01-25' ,'03:00:00' ,2),
(16,3 ,'2022-01-05' ,'2022-02-01' ,'04:00:00' ,3),
(10,2 ,'2021-01-10' ,'2022-02-04' ,'05:00:00',2),
(10,2 ,'2021-01-17' ,'2022-02-06' ,'07:00:00' ,2),
(11,4 ,'2022-01-21' ,'2022-03-12' ,'08:00:00' ,1),
(13,1 ,'2021-01-25' ,'2022-03-25' ,'01:00:00' ,2),
(14,3 ,'2022-01-26' ,'2022-03-31' ,'02:00:00' ,2)

INSERT INTO Sesje(RezerwacjaID, KlientID, ArtystaID, OpisTatua¿u, DataSesji, CzasSesji)
VALUES (1, 1,2 , 'motyl','2021-09-13' ,'03:00:00'),
(2,1 ,2,'czaszka','2021-09-16' ,'04:00:00'),
(3,1 ,3,'ró¿a','2021-09-18' ,'05:00:00'),
(4,1 ,4,'miecz','2021-09-30' ,'02:00:00'),
(6,3 ,4,'zapa³ka','2021-10-10' ,'02:00:00'),
(7,4 ,2,'w¹¿','2021-10-15' ,'03:00:00'),
(8,5 ,1,'go³¹b','2021-10-18' ,'06:00:00'),
(9,6 ,3,'serce','2021-10-30' ,'04:00:00'),
(10,7 ,4,'strza³a','2021-11-05' ,'05:00:00'),
(11,8 ,1,'motyl','2021-11-12' ,'08:00:00'),
(12,9 ,2,'drzewo','2021-11-14' ,'06:00:00'),
(13,10 ,3,'chmura','2021-11-17' ,'03:00:00'),
(14,11 ,4,'okno','2021-12-01' ,'03:00:00'),
(15,12,1,'jêzyk','2021-12-20' ,'04:00:00'),
(16,13 ,2,'okulary','2021-12-27' ,'05:00:00'),
(17,14 ,3,'usta','2022-01-05' ,'01:00:00'),
(18,15 ,1,'w¹¿','2022-01-10' ,'02:00:00')
