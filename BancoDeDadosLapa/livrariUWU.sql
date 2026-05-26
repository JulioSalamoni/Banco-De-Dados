# drop database livrariuwu;
CREATE DATABASE IF NOT EXISTS livrariuwu;
USE livrariuwu;

-- drop database livraria;

-- CLIENTE
CREATE TABLE CLIENTE (
    Id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Cliente VARCHAR(100) NOT NULL,
    Email_Cliente VARCHAR(100) NOT NULL
);


-- ENDERECO
CREATE TABLE ENDERECO (
    Id_Endereco INT AUTO_INCREMENT PRIMARY KEY,
    Logradouro_Endereco VARCHAR(100) NOT NULL,
    Numero_Endereco VARCHAR(10),
    CEP_Endereco VARCHAR(10),
    Bairro_Endereco VARCHAR(50),
    Cidade_Endereco VARCHAR(50),
    Estado_Endereco VARCHAR(2),
    Complemento_Endereco VARCHAR(100),
    Cliente_Id INT,
    FOREIGN KEY (Cliente_Id) REFERENCES CLIENTE(Id_Cliente)
);

-- TELEFONE
CREATE TABLE TELEFONE (
    Id_Telefone INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Telefone VARCHAR(20) NOT NULL,
    Cliente_Id INT,
    FOREIGN KEY (Cliente_Id) REFERENCES CLIENTE(Id_Cliente)
);

-- TIPO_PAGAMENTO
CREATE TABLE TIPO_PAGAMENTO (
    Id_Tipo_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    Descricao_Tipo_Pagamento VARCHAR(50) NOT NULL
);

-- COMPRA
CREATE TABLE COMPRA (
    Id_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Data_Compra DATE NOT NULL,
    Status_Compra VARCHAR(50),
    Parcelas_Compra INT,
    Nota_Fiscal_Compra VARCHAR(50),
    Cliente_Id INT,
    Tipo_Pagamento_Id INT,
    FOREIGN KEY (Cliente_Id) REFERENCES CLIENTE(Id_Cliente),
    FOREIGN KEY (Tipo_Pagamento_Id) REFERENCES TIPO_PAGAMENTO(Id_Tipo_Pagamento)
);

-- TIPO_LIVRO
CREATE TABLE TIPO_LIVRO (
    Id_Tipo_Livro INT AUTO_INCREMENT PRIMARY KEY,
    Descricao_Tipo_Livro VARCHAR(50) NOT NULL
);

-- Tabela de Gênero de Livro (NORMALIZADA)
CREATE TABLE GENERO_LIVRO (
    Id_Genero_Livro INT AUTO_INCREMENT PRIMARY KEY,
    Descricao_Genero_Livro VARCHAR(50) NOT NULL
);

-- EDITORA
CREATE TABLE EDITORA (
    Id_Editora INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Editora VARCHAR(100) NOT NULL
);


CREATE TABLE LIVRO (
    Id_Livro INT AUTO_INCREMENT PRIMARY KEY,
    Titulo_Livro VARCHAR(200) NOT NULL,
    Ano_Publicacao_Livro SMALLINT,
    ISBN_Livro VARCHAR(20),
    Preco_Livro DECIMAL(10,2),
    Editora_Id INT,
    Tipo_Livro_Id INT,
    Genero_Id INT,
    FOREIGN KEY (Editora_Id) REFERENCES EDITORA(Id_Editora),
    FOREIGN KEY (Tipo_Livro_Id) REFERENCES TIPO_LIVRO(Id_Tipo_Livro),
    FOREIGN KEY (Genero_Id) REFERENCES GENERO_LIVRO(Id_Genero_Livro)
);

-- AUTOR
CREATE TABLE AUTOR (
    Id_Autor INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Autor VARCHAR(100) NOT NULL
);

-- LIVRO_AUTOR (Tabela N:N)
CREATE TABLE LIVRO_AUTOR (
    Id_Livro_Autor INT AUTO_INCREMENT PRIMARY KEY,
    Livro_Id INT,
    Autor_Id INT,
    FOREIGN KEY (Livro_Id) REFERENCES LIVRO(Id_Livro),
    FOREIGN KEY (Autor_Id) REFERENCES AUTOR(Id_Autor)
);

-- ESTOQUE
CREATE TABLE ESTOQUE (
    Id_Estoque INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade_Estoque INT NOT NULL,
    Livro_Id INT,
    FOREIGN KEY (Livro_Id) REFERENCES LIVRO(Id_Livro)
);

-- AVALIACAO
CREATE TABLE AVALIACAO (
    Id_Avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    Descricao_Avaliacao TEXT,
   Estrelas_Avaliacao INT CHECK (Estrelas_Avaliacao BETWEEN 1 AND 5)
   --  Estrelas_Avaliacao enum('1','2','3','4','5')
);

-- ITEM_COMPRA
CREATE TABLE ITEM_COMPRA (
    Id_Item_Compra INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade_Item_Compra INT NOT NULL,
    Preco_Unitario DECIMAL(10,2),
    Compra_Id INT,
    Livro_Id INT,
    Avaliacao_Id INT,
    FOREIGN KEY (Compra_Id) REFERENCES COMPRA(Id_Compra),
    FOREIGN KEY (Livro_Id) REFERENCES LIVRO(Id_Livro),
    FOREIGN KEY (Avaliacao_Id) REFERENCES AVALIACAO(Id_Avaliacao)
);

