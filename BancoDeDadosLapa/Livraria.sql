create database if not exists livraria;
use livraria;
# drop database livraria;
-- -- -- -- -- -- -- tabelas -- -- -- -- -- -- -- -- -- -- -- -- - -- -- -- - -- -- - -- --- -- -- -- -- - -- -- -- -- -- -- -- -- - -- -- --
create table GENERO(
Id_Genero int primary key auto_increment not null,
Descricao_Genero varchar(50) not null);

create table TIPO(
Id_Tipo int primary key auto_increment not null,
Descricao_Tipo varchar(30) not null);

create table EDITORA(
Id_Editora int primary key auto_increment not null,
Nome_Editora varchar(100) not null);

create table LIVRO(
Id_Livro int primary key auto_increment not null,
Titulo_Livro varchar(100) not null,
Preco_Livro decimal(10,2),
Ano_Livro tinyint,
ISBN_Livro varchar(100),
Editora_Id int,
Tipo_Id int,
Genero_Id int,
foreign key (Editora_Id) references EDITORA(Id_Editora),
foreign key (Tipo_Id) references TIPO (Id_Tipo),
foreign key (Genero_Id) references GENERO (Id_Genero));

create table AUTOR(
Id_Autor int primary key auto_increment not null,
Nome_Autor varchar(78) not null);

create table AUTOR_LIVRO(
Id_Autor_Livro int primary key auto_increment not null,
Autor_Id int,
Livro_Id int,
foreign key (Autor_Id) references AUTOR(Id_Autor),
foreign key (Livro_Id) references Livro(Id_Livro));
--
create table CLIENTE(
Id_Cliente int primary key auto_increment not null,
Nome_Cliente varchar(100) not null,
Email_Cliente varchar(100) not null);

create table ENDERECO(
Id_Endereco int primary key auto_increment not null,
Logradouro_Endereco varchar (100) not null,
CEP_Endereco varchar(10),
Numero_Endereco varchar(10),
Complemento_Endereco varchar (100),
Cliente_Id int,
foreign key (Cliente_Id) references CLIENTE (Id_Cliente));
--
create table ESTOQUE(
Id_Estoque int primary key auto_increment not null,
Quantidade_Estoque int not null,
Livro_Id int,
foreign key (Livro_Id) references LIVRO (Id_Livro));

create table FORMA_DE_PAGAMENTO(
Id_Forma_De_Pagamento int primary key auto_increment not null,
Descricao_Forma_De_Pagamento varchar (30));

create table VENDA(
Id_Venda int primary key auto_increment not null,
Parcelas_Venda int,
Status_Venda varchar (10),
Nota_Venda varchar (300),
Data_Venda date not null,
Cliente_Id int,
Forma_De_Pagamento_Id int,
foreign key (Cliente_Id) references CLIENTE (Id_Cliente),
foreign key (Forma_De_Pagamento_Id) references FORMA_DE_PAGAMENTO (Id_Forma_De_Pagamento));

create table AVALIACAO(
Id_Avaliacao int primary key auto_increment not null,
Descricao_Avaliacao text,
Nota_Avaliacao int check (Nota_Avaliacao between 1 and 5),
Data_Avaliacao date);

create table ITEM_PEDIDO(
Id_Item_Pedido int primary key auto_increment not null,
Quantidade_Item_Pedido decimal (5,2),
Preco_Item_Pedido decimal (10,2),
Download_Item_Pedido varchar (300),
Livro_Id int,
Venda_Id int,
Avaliacao_Id int,
foreign key (Livro_Id) references LIVRO (Id_Livro),
foreign key (Venda_Id) references VENDA (Id_Venda),
foreign key (Avaliacao_Id) references AVALIACAO (Id_Avaliacao));

#create table ENTREGA(
#Id_Entrega int primary key auto_increment not null,
#Tipo_Entrega varchar (40),
#Venda_Id int,
#Endereco_Id int,
#foreign key (Venda_Id) references VENDA (Id_Venda),
#foreign key (Endereco_Id) references ENDERECO (Id_Endereco));

create table TELEFONE(
Id_Telefone int primary key auto_increment not null,
Numero_Telefone varchar(30) not null,
Cliente_Id int,
foreign key (Cliente_Id) references CLIENTE (Id_Cliente));

# -----------------------------------------------------------------------------------------------------------------------------------

