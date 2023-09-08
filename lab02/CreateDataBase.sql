USE master;
go
CREATE database Кар_MyBaseClone on primary
(name = N'Кар_MyBaseClone_mdf',filename = N'D:\BD\Кар_MyBaseClone_mdf.mdf',
    size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'Кар_MyBaseClone_ndf', filename = N'D:\BD\Кар_MyBaseClone_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'Кар_MyBaseClone_fg1_1', filename = N'D:\BD\Кар_MyBaseClone_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Кар_MyBaseClone_fg1_2', filename = N'D:\BD\Кар_MyBaseClone_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
filegroup FG2
( name = N'Кар_MyBaseClone_fg2_1', filename = N'D:\BD\Кар_MyBaseClone_fg2_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Кар_MyBaseClone_fg2_2', filename = N'D:\BD\Кар_MyBaseClone_fg2_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
filegroup FG3
( name = N'Кар_MyBaseClone_fg3_1', filename = N'D:\BD\Кар_MyBaseClone_fg3_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Кар_MyBaseClone_fg3_2', filename = N'D:\BD\Кар_MyBaseClone_fg3_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'Кар_MyBaseClone_log', filename=N'D:\BD\Кар_MyBaseClone_log.ldf',       
   size=10240Kb,  maxsize=1Gb, filegrowth=10%)
   go

 USE Кар_MyBaseClone;
Create table Студенты
( Id_студента int primary key,
  Имя nvarchar(20),
  Фамилия nvarchar(20) not null,
  Отчество nvarchar(20),
  Адрес nvarchar(30),
  Телефон nchar(9),

) on FG1;

Create table Факультативы
(
	Название_предмета nvarchar(20) primary key,
	Объём_лекций smallint,
	Объём_практических smallint,
	Объём_лабараторных smallint
) on FG2;

Create table Успеваемость
(
	Id_студента int not null foreign key references 
								Студенты(Id_студента),
	Название_предмета nvarchar(20) not null foreign key references
								Факультативы(Название_предмета),
	Оценка smallint
) on FG3;