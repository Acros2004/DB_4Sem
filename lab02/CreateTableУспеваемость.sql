use ���_MyBaseClone
Create table ������������
(
	Id_�������� int not null foreign key references 
								��������(Id_��������),
	��������_�������� nvarchar(20) not null foreign key references
								������������(��������_��������),
	������ smallint
);