INSERT INTO CLIENTE (Nome_Cliente, Email_Cliente) VALUES
('João da Silva', 'joao@email.com'),
('Maria Oliveira', 'maria@email.com'),
('Willian Shakespeare', 'willian@email.com'),
('Romeu Montecchio ', 'Romu@email.com'),
('Julieta Capuleto','julieta@email.com');

INSERT INTO ENDERECO (Logradouro_Endereco, Numero_Endereco, CEP_Endereco, Bairro_Endereco, Cidade_Endereco, Estado_Endereco,
 Complemento_Endereco, Cliente_Id) VALUES
('Rua das Flores', '123', '12345-678', 'Centro', 'São Paulo', 'SP', 'Apto 1', 1),
('Av. Brasil', '456', '87654-321', 'Jardins', 'Rio de Janeiro', 'RJ', 'Casa', 2),
('rua Great St Helen','99999-999','35','Lapa','São Paulo', 'SP', 'Esquna com Londres',5),
('Rua Tito','99999-333','54','Lapa','São Paulo', 'SP', 'Predio',5);

INSERT INTO TELEFONE (Numero_Telefone, Cliente_Id) VALUES
('11999999999', 1),
('21988888888', 2);

INSERT INTO TIPO_PAGAMENTO (Descricao_Tipo_Pagamento) VALUES
('Cartão de Crédito'),
('Boleto Bancário');

INSERT INTO EDITORA (Nome_Editora) VALUES
('Editora Alpha'),
('Editora Beta'),
('Editora A'),
('Editora B');

-- Inserts de exemplo para TIPO_LIVRO
INSERT INTO TIPO_LIVRO (Descricao_Tipo_Livro) VALUES
('Impresso'),
('Digital'),
('Ambos');

INSERT INTO AUTOR (Nome_Autor) VALUES
('Machado de Assis'),
('Clarice Lispector');



-- Inserts de exemplo para GENERO_LIVRO
INSERT INTO GENERO_LIVRO (Descricao_Genero_Livro) VALUES
('Romance'),
('Drama'),
('Aventura'),
('Terror'),
('Ficção Científica');
-- SELECT * FROM genero_livro;
-- Inserts de exemplo para LIVRO com referência ao GÊNERO
INSERT INTO LIVRO (Titulo_Livro, Ano_Publicacao_Livro, ISBN_Livro, Preco_Livro, Editora_Id, Tipo_Livro_Id, Genero_Id) VALUES
('Dom Casmurro', 1899, '1234567890', 39.90, 1, 1, 1), -- Romance
('A Hora da Estrela', 1977, '0987654321', 29.90, 2, 1, 2), -- Drama
('Viagem ao Centro da Terra', 1864, '2233445566', 49.90, 3, 1, 3), -- Aventura
('It: A Coisa', 1986, '3344556677', 59.90, 1, 1, 4), -- Terror
('Fundação', 1951, '4455667788', 54.90, 2, 2, 5); -- Ficção Científica

INSERT INTO LIVRO_AUTOR (Livro_Id, Autor_Id) VALUES
(1, 1),
(2, 2);

INSERT INTO ESTOQUE (Quantidade_Estoque, Livro_Id) VALUES
(50, 1),
(100, 2);

INSERT INTO COMPRA (Data_Compra, Status_Compra, Parcelas_Compra, Nota_Fiscal_Compra, Cliente_Id, Tipo_Pagamento_Id) VALUES
('2025-04-10', 'Concluída', 1, 'NF123', 1, 1),
('2025-04-11', 'Pendente', 2, 'NF124', 2, 2);

INSERT INTO AVALIACAO (Descricao_Avaliacao, Estrelas_Avaliacao) VALUES
('Excelente leitura!', 1),
('Muito bom, recomendo.', 4);

INSERT INTO ITEM_COMPRA (Quantidade_Item_Compra, Preco_Unitario, Compra_Id, Livro_Id, Avaliacao_Id) VALUES
(1, 39.90, 1, 1, 1), 
(2, 29.90, 2, 2, 2);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --

-- Listar todos os livros com autor, editora e tipo de livro

SELECT 
    L.Titulo_Livro,
    A.Nome_Autor,
    E.Nome_Editora,
    TL.Descricao_Tipo_Livro
FROM LIVRO L
INNER JOIN LIVRO_AUTOR LA ON L.Id_Livro = LA.Livro_Id
INNER JOIN AUTOR A ON LA.Autor_Id = A.Id_Autor
INNER JOIN EDITORA E ON L.Editora_Id = E.Id_Editora
INNER JOIN TIPO_LIVRO TL ON L.Tipo_Livro_Id = TL.Id_Tipo_Livro;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- listar todas as compras com cliente, forma de pagamento e items

