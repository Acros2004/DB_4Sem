use ���_MyBaseClone

begin transaction
	select @@SPID;
	insert ������������ values ('5', '��',6); 
	update ������������ set ������ = ������+1 where Id_�������� = 5 and ��������_�������� = 'Ts';

commit
rollback;

delete ������������ where Id_�������� = 5 and ��������_�������� = '��';