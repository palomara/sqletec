use master;
drop database banco_scratch;
create database banco_scratch;
use banco_scratch;





-- Tabelas --

create table tb_pessoas (
id_pessoa int NOT NULL identity (0,1),
nome varchar (50),
email varchar (100) unique,
sexo char(1),

primary key (id_pessoa)
)

create table tb_metodologias (
id_metodologia int NOT NULL identity (0,1),
metodo_nome varchar (100),

primary key (id_metodologia)
)

create table tb_tarefa (
id_tarefa int NOT NULL identity (0,1),
titulo varchar (200) unique,
prazo_estimado date,
descricao varchar (200),
data_inicio date NOT NULL,
data_termino date, 
id_metodologia int,

primary key (id_tarefa),
foreign key (id_metodologia) references tb_metodologias (id_metodologia)
)



create table tarefa_participantes (
id_participante int NOT NULL primary key identity (0,1),
id_tarefa int NOT NULL,
id_pessoa int NOT NULL, 

foreign key (id_tarefa) references tb_tarefa (id_tarefa), 
foreign key (id_pessoa) references tb_pessoas(id_pessoa)
)


-- insert tb_pessoas --

go 
insert into tb_pessoas (nome, email, sexo)
values
('Paloma Rangel', 'palomara@gmail.com', 'f'),
('Juliana Almeida', 'ju2010@hotmail.com', 'f'),
('Marcos Santos', 'marcos_sp2017@outlook.com', 'm'),
('Joel Oliveira', 'profjoel_tide@gmail.com', 'm'),
('Eli Ernesto', 'ernestoeli@yahoo.com', 'm'),
('Mariana Barros', 'mari_116@hotmail.com', 'f');


-- insert tb_metodologia --

go 
insert into tb_metodologias (metodo_nome)
values ('Pomodoro'),
('Método Feynmann'),
('Scrum'),
('Scrum'),
('Pomodoro');

-- insert tb_tarefas --

go
insert into tb_tarefa (titulo, prazo_estimado,descricao, data_inicio, data_termino) 
values
 ('Trabalho de Matematica', '2018-08-20', 'Resolver exercicios de calculo I', '2018-08-07', '2018-08-07'),

 ('Topico do TCC', '2018-08-08', 'Adicionar o indice de figuras', '2018-08-07', '2018-08-09'),

 ('Redação', '2018-08-18', 'Dissertacao argumentativa sobre a saude no Brasil','2018-08-04', '2018-08-20'),

 ('Calculadora em JAVA', '2018-08-09', 'Calculadora com soma, subtracao, multiplicacao e divisao', '2018-08-05', '2018-08-07'),

 ('Enviar documentos', '2018-08-08', 'Enviar documentos para isencao da taxa do vestibular', '2018-08-06', '2018-08-06');

-- insert tarefa_participantes --

go 
insert into tarefa_participantes (id_tarefa, id_pessoa)
values (0,1),(0,2),
(2,5);




-- Consulta --

--select * from tb_pessoas
--select * from tb_tarefa
--select * from tarefa_participantes


--select t.titulo as [Título],
--	t.descricao as [Descrição],
--	t.prazo_estimado as [Prazo]
--	from tb_tarefa as t;
	
--select
--	p.nome as [Nome],
--	p.email as [Email]
--	from tb_pessoas as p;
	
--select
--	m.metodo_nome as [Métodos]
--	from tb_metodologia as m;


--pessoas que não fazem parte de nenhuma tarefa

select c.nome as 'Nome', t.id_tarefa as 'Tarefa'
from tb_pessoas as c  
left join tarefa_participantes as t on c.id_pessoa = t.id_tarefa 
where id_tarefa is NULL;

-- os nomes das metodologias mais utilizadas
select COUNT (metodo_nome) as 'Quantidade', metodo_nome as 'Método' from tb_metodologias group by metodo_nome order by (metodo_nome) DESC;

--quantidade de tarefas realizadas com mulheres

select c.titulo as 'Tarefa', p.sexo as 'Sexo'
from tb_tarefa as c  
left join tb_pessoas as p on c.id_tarefa = p.id_pessoa 
where sexo = 'f'

select count(sexo) as 'Mulheres' from tb_pessoas where sexo = 'f'


--quantidade de tarefas realizadas com homens

select c.titulo as 'Tarefa', p.sexo as 'Sexo'
from tb_tarefa as c  
right join tb_pessoas as p on c.id_tarefa = p.id_pessoa 
where sexo = 'm'

select count(sexo) as 'Homens' from tb_pessoas where sexo = 'm'  

--pessoas com tarefas atrasadas

select p.nome as 'Nome', t.prazo_estimado as 'Prazo', t.data_termino as 'Termino'
from tb_pessoas as p
join tarefa_participantes as r
on p.id_pessoa = r.id_pessoa
join tb_tarefa as t
on r.id_tarefa = t.id_tarefa where t.data_termino > t.prazo_estimado