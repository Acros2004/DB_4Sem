use Кар_MyBaseClone

begin transaction
	select @@SPID;
	insert Успеваемость values ('5', 'БД',6); 
	update Успеваемость set Оценка = Оценка+1 where Id_студента = 5 and Название_предмета = 'Ts';

commit
rollback;

delete Успеваемость where Id_студента = 5 and Название_предмета = 'БД';