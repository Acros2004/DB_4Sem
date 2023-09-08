use Кар_MyBaseClone
Create table Студенты
( Id_студента int primary key,
  Имя nvarchar(20),
  Фамилия nvarchar(20) not null,
  Отчество nvarchar(20),
  Адрес nvarchar(30),
  Телефон nchar(9),

);

Alter table Студенты add Pol nchar(1) default'м' check (Pol in('м','ж'));

Alter table Студенты
DROP CONSTRAINT CK__Студенты__Pol__412EB0B6;
Alter table Студенты
drop constraint DF__Студенты__Pol__403A8C7D;
Alter table Студенты drop Column Pol; 

insert into Успеваемость(Id_студента,Название_предмета,Оценка)
	values (1,'ООП',9),
	(1,'Ts',9),
	(1,'БД',10),
	(1,'РАТ',9),
	(2,'ООП',8),
	(2,'Ts',9),
	(2,'БД',8),
	(2,'РАТ',9),
	(3,'ООП',6),
	(3,'Ts',5),
	(3,'БД',7),
	(3,'РАТ',8),
	(4,'ООП',8),
	(4,'Ts',8),
	(4,'БД',8),
	(4,'РАТ',8);

insert into Планеты(Название,Радиус,Температура_ядра,Наличие_атмосферы,Наличие_жизни,Спутники)
	values ("Земля",12342,1234,"Да","Да","Луна"),
			("Юпитер",54321,23232,"Нет","Нет","Метис"),
			("Марс",123,222,"Нет","Нет","Фива");
insert into Спутники(Название,Радиус,Расстояние)
	values("Луна",123,4321),
		   ("Метис",222,3333),
		   ("Фива",333,1111);

create table Планеты(
Название nvarchar(20) primary key,
Радиус int,
Температура_ядра int,
Наличие_атмосферы nvarchar(10),
Наличие_жизни nvarchar(10),
Спутники nvarchar(20) foreign key references Спутники(Название),
);
create table Спутники(Название nvarchar(20) primary key,Радиус int,Расстояние int,);