select 
C.Id_Compra,
C.Data_Compra,
CLI.Nome_Cliente,
TP.Descricao_Tipo_Pagamento,
L.Titulo_Livro,
IC.Quantidade_Item_Compra,
IC.Preco_Unitario
from COMPRA C

inner join CLIENTE CLI on C.Cliente_Id = CLI.Id_Cliente
inner join TIPO_PAGAMENTO TP on C.Tipo_Pagamento_Id = TP.Id_Tipo_Pagamento
inner join ITEM_COMPRA IC on C.Id_Compra - IC.Compra_Id
inner join LIVRO L on IC.Livro_Id = L.Id_Livro
;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Mostrar avaliações feitas com nome do cliente e título do livro

select
IC.Id_Item_Compra,
CLI.Nome_Cliente,
L.Titulo_Livro,
A.Descricao_Avaliacao,
A.Estrelas_Avaliacao
from ITEM_COMPRA IC

inner join CLIENTE CLI on IC.Compra_Id = CLI.Id_Cliente
inner join LIVRO L on IC.Livro_Id = L.Id_Livro
inner join AVALIACAO A on IC.Avaliacao_Id = A.Id_Avaliacao;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- livros em estoque com quantidade

select
E.Quantidade_Estoque,
L.Titulo_Livro
from ESTOQUE E

inner join LIVRO L on E.Livro_Id = L.Id_Livro;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- compras com livros e avaliações (enclusive se ainda nao houver avaliaçao)

select
IC.Id_Item_Compra,
L.Titulo_Livro,
A.Descricao_Avaliacao,
A.Estrelas_Avaliacao
from ITEM_COMPRA IC

inner join LIVRO L on IC.Livro_Id = L.Id_Livro
left join AVALIACAO A on IC.Avaliacao_Id = A.Id_Avaliacao;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Clientes com seus endereços e telefones

select 
E.Id_Endereco,
E.Logradouro_Endereco,
C.Nome_Cliente,
T.Numero_Telefone
from ENDERECO E 

left join CLIENTE C on E.Cliente_Id = C.Id_Cliente
left join TELEFONE T on E.Cliente_Id = T.Id_Telefone;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Total de livros vendidos por título


select
L.Titulo_Livro,

sum(IC.Quantidade_Item_Compra) as 'Total_Livros_Vendidos'

From ITEM_COMPRA IC 

inner join LIVRO L on IC.Livro_Id = L.Id_Livro
group by L.Id_Livro;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Valor total das compras por cliente

select
IC.Quantidade_Item_Compra * IC.Preco_Unitario as total_compra_cliente,
CLI.Nome_Cliente
from ITEM_COMPRA IC

inner join COMPRA C on IC.Compra_Id = C.Id_Compra
inner join CLIENTE CLI on C.Cliente_Id = CLI.Id_Cliente;


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Livros que ainda não possuem avaliações

select
IC.Id_Item_Compra,
L.Titulo_Livro,
A.Estrelas_Avaliacao 
from ITEM_COMPRA IC

inner join LIVRO L on IC.Livro_Id = L.Id_Livro
left join AVALIACAO A on IC.Avaliacao_Id = A.Id_Avaliacao
where A.Estrelas_Avaliacao is null;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Clientes que ainda não realizaram compras

select
CLI.Nome_Cliente,
C.Cliente_Id
from COMPRA C

left join CLIENTE CLI on C.Cliente_Id = CLI.Id_Cliente
where - C.Cliente_Id;
# fazer depois socorro
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Livros com estoque zerado

select 
E.Quantidade_Estoque,
L.Titulo_Livro
from ESTOQUE E

inner join LIVRO L on E.Livro_Id = L.Id_Livro
where E.Quantidade_Estoque = '0';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --
-- Autores com quantidade de livros escritos

select
A.Nome_Autor,
LA.Livro_Id, count(LA.Livro_Id) as Quantidade_Livros_Escritos  
from LIVRO_AUTOR LA

inner join AUTOR A on LA.Autor_Id = A.Id_Autor
inner join LIVRO L on LA.Livro_Id = L.Id_Livro
group by A.Nome_Autor, LA.Livro_Id;



-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- - - --

-- Livros com mais de um autor

-- Top 5 livros mais vendidos

-- Clientes com maior gasto total

-- Vendas realizadas em um período (ex: março de 2024)

-- Total de vendas por mês

-- Listar os livros e suas editoras e tipos (com join completo)

--  Média de estrelas por livro avaliado

-- Clientes e seus telefones (um para muitos)

-- Quantidade total de livros por gênero

-- Total gasto por cliente

-- Livros sem avaliação ainda

select
IC.Id_Item_Compra,
L.Titulo_Livro,
A.Estrelas_Avaliacao 
from ITEM_COMPRA IC

inner join LIVRO L on IC.Livro_Id = L.Id_Livro
left join AVALIACAO A on IC.Avaliacao_Id = A.Id_Avaliacao
where A.Estrelas_Avaliacao = null;


-- Autores com seus respectivos livros

select
A.Nome_Autor,
L.Titulo_Livro
from LIVRO_AUTOR LA

inner join AUTOR A on LA.Autor_Id = A.Id_Autor
inner join LIVRO L on LA.Livro_Id = L.Id_Livro;



