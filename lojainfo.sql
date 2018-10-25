use master
go
drop database	lojainfo
go
create database lojainfo
go
use lojainfo


create table tb_cliente (
	id_cliente	int primary key identity (1,1)NOT NULL,
	nome		nvarchar (60),
	endrç		nvarchar (100),
	fone		nvarchar (20),
	email		nvarchar (60)
)

create table tb_hardware (
	id_hardware	int primary key identity (1,1) NOT NULL,
	descricao	nvarchar (150),
	preço		decimal,
	qtde		int,
	qtdemin		int,
	
	foreign key (id_hardware) references tb_hardware (id_hardware)
	
	)

create table tb_vendas (
	id_venda	int primary key identity (1,1)NOT NULL,
	id_cliente	int, 
	data		date,
	vlrtotal	decimal,
	desconto	decimal,
	vlrpago		decimal,
	
	foreign key (id_cliente)references tb_cliente (id_cliente) 
	
	)

create table vendas_itens (
	id_item		int primary key identity (1,1)NOT NULL,
	id_venda	int, 
	id_hardware int,
	qtde_item	int,
	total_item	int,
	
	foreign key (id_venda)references tb_vendas (id_venda), 
	foreign key (id_hardware) references tb_hardware (id_hardware)
	
	)
	
create table tb_cliente_auditoria (
	id_cliente	int primary key identity (1,1)NOT NULL,
	nome		nvarchar (60),
	endrç		nvarchar (100),
	fone		nvarchar (20),
	email		nvarchar (60),
	acao_auditoria nvarchar (100),
	data_auditoria date, 
)	

insert into tb_cliente (nome, endrç, fone, email)
values 
('Huguinho', 'Rua das Flores','2620-2959','hugo.rodrigues@outlook.com'),
('Marcelo', 'Rua Esquerda', '2525-2525', 'marcelo2010@email.com'),
('Paloma', 'Rua Laranja', '2020-2020', 'palomara@email.com'),
('Henrique', 'Sabado Dangelo', '2489-7634', 'hank@email.com')

insert into tb_hardware (descricao, preço, qtde, qtdemin)
values
('Mouse HP', '48.00', '130', '100'),
('Fone Samsung', '35.00' ,'180' ,'150'),
('Computador DELL', '3600.00', '100', '70'),
('Arduino MEGA', '30.00', '200', '150')

insert into tb_vendas (id_cliente, data, vlrtotal, desconto, vlrpago)
values 
(4, '2018-08-19', '83.00' ,'10.00', '73.00'),
(3, '2018-09-01', '3600.00', '200.00', '3400.00')

insert into vendas_itens (id_venda, id_hardware, qtde_item, total_item)
values
(1, 2, 1, 1),
(1, 1, 1, 1) 


select (id_cliente) as 'ID Cliente', (nome) as 'Nome', (endrç) as 'Endereço', (fone) as 'Telefone', (email) as 'E-mail' from tb_cliente 
select (id_hardware) as 'ID Hardware', (descricao) as 'Descrição', (preço) as 'Preço', (qtde) as 'Qtd', (qtdemin) as 'Qtd Mín' from tb_hardware
select (id_venda) as 'ID Venda', (id_cliente) as 'ID Cliente', (data) as 'Data', (vlrtotal) as 'Vlr Total', (desconto) as 'Desconto', (vlrpago) as 'Vlr Pago' from tb_vendas
select (id_venda) as 'ID Venda', (id_hardware) as 'ID Hardware', (qtde_item) as 'Qtd Item', (total_item) as 'Total item' from vendas_itens


go


IF OBJECT_ID ('dbo.selec_produtos_desconto') is not null
	drop procedure dbo.selec_produtos_desconto;
	go
create procedure dbo.selec_produtos_desconto as
begin
	update tb_hardware set preço=preço-(preço*0.30)
	select (id_hardware) as 'ID Hardware', (descricao) as 'Descrição', (preço) as 'Preço', (qtde) as 'Qtd', (qtdemin) as 'Qtd Mín' from tb_hardware
	
end
go
exec dbo.selec_produtos_desconto;

go 

create trigger trq_AfterInserCliente 
on tb_cliente
 instead of insert
as
begin 

declare @cliId int;
declare @cliNome nvarchar (60);
declare @cliEnd nvarchar(100);
declare @cliFone nvarchar(20);
declare @cliEmail nvarchar(60);
declare @audit_action nvarchar (100);

select @cliId = i.id_cliente from inserted i;
select @cliNome = i.nome from inserted i;
select @cliEnd = i.endrç from inserted i;
select @cliEmail = i.email from inserted i;

set @audit_action = 'Registro inserido';

insert into tb_cliente_auditoria (id_cliente, nome, fone, email, acao_auditoria, data_auditoria)
values (@cliId, @cliNome, @cliEnd, @cliEmail, @cliFone, @cliEnd, @audit_action, getdate());

end
go