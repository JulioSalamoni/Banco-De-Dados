-- create database livraria;
use livraria;
create table autor(
	IdAutor int identity(1,1),
	NomeAutor varchar(100) not null,
	SobrenomeAutor varchar(100) not null,
	constraint pk_id_autor primary key (IdAutor)
);

create table editora(
	IdEditora int identity(1,1) primary key,
	NomeEditora varchar(100) not null
);

create table genero(
	IdGenero int identity(1,1) primary key,
	DescricaoGenero varchar(100) not null
);

create table livro(
	IdLivro int identity(1,1) primary key,
	TituloLivro varchar(200) not null,
	AnoPublicacaoLivro int not null,
	PrecoLivro money not null, -- smallmoney
	DescricaoLivro varchar(max) not null,

	EditoraId int not null,
	GeneroId int not null,

	constraint fk_id_editora foreign key (EditoraId)
	references editora(IdEditora) on delete cascade,

	constraint fk_id_genero foreign key (GeneroId)
	references genero(IdGenero) on delete cascade,

	-- Verifica se o preço é maior que zero
	constraint verificar_preco check (PrecoLivro >= 0)
);

create table LivroAutor (
	LivroId int not null,
	AutorId int not null,

	constraint fk_id_livro foreign key (LivroId)
	references livro(IdLivro) on delete cascade,

	constraint fk_id_autor foreign key (AutorId)
	references autor(IdAutor) on delete cascade,
	
	constraint pk_livro_autor 
	primary key (LivroId,AutorId)
);

select name from livraria.sys.tables;

-- adicinar um campo na tabela livro - EdicaoLivro int
	alter table livro 
	add EdicaoLivro int;
	select * from livro;
-- alterar um tipo de dado na tabela livro - EdicaoLivro tinyint
	alter table livro
	alter column EdicaoLivro tinyint;
-- adicionar uma constraint na tabela livro - EdicaoLivro - verifica_edicao 
-- check (EdicaoLivro >= 0)

	alter table livro 
	add constraint verifica_edicao check (EdicaoLivro >= 0);

-- deletar uma constraint da tabela 
	alter table livro
	drop constraint verifica_edicao;

-- deletar um campo da tabela 
	alter table livro
	drop column EdicaoLivro;

-- adicionar chave primaria a um campo existente
	alter table livro
	add primary key (IdLivro);

-- adicionar chave primaria com constraint
	alter table livro
	add constraint pk_id_livro primary key (IdLivro);
	
sp_help livro;

-- renomear uma tabela 
exec sp_rename 'livro','livro_novo';

-- renomar uma coluna da tabela

exec sp_rename 'livro.TituloLivro','TituloLivroNovo';

exec sp_rename 'livro.TituloLivroNovo','TituloLivro';

select name from livraria.sys.tables;

select * from livro;

insert into autor (NomeAutor, SobrenomeAutor) 
values
('J.K','Rowling'),
('George','Orwell'),
('Harper','Lee'),
('F. Scott',' Fitzgerald');

insert into editora(NomeEditora)
values 
('Editora A'),
('Editora B'),
('Editora C');

insert into genero(DescricaoGenero)
values
('Ficção'),
('Não-Ficção'),
('Fantasia'),
('Romance');

insert into livro(TituloLivro,AnoPublicacaoLivro,PrecoLivro,DescricaoLivro,
EditoraId,GeneroId)
values 
('Harry Potter e a Pedra Filosofal',1997, 39.90,'Descrição 1', 1, 3),
('1984', 1949, 34.90,'Descrição 2', 2, 1),
('O Sol é para todos',1960, 29.50,'Descrição 3', 2, 4),
('O Grande Gatsby',1925, 35.40,'Descrição 4', 2, 4);

insert into LivroAutor(LivroId,AutorId)
values
(1,1),
(2,2),
(3,3),
(4,4);

select * from autor;
select * from editora;
select * from genero;
select * from livro;
select * from LivroAutor;

-- retornar os nomes dos livros, preco, ano

select TituloLivro,PrecoLivro,AnoPublicacaoLivro from livro;

select TituloLivro + ' - ' + cast(PrecoLivro as varchar) 
+ ' - ' + cast(AnoPublicacaoLivro as varchar)
as titulo_preco from livro;

select TituloLivro + ' - ' +  CONVERT(varchar, PrecoLivro) from livro; 

