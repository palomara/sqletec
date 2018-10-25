use master
go
drop database	aula24_2018
go
create database aula24_2018
go
use aula24_2018

create table tb_dpto (
id_dpto int primary key identity (0,1)NOT NULL,
nome nvarchar (100)
)

create table tb_pessoa (
id_pessoa int primary key identity (0,1)NOT NULL,
nome nvarchar (100)
)

create table rel_dpto_pessoa (
id int primary key identity (0,1)NOT NULL,
id_pessoa int NOT NULL,
id_dpto int NOT NULL,

foreign key (id_pessoa) references tb_pessoa (id_pessoa),
foreign key (id_dpto) references tb_dpto (id_dpto)

)

go
begin transaction 
	insert into tb_pessoa (nome)
	values
	('Joel'),
	('Marcia'),
	('Ana Maria'),
	('Talita'),
	('Renato'),
	('Cássio'),
	('Daniela'),
	('Amanda'),
	('Gilberto'),
	('Marina'),
	('Lúcio'),
	('Patrícia'),
	('Rejane'),
	('Gabriel')

	go 
	insert into tb_dpto (nome)
	values
	('Administrativo'),
	('Coordenação'),
	('Direção'),
	('Corpo Doscente')

	go 
	insert into rel_dpto_pessoa (id_dpto, id_pessoa)
	values 
	(3, 0),
	(3, 1),
	(3, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(3, 7),
	(3, 8),
	(3, 9),
	(1, 10),
	(2, 11),
	(0, 12),
	(0, 13)
commit
go


select id_pessoa as 'ID', nome as 'Nome' from tb_pessoa
select id_dpto as 'ID', nome as 'Departamento' from tb_dpto
select id as 'ID', id_dpto as 'Departamento', id_pessoa as 'Pessoa' from rel_dpto_pessoa