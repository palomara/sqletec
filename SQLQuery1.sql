use master
go

drop database bancoaula
go

create database bancoaula
go

use bancoaula
go


create table tb_cliente (
	id_cliente	int primary key identity (1,1)NOT NULL,
	nome		nvarchar (60),
	endrç		nvarchar (100),
	fone		nvarchar (20),
	email		nvarchar (60))

create table tb_hardware (
	id_hardware	int primary key identity (1,1) NOT NULL,
	descricao	nvarchar (150),
	preço		decimal,
	qtde		int,
	qtdemín		int)

create table tb_vendas (
	id_venda	int primary key identity (1,1)NOT NULL,
	id_cliente	int, 
	data		date,
	vlrtotal	decimal,
	desconto	decimal,
	vlrpago		decimal)

create table vendas_itens (
	id_item		int primary key identity (1,1)NOT NULL,
	id_venda	int, 
	id_hardware int,
	qtde_item	int,
	total_item	int)
 --go 
 --exec sp_databases
-- go
--exec sp_tables
--exec sp_help tb_cliente

go
alter table tb_vendas add constraint fk_idcliente foreign key (id_cliente)references tb_cliente (id_cliente) 
go
alter table vendas_itens add constraint fk_idvenda foreign key (id_venda)references tb_vendas (id_venda) 
go
alter table tb_hardware add constraint fk_idhardware foreign key (id_hardware) references tb_hardware (id_hardware)
go


insert into tb_cliente (nome, endrç, fone, email)
values ('Huguinho', 'Rua das Flores','2620-2959','hugo.rodrigues@outlook.com')
insert into tb_cliente (nome, endrç, fone, email)
values ('Renata', 'Rua 13','2422-4550','renata_2008@outlook.com')
insert into tb_cliente (nome, endrç, fone, email)
values ('Ze Guedes', 'Rua Varzea Nova','2030-1014','zeguedes2001@outlook.com')
insert into tb_hardware (descricao, preço,qtde,qtdemín)
values ('dell computer','1200.00','78','30')
insert into tb_vendas (data, vlrtotal, desconto, vlrpago)
values ('19/08/2010', '1200','10', '1080.00')
insert into vendas_itens (qtde_item,total_item)
values ('1','1')

select * from tb_cliente
select * from tb_hardware
select * from tb_vendas
select * from vendas_itens

go
exec sp_tables