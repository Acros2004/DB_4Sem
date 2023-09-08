use Кар_MyBaseClone
Create table Факультативы
(
	Название_предмета nvarchar(20) primary key,
	Объём_лекций smallint,
	Объём_практических smallint,
	Объём_лабараторных smallint
);