select concat('Nome do Livro: ', TituloLivro, '- Preço do livro: ', PrecoLivro) 
as descricao from livro; 

-- mostrar apenas os sobrenome dos autores
select SobrenomeAutor 
from autor;

-- retornar a lista de gêneros

select DescricaoGenero 
from genero;

-- mostrar a lista de editores com os ids de cada um, com a coluna nomes de 
-- editoras a esquerda da coluna id

select NomeEditora, IdEditora 
from editora order by NomeEditora;

-- mostrar os ids de generos dos quais existem livros cadastrados na tabela livros
-- sem repetição 

Select distinct IdGenero
from genero;


-- cria uma nova tabela com o nome livrosFantasia que contenha os livros do gênero 
-- Fantasia, com os mesmos campos da tabela livro relacionando ao gênero Fantasia

-- usando o GeneroId = 3

select * 
into livrosFantasia 
from livro 
where GeneroId = 3;

drop table livrosFantasia;

-- usando uma subconsulta

select * from livrosFantasia;

-- select * from (select * from livro where GeneroId = 3) as livrosFantasia;

select * 
into livrosFantasia 
from livro 
where GeneroId = (select IdGenero from genero where DescricaoGenero = 'Fantasia');


-- select top 
-- retorna os 2 primeros livros
select top 2 * from livro;

-- retorna por porcentagem
select top 50 percent * from livro;

-- retorna os 2 primeiros livros mais caros
select top 2 * from livro
order by PrecoLivro desc;

select top 2 TituloLivro,PrecoLivro from livro
order by PrecoLivro desc;

select distinct top 2 TituloLivro,PrecoLivro from livro
order by PrecoLivro desc;

-- retorna os 2 primerios livros mas caros com formatação monetario R$ (real)
select top 2 TituloLivro, format(PrecoLivro, 'C','pt-BR') as precoFormatado from livro
order by PrecoLivro desc;

select TituloLivro, format(PrecoLivro, 'C', 'pt-BR') from livro;






create table livroTeste(
	IdLivro int identity(1,1) primary key,
	TituloLivro varchar(200) not null,
	AnoPublicacaoLivro int not null,
	PrecoLivro money not null, -- smallmoney
	DescricaoLivro varchar(max) not null,
	EditoraId int not null,
	GeneroId int not null,
);

insert into livroTeste(TituloLivro,AnoPublicacaoLivro,PrecoLivro,DescricaoLivro,
EditoraId,GeneroId)
values 
('tese',1997, 39.90,'Descrição 1', 1, 3),
('1984test', 1949, 34.90,'Descrição 2', 2, 1),
('O Sol é para todosteste',1960, 29.50,'Descrição 3', 2, 4),
('O Grande Gatsbytse',1925, 35.40,'Descrição 4', 2, 4);

-- limpar a tabela (remover todos os dados da tabela livro, mas mantém a estrutura
-- da tabela)

truncate table livroTeste;
select * from livroTeste;

-- verificar se a tabela esta vazia
select count(*) as 'Total livros' from livroTeste;

delete from livroTeste where IdLivro = 6;
delete from livroTeste where IdLivro = 7;
delete from livroTeste where IdLivro = 8;
delete from livroTeste where IdLivro = 9;

-- verificar o valor atual do ID (identity)
select IDENT_CURRENT('livroTeste');

-- reiniciar o valor do ID (identity)
dbcc checkident ('livroTeste', reseed, 0);  

-- combinar consultas com union
-- select colunas from tabela1
-- union
-- select colunas from tabela2;

-- exemplo de uso do union para combinar resultados de duas tabelas
select TituloLivro Resultado, 'Titulo do livro' from livro
union 
select NomeEditora Resultado, 'Editora' from editora;
----
select TituloLivro Resultado, 'Titulo do livro' from livro
union all
select NomeEditora Resultado, 'Editora' from editora;

-- titulo do livro, nome da editora, descrição genero e nome autor

select TituloLivro as  Resultado, 'Titulo do livro' as Descricao from livro
union 
select NomeEditora as  Resultado, 'Editora' as Descricao from editora
union 
select DescricaoGenero as  Resultado, 'Genero' as Descricao from genero
union 
select NomeAutor as  Resultado, 'Autor' as Descricao from autor;
---

