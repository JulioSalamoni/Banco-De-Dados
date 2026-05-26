CREATE DATABASE IF NOT EXISTS livrariawa;
USE livrariawa;

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

--
select * from Livro;

# listar todos os livros com autor, editora e tipo do livro

select LIVRO.Titulo_Livro, LIVRO_AUTOR.*, AUTOR.Nome_Autor, EDITORA.Nome_Editora , TIPO_LIVRO.Descricao_Tipo_Livro from LIVRO
left join LIVRO_AUTOR on LIVRO.Id_Livro
left join AUTOR on LIVRO_AUTOR.Id_Livro_Autor
left join EDITORA on AUTOR.Id_Autor
left join TIPO_LIVRO on Editora.Id_Editora;

 