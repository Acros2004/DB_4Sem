use Кар_MyBaseClone
Create table Успеваемость
(
	Id_студента int not null foreign key references 
								Студенты(Id_студента),
	Название_предмета nvarchar(20) not null foreign key references
								Факультативы(Название_предмета),
	Оценка smallint
);