select TituloLivro as  Resultado, 'Titulo do livro' as Descricao from livro
union all
select NomeEditora as  Resultado, 'Editora' as Descricao from editora
union all
select DescricaoGenero as  Resultado, 'Genero' as Descricao from genero
union all
select NomeAutor as  Resultado, 'Autor' as Descricao from autor;

-- funções de agregação
-- min, max, avg, sum, count

select 
	min(PrecoLivro) as PrecoMinimo,
	max(PrecoLivro) as PrecoMaximo,
	avg(PrecoLivro) as PrecoMedia,
	sum(PrecoLivro) as PrecoTotal,
	count(*) as TotalLivros
from 
	livro;

-- buscar preco e nome do livro mais caro
select TituloLivro, PrecoLivro from livro 
where PrecoLivro = (select max(PrecoLivro) from livro);

select max(PrecoLivro) from livro;


-- cláusula like

select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like 'O%';
--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '%s';
--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '%Gatsby%';
--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '%e%';
--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '[A-Z]%'; -- busca de A-Z em maiúsculo


--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '[0-9]%'; -- busca de 0 a 9

--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '[A-Z]%'-- busca de A-Z em maiúsculo

and 
	TituloLivro like '%[aeiou]'; -- busca onde termina com vogal (a,e,i,o,u)


--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '[a-zA-Z0-9]%'; 

--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '% %'; 


-- not like
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro not like 'Harry%'; 

--
select 
	TituloLivro,
	PrecoLivro 
from	
	livro
where 
	TituloLivro like '%[^a-zA-Z0-9 ]%'; -- buscar livros cujo titulo contem pelo menos um caractere que não é uma letra(a-z, A-Z), 
	-- um digito (0-9) ou um espaço

Select * from livro;

-- joins: inner join, left jon, right join, full outer join e crossover join


-- inner join: retorna apenas as linha que têm correspondência em ambas as tabelas.
-- left join: retorna todas as linhas da tabela esquerda e as linhas correspondentes da tabela da direita, se existirem.
-- right join: retorna todas as linhas da tabela direira e as linhas correspondentes da tabela da esquerda, se existirem.
-- full outer join: retorna todas as linhas de ambas as tabelas, com NULL onde não há correspondência.
-- crossover join: retorna o produto cartesiano de ambas as tabelas, ou seja, combina cada linha da tabela da esquerda com cada
-- linha da tabela direita.


-- exemplo inner join
select 
	livro.*, genero.DescricaoGenero
from
	livro
join
	genero on livro.GeneroId = genero.IdGenero;

-- 
select 
	l.*, g.DescricaoGenero 
from
	livro as l
join
	genero as g on l.GeneroId = g.IdGenero;

-- 

select 
	l.*, g.DescricaoGenero, e.NomeEditora
from
	livro l
join
	genero g on l.GeneroId = g.IdGenero
join 
	editora e on l.EditoraId = e.IdEditora;


-- 

select 
	l.*, g.DescricaoGenero, e.NomeEditora
from
	livro l
left join
	genero g on l.GeneroId = g.IdGenero
left join 
	editora e on l.EditoraId = e.IdEditora;

-- 

select 
	l.*, g.DescricaoGenero, e.NomeEditora
from
	livro l
right join
	genero g on l.GeneroId = g.IdGenero
right join 
	editora e on l.EditoraId = e.IdEditora;

-- 

select 
	l.*, g.DescricaoGenero, e.NomeEditora
from
	livro l
full outer join
	genero g on l.GeneroId = g.IdGenero
full outer join 
	editora e on l.EditoraId = e.IdEditora;

-- 

select 
	l.*, g.DescricaoGenero, e.NomeEditora
from
	livro l
cross join
	genero g 
cross join
	editora e;

-- exercicios
-- escreva uma consulta que retorne os nomes dos livros e seu genero, ordenados pelo nome do livro
select 
	TituloLivro,
	DescricaoGenero
from
	Livro l
join
	genero g on l.GeneroId = g.IdGenero
order by
	l.TituloLivro asc;
		

-- escreva uma consulta que retorne nome, sobrenome dos autores, os nomes dos livros escritos por eles e o genero do livro.

select 
	NomeAutor,
	SobrenomeAutor,
	TituloLivro,
	DescricaoGenero
from 
	autor a
join 
	LivroAutor la on a.IdAutor = la.AutorId
join 
	livro l on l.IdLivro = la.LivroId
join 
	genero g on l.GeneroId = g.IdGenero;

-- escreva uma consulta que retorne os nomes dos livros, seus preços a editora e o genero do livro, em ordem alfabética pelo nome do
-- livro
select 
	l.TituloLivro,
	l.PrecoLivro,
	e.NomeEditora,
	g.DescricaoGenero

	from
		livro l
	join 
		editora e on l.EditoraId = e.IdEditora
	join
		genero g on l.GeneroId = g.IdGenero
	order by 
		l.TituloLivro asc;
		


-- escreva uma consulta que retorne os nomes dos livros e ano de publicação, cujo sobrenome do autor seja 'Rowling' e o genero do livro
-- seja 'Fantasia'
select 
	TituloLivro,
	AnoPublicacaoLivro
from 
	livro l
join 
	livroAutor la on l.IdLivro = la.LivroId
join 
	autor a on la.AutorId = a.IdAutor
join 
	genero g on l.GeneroId = g.IdGenero
where 
	a.SobrenomeAutor = 'Rowling'
and
	g.DescricaoGenero = 'Fantasia';

--

select 
	l.TituloLivro, l.AnoPublicacaoLivro
from
	LivroAutor liau
join
	autor a on liau.AutorId = a.IdAutor
join
	livro l on liau.LivroId = l.IdLivro
join
	genero g on l.GeneroId = g.	IdGenero
where
	a.SobrenomeAutor like'%Rowling%'
and
	g.DescricaoGenero like '%Fantasia%'



-- escreva uma consulta que retorne os genero e sobrenome dos autores que os livro custam mais de 30 reais 
select 
	DescricaoGenero,
	SobrenomeAutor
from
	livro l
join 
	LivroAutor la on l.IdLivro = la.LivroId
join
	autor a on la.AutorId = a.IdAutor
join
	genero g on l.GeneroId = g.IdGenero
where
	l.PrecoLivro > 30;

exec sp_databases;
exec sp_helpdb 'livraria';
exec sp_tables;



-- escreva uma consulta que retorne preços, generos e nomes dos livros que custam entre 20 e 50 reais, ordenando do mais caro para o 
-- mais barato

select 
	TituloLivro,
	PrecoLivro,
	DescricaoLivro 
from 
	livro l
join 
	genero g on l.GeneroId = g.IdGenero
where
	l.PrecoLivro between 30 and 50
order by 
	l.PrecoLivro desc;



-- -------------------------------------------------------------

-- views
-- sintaxe

/*	create [or alter] view nome_view as 
	select colunas
	from tabela
	[where condição]
	[order by colunas]
*/

create or alter view teste as
select TituloLivro, PrecoLivro, DescricaoLivro
from livro;

select * from teste;

create or alter view vw_cinco_mais_caros as
select top 5 TituloLivro, PrecoLivro
from livro
order by PrecoLivro;

select * from vw_cinco_mais_caros;

exec sp_helptext 'vw_cinco_mais_caros';

-- verificação previa de uma view

if object_id('vw_cinco_mais_caros') is not null
begin 
	drop view vw_cinco_mais_caros;
end;

if object_id('vw_cinco_mais_caros') is not null
	drop view vw_cinco_mais_caros;
go;

-- view com join
create or alter view vw_detalhes_livro as
select 
	l.IdLivro,	
	l.TituloLivro,
	l.AnoPublicacaoLivro,
	l.PrecoLivro,
	l.DescricaoLivro,
	e.NomeEditora,
	g.DescricaoGenero
from livro l
join 
	editora e on l.EditoraId = e.IdEditora
join
	genero g on l.GeneroId = g.IdGenero;



select TituloLivro from vw_detalhes_livro;

create or alter view teste1 
with encryption as
select TituloLivro, PrecoLivro, DescricaoLivro
from livro;

exec sp_helptext 'teste1';

-- ----------------------------------------------------------------------

-- subconsulta
-- um subconsulta é uma consulta SQL aninhada dentro de outra consulta SQL. Ela pode ser usada para retornar dados que serão usados na 
-- consulta externa

select 
	TituloLivro,
	PrecoLivro
from 
	livro
where PrecoLivro > (select avg(PrecoLivro) from livro) ;
----
select avg(PrecoLivro) from livro;
----
select 
	TituloLivro,
	PrecoLivro
from 
	livro
where PrecoLivro > 34.925;
--

select 
	TituloLivro,
	PrecoLivro
from 
	livro 
where EditoraId = (select IdEditora from editora where NomeEditora = 'Editora A');

select IdEditora from editora where NomeEditora = 'Editora C';
select * from livro;
select * from editora;

----

select 
	TituloLivro, 
	PrecoLivro
from 
	livro l,
	(select avg(PrecoLivro) as PrecoMedia from livro) as avgPreco
where l.PrecoLivro > avgPreco.PrecoMedia;


-- ---------


-- crie uma view chamada vw_livro_detalhados que exiba o título do livro, nome da editora e nome do genero

select l.TituloLivro,
		e.NomeEditora,
		g.DescricaoGenero
from livro l
join editora e on l.EditoraId = e.IdEditora
join genero g on l.GeneroId = g.IdGenero;
--
select 
	l.TituloLivro,
	(select e.NomeEditora from editora e where e.IdEditora = l.EditoraId) as NomeEditora,
	(select g.DescricaoGenero from genero g where g.IdGenero = l.GeneroId) as DescricaoGenero
from livro l;

-- crie uma view chamada vw_livro_autores que exiba o título do livro e o nome completo do autor em uma unica coluna
create view vw_livro_autores as
select 
	l.TituloLivro,
	a.NomeAutor + ' ' + a.SobrenomeAutor as 'Nome completo do autor'
from livro l
join LivroAutor la on l.IdLivro = la.LivroId
join autor a on la.AutorId = a.IdAutor;

select * from vw_livro_autores;




-- crie uma view chamada vw_livros_antigo que liste os livros publicados antes do ano 2000, com título, autor e ano publicação
create view vw_livros_antigo as
select 
 -- STRING_AGG('Titulo do livro: ' + l.TituloLivro + ' Ano publicação ' + l.AnoPublicacaoLivro) ,
 CONCAT('Titulo do livro: ', l.TituloLivro, ' | Ano publicação ', l.AnoPublicacaoLivro) AS 'Titulo do livro e ano de publicação',
 a.NomeAutor
 from livro l
	 join LivroAutor la on l.IdLivro = la.LivroId
	 join autor a on la.AutorId = a.IdAutor
 where l.AnoPublicacaoLivro < 2000;
 


 ------

 -- procedure

 -- Uma procedere é um conjunto de instruções SQL que podem ser execultadas como uma única unidade. Elas são usadas para encapsular
 -- lógica de negócios e podem receber parâmetros de entrada e saida.
 
 -- sintaxe
 -- create procedure nome_procedure
 -- (
 --		@paremetro tipo_dados,.....
 -- )
 -- as
 -- begin
	-- instruções SQL
 -- end;

 create or alter procedure sp_teste
 as 
 select 'Teste de procedure' as mesagem; 


 exec sp_teste;

 ----

 create procedure sp_livros_com_preco
 as

 begin
	select l.TituloLivro, l.PrecoLivro from livro l;
 end;

 exec sp_livros_com_preco;

 -----

 create or alter procedure sp_teste (@nome varchar(100))
 as 
 select @nome + ' teste de procedure com parametro' as mesagem; 

  exec sp_teste 'Diego';


-----

 create or alter procedure sp_teste (@nome varchar(100), @idade int)
 as 
 select concat(@nome , ' teste de procedure com parametro ' , @idade) as mesagem; 

  exec sp_teste @idade = 33, @nome = 'Diego';

----

-- criar procedure para retornar os livros de um determinado genero e editora, campos TituloLivro, 
-- PrecoLivro, NomeEditora, DescrocaoGenero

create or alter procedure sp_livro_por_genero_editora
(
@IdGenero int,
@IdEditora int
)
as 
begin
	select 
		l.TituloLivro,
		l.PrecoLivro,
		e.NomeEditora,
		g.DescricaoGenero
	from livro l
	join 
		genero g on l.GeneroId = g.IdGenero
	join
		editora e on l.EditoraId = e.IdEditora
	where 
		@IdGenero = g.IdGenero and @IdEditora = e.IdEditora;
end;


exec sp_livro_por_genero_editora 4,2; 


create or alter procedure sp_valor_compra
(
	@Id int,
	@Quantidade int
)
as
begin
	select TituloLivro,PrecoLivro as 'Preço unitario',  @Quantidade as quantidade, PrecoLivro * @Quantidade as 'Valor Total'
	from livro
	where IdLivro = @Id;
end;

exec sp_valor_compra 1, 2;

--- 

create or alter procedure sp_cadastro_editora
(
	@nome varchar(100)
)
as 
begin
	insert into editora(NomeEditora)values(@nome);
end;

exec sp_cadastro_editora 'Mais uma editora';

select * from editora;

---

-- Trigger (gatilho)

-- No SQL Server, existe três tipos de triggers:

-- - DML (Data manipulation language): Disparo por eventos DML com insert, updade e delete.
-- - DDL (Data definition language): Disparados por eventos DDL como create, alter e drop.
-- - Logon trigger: Disparados em resposta a eventos de login do servidor.

-- Modos de disparo de um trigger

-- Um trigger no SQL Server pode ser disparado por dois modos
-- - after (depois): O código presente no trigger é execultado após todas as ações terem sido completadas na tabela especificada.
-- - instead of (em vez de): O código presente no trigger é executado no lugar da operação que causou seu disparo.

-- sintaxe
-- create [or alter] trigger nome_trigger
-- on tabela | view
-- [with encrypion]
-- after | instead of [insert, update, delete]
-- as
-- begin
--	código da trigger 
-- end;

create or alter trigger tg_editora_cadastra
on editora
after insert
as
begin 
	select concat('Há ', count(*), ' editoras cadastradas') as cadastro from editora;
end;


insert into editora values ('Mais outra uma editora');
select * from editora;

--  

create or alter trigger tg_bloqueia_autor
on autor
instead of insert
as 
begin
	print('Cadastro de autos não permitido no momento!');
end;

insert into autor (NomeAutor,SobrenomeAutor) values ('José','de Alencar');
select * from autor;

-- 

-- desabilitar uma trigger
alter table autor
disable trigger tg_bloqueia_autor;

-- abilitar uma trigger
alter table autor
enable trigger tg_bloqueia_autor;

-- visualizar os triggers no banco
select * from sys.triggers where is_disabled = 0 or is_disabled = 1;
select * from sys.triggers where is_disabled = 0;
select * from sys.triggers where is_disabled = 1;

-- visualizar os trigger em uma tabela especifica
exec sp_helptrigger @tabname = editora;

---

-- procedure = sp_consulta_autores
-- trigger = tg_insere_autor

create or alter procedure sp_consulta_autores
as
begin
	select * from autor;
end;




create or alter trigger tg_insere_autor
on autor
after insert
as
begin
	exec sp_consulta_autores;
end;

insert into autor (NomeAutor,SobrenomeAutor) values ('Clarice','Lispector');




---------
--------------
--------

create or alter procedure sp_inserir_livro_com_autor
(
	@titulo varchar(100),
	@ano int,
	@preco decimal(10,2),
	@idEditora int,
	@idGenero int,
	@idAutor int
)
as 
begin
	declare @novoIdLivro int;

	insert into livro (TituloLivro,AnoPublicacaoLivro,DescricaoLivro,PrecoLivro,EditoraId,GeneroId)
	values 
	(@titulo, @ano, 'descricao do livro', @preco, @idEditora, @idGenero);

	set @novoIdLivro = SCOPE_IDENTITY();

	insert into LivroAutor (LivroId,AutorId)
	values
	(@novoIdLivro,@idAutor);
	   
end;

exec sp_inserir_livro_com_autor 'Dom Casmurro', 1899, 56.50, 1, 2, 3;


select * from livro;
select * from autor;
select * from genero;
select * from livroAutor;


---------

-- backup 

-- sintaxe

-- backup database nome_banco
-- to disk = 'C:\caminho\nome_do_arquivo.bak';
-- go


-- restalrar 


-- restore database nome_banco
-- from disk = 'C:\caminho\nome_do_arquivo.bak'
-- [with replace]; -- serve se o banco ja estiver criado 
-- sobrescreve
-- go




backup database livraria
to disk = 'C:\bkp-sql\db_livraria.bak';
go

use master;
go

-- fechar as coneções existentes 
alter database livraria
set single_user with rollback
immediate;
go

drop database livraria;
go

--

restore database livraria
from disk = 'C:\bkp-sql\db_livraria.bak';
go

use livraria;
go

select * from livro;

-------------


-- 
