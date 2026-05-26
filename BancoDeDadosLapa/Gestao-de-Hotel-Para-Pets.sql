drop database Hotel_Pets;
create database Hotel_Pets;
use Hotel_Pets;


-- TABELAS

create table CLIENTE(
Id_Cliente int primary key auto_Increment,
Nome_Cliente varchar(100),
Numero_Cliente varchar(20),
Email_Cliente varchar(100)
);


create table PORTE_PET(
Id_Porte_Pet int primary key auto_Increment,
Descricao_Porte_Pet varchar(15)
);


create table VACINAS(
Id_Vacinas int primary key auto_increment,
Descricao_Vacinas varchar(50));


create table PET(
Id_Pet int primary key auto_increment,
Nome_Pet varchar(100),
Especie_Pet varchar(100),
Porte_Pet_Id int,
Cliente_Id int,
foreign key (Porte_Pet_Id) references PORTE_PET(Id_Porte_Pet),
foreign key (Cliente_id) references CLIENTE(Id_Cliente)
);


create table CARTEIRA_VACINA_PET(
Id_Carteira_Vacina_Pet int primary key auto_increment,
Status_Carteira_Vacina_Pet tinyint,
Vacinas_Id int,
Pet_Id int,
foreign key (Vacinas_Id) references VACINAS(Id_Vacinas),
foreign key (Pet_Id) references PET(Id_Pet)
);


create table FUNCAO_FUNCIONARIO(
Id_Funcao_Funcionario int primary key auto_increment,
Descricao_Funcao_Funcionario varchar(100)
);


create table FUNCIONARIO(
Id_Funcionario int primary key auto_increment,
Nome_Funcionario varchar(100),
Numero_Funcionario varchar(20),
Email_Funcionario varchar(100),
Funcao_Funcionario_Id int,
foreign key (Funcao_Funcionario_Id) references FUNCAO_FUNCIONARIO(Id_Funcao_Funcionario)
);


create table ESCALAS_FUNCIONARIOS(
Id_Escalas_Funcionario int primary key auto_increment,
Funcionario_Id int,
Disponibilidade tinyint,
foreign key (Funcionario_Id) references FUNCIONARIO(Id_Funcionario)
);

create table QUARTOS(
Id_Quartos int primary key auto_increment,
Descricao_Quartos varchar(100),
Preco_Unitario_Quartos decimal(10,2),
Disponibilidade_Quartos tinyint
);


create table BANHO(
Id_Banho int primary key auto_increment,
Descricao_Banho varchar(100),
Preco_Unitario_Banho decimal(10,2)
);


create TABLE BRINCADEIRAS(
Id_Brincadeiras int primary key auto_increment,
Descricao_Brincadeiras varchar(100),
Preco_Unitario_Brincadeiras decimal(10,2)
);


create table ALIMENTACAO(
Id_Alimentacao int primary key auto_increment,
Descricao_Alimentacao varchar(100),
Preco_Unitario_Alimentacao decimal(10,2)
);


create table CONSULTAS(
Id_Consultas int primary key auto_Increment,
Descricao_Consultas varchar(100),
Preco_Unitario_Consultas decimal(10,2)
);


create table SERVICOS_HOSPEDAGEM(
Id_Servicos_Hospedagem int primary key auto_increment,
Quartos_Id int not null,
Banho_Id int,
Brincadeiras_id int,
Alimentacao_Id int not null,
Consultas_Id int,
foreign key (Quartos_Id) references QUARTOS(Id_Quartos),
foreign key (Banho_Id) references BANHO(Id_Banho),
foreign key (Brincadeiras_Id) references BRINCADEIRAS(Id_Brincadeiras),
foreign key (Alimentacao_Id) references ALIMENTACAO(Id_Alimentacao),
foreign key (Consultas_Id) references CONSULTAS(Id_Consultas)
);


create table RESERVA(
Id_Reserva int primary key auto_increment,
Data_Entrada_Reserva datetime,
Data_Saída_Reserva datetime,
Status_Reserva tinyint,
Cliente_Id int,
Pet_Id int,
foreign key (Cliente_Id) references CLIENTE(Id_Cliente),
foreign key (Pet_Id) references PET(Id_Pet)
);


create table HOSPEDAGEM(
Id_Hospedagem int primary key auto_increment,
Reserva_Id int,
Preco_Total_Hospedagem varchar(100),
Servicos_Hospedagem_Id int,
foreign key (Reserva_Id) references RESERVA(Id_Reserva),
foreign key (Servicos_Hospedagem_Id) references SERVICOS_HOSPEDAGEM(Id_Servicos_Hospedagem)
);


create table FORMA_DE_PAGAMENTO(
Id_Forma_De_Pagamento int primary key auto_increment,
Descricao_Forma_De_Pagamento varchar(50)
);


create table PAGAMENTO(
Id_Pagamento int primary key auto_increment,
Preco_Final varchar(100),
Forma_De_Pagamento_Id int,
Hospedagem_Id int,
foreign key (Forma_De_Pagamento_Id) references FORMA_DE_PAGAMENTO(Id_Forma_De_Pagamento),
foreign key (Hospedagem_Id) references HOSPEDAGEM(Id_Hospedagem)
);


create table SERVICO_LIMPEZA(
Id_Servico_Limpeza int primary key auto_increment,
Status_Servico_Limpeza tinyint,
Quartos_Id int,
Funcionario_Id int,
foreign key (Quartos_Id) references QUARTOS(Id_Quartos),
foreign key (Funcionario_Id) references FUNCIONARIO(Id_Funcionario)
);


create table SERVICO_TOSADOR(
Id_Servico_Tosador int primary key auto_increment,
Status_Servico_Tosador tinyint,
Banho_Id int,
Funcionario_Id int,
foreign key (Banho_Id) references BANHO(Id_Banho),
foreign key (Funcionario_Id) references FUNCIONARIO(Id_Funcionario)
);


create table SERVICO_CUIDADOR(
Id_Servico_Cuidador int primary key auto_increment,
Status_Servico_Cuidador tinyint,
Alimentacao_Id int,
Brincadeiras_Id int,
Funcionario_Id int,
foreign key (Alimentacao_Id) references ALIMENTACAO(Id_Alimentacao),
foreign key (Brincadeiras_Id) references BRINCADEIRAS(Id_Brincadeiras),
foreign key (Funcionario_Id) references FUNCIONARIO(Id_Funcionario)
);


create table SERVICO_VETERINARIO(
Id_Servico_Veterinario int primary key auto_increment,
Status_Servico_Veterinario tinyint,
Consultas_Id int,
Funcionario_Id int,
foreign key (Consultas_Id) references CONSULTAS(Id_Consultas),
foreign key (Funcionario_Id) references FUNCIONARIO(Id_Funcionario)
);


create table AVALIACAO(
Id_Avaliacao int primary key auto_increment,
Nota_Avaliacao int check (Nota_Avaliacao between 1 and 5),
Descricao_Avaliacao TEXT,
Reserva_Id int,
foreign key (Reserva_Id) references RESERVA(Id_Reserva)
);


create table LOG_HOSPEDAGEM(
Id_Log_Hospedagem int primary key auto_increment,
Data_Hospedagem datetime,
data_Log_Hospedagem datetime,
Hospedagem_Id int,
Pet_Id int,
Cliente_Id int,
foreign key (Hospedagem_Id) references HOSPEDAGEM(Id_Hospedagem));


create table LOG_CLIENTE(
Id_Log_Cliente int primary key auto_increment,
Data_Log_Cliente datetime,
Cliente_Id int,
Nome_Log_Cliente varchar(100),
Email_Log_Cliente varchar(100),
Numero_Log_Cliente varchar(20),
foreign key (Cliente_Id) references CLIENTE(Id_Cliente));


create table LOG_PET(
Id_Log_Pet int primary key auto_increment,
Data_Log_Pet datetime,
Pet_Id int,
Nome_Log_Pet varchar(100),
Especie_Log_Pet varchar(100),
Porte_Pet_Id int,
Cliente_Id int,
foreign key (Pet_Id) references PET(Id_Pet),
foreign key (Porte_Pet_Id) references PORTE_Pet(Id_Porte_Pet),
foreign key (Cliente_Id) references CLIENTE(Id_Cliente));


-- INSERTS

#insert into CLIENTE(Nome_Cliente, Numero_Cliente, Email_Cliente) values(
#('Pedro Souza', '(31)955551234', 'pedro.souza@email.com'),
#('Ana Paula Santos', '(41)998887766', 'ana.paula@email.com'),
#('Carlos Rodrigues', '(51)977772233', 'carlos.rodrigues@email.com'),
#('Fernanda Costa', '(19)911112222', 'fernanda.costa@email.com'),
#('Juliana Martins', '(85)922221111', 'juliana.martins@email.com'),
#('Lucas Gomes', '(47)900001234', 'lucas.gomes@email.com'),
#('Patrícia Carvalho', '(22)987659876', 'patricia.carvalho@email.com'),
#('Marcelo Pires', '(92)912123434', 'marcelo.pires@email.com'),

insert into PORTE_PET(Descricao_Porte_Pet) values(
'Pequeno'),
('Medio'),
('Grande');

insert into VACINAS(Descricao_Vacinas) values(
'Vacina Óctupla'),
('Vacina Anti Rábica'),
('Vacina Quintupla');

insert into FUNCAO_FUNCIONARIO(Descricao_Funcao_Funcionario) values(
'Faxineiro'),
('Tosador'),
('Cuidador'),
('Veterinário');

insert into QUARTOS(Descricao_Quartos, Preco_Unitario_Quartos, Disponibilidade_Quartos) values
('Quarto Pequeno Básico', 80.00, 1),
('Quarto Medio Básico', 100.00, 1),
('Quarto Grande Básico',120.00, 1),
('Quarto Pequeno Luxo',120.00, 1),
('Quarto Medio Luxo',150.00, 1),
('Quarto Grande Luxo', 180.00, 1);

insert into BANHO(Descricao_Banho, Preco_Unitario_Banho) values
('Banho Simples', 30.00),
('Banho e Tosa',70.00),
('Banho Terapêutico',80.00),
('Banho De Hidratação',60.00);

insert into BRINCADEIRAS(Descricao_Brincadeiras, Preco_Unitario_Brincadeiras) values
('Brincadeiras com Bola', 10.00),
('Passeios e Caminhadas', 30.00),
('Atividades Aquaticas', 50.00),
('Brincadeiras com Obstáculos', 30.00),
('Brincadeiras com Brinquedos', 15.00);

insert into ALIMENTACAO(Descricao_Alimentacao, Preco_Unitario_Alimentacao) values
('Raçao Seca', 20.00),
('Raçao Úmida',24.00),
('Alimentos Frescos',30.00),
('Dietas Naturais',40.00);

insert into CONSULTAS(Descricao_Consultas, Preco_Unitario_Consultas) values
('Aplicaçao de Vacina',40.00),
('Tratamento Odontologico',40.00),
('Acompanhamento Fisioterápico',40.00);

insert into FUNCIONARIO (Nome_Funcionario, Numero_Funcionario, Email_Funcionario, Funcao_Funcionario_Id) values
('João Silva', '(11)987654321', 'joao.silva@email.com', 1),
('Maria Oliveira', '(21)912345678', 'maria.oliver@email.com', 1),
('Felipe Dantas', '(11)987651234', 'felipe.dantas@email.com', 1),
('Mariana Lima', '(21)912345678', 'mariana.lima@email.com', 2),
('Camila Ribeiro', '(41)998882345', 'camila.ribeiro@email.com', 2),
('Rodrigo Alves', '(51)977776789', 'rodrigo.alves@email.com', 2),
('Thiago Mendes', '(31)955559876', 'thiago.mendes@email.com', 3),
('Daniela Nogueira', '(18)934345656', 'daniela.nogueira@email.com', 3),
('Ricardo Almeida', '(61)933334444', 'ricardo.almeida@email.com', 3),
('Beatriz Lima', '(71)966665555', 'beatriz.lima@email.com', 4),
('Guilherme Pereira', '(81)999990000', 'guilherme.pereira@email.com', 4),
('Sandra Ramos', '(67)956567878', 'sandra.ramos@email.com', 4);

insert into Forma_de_Pagamento(Descricao_Forma_De_Pagamento) values(
'Cartão Debito'),
('Cartão Crédito'),
('Pix'),
('Dinheiro');


-- triggers -----------------------------------------------------------------------------------------------

delimiter $$
create trigger tr_Servicos_Requeridos_Criar_Tarefas
after insert on SERVICOS_HOSPEDAGEM
for each row
begin
if new.Quartos_Id is not null then
insert into SERVICO_LIMPEZA (Status_Servico_Limpeza, Quartos_Id, Funcionario_Id)
values (0, new.Quartos_Id, null);
end if;

if new.Banho_Id is not null then
insert into SERVICO_TOSADOR (Status_Servico_Tosador, Banho_Id, Funcionario_Id)
values (0, new.Banho_Id, null);
end if;

if new.Brincadeiras_Id is not null or new.Alimentacao_Id is not null then
insert into SERVICO_CUIDADOR (Status_Servico_Cuidador, Alimentacao_Id, Brincadeiras_Id, Funcionario_Id)
values (0, new.Alimentacao_Id, new.Brincadeiras_Id, null);
end if;

if new.Consultas_Id is not null then
insert into SERVICO_VETERINARIO (Status_Servico_Veterinario, Consultas_Id, Funcionario_Id)
values (0, new.Consultas_Id, null);
end if;
end $$
delimiter ;

-- -------------------

delimiter $$
create trigger tr_log_cliente
after insert on CLIENTE
for each row
begin
insert into Log_Cliente(
Data_Log_Cliente, Cliente_Id, Nome_Log_Cliente, Email_Log_Cliente, Numero_Log_Cliente
)
values(
now(), new.Id_Cliente, new.Nome_Cliente, new.Email_Cliente, new.Numero_Cliente);
end $$
delimiter ;


delimiter $$
create trigger tr_log_pet
after insert on pet
for each row
begin
insert into Log_Pet(
Data_Log_Pet, Pet_Id, Nome_Log_Pet, Especie_Log_Pet, Porte_Pet_Id, Cliente_Id
)
values(
now(), new.Id_Pet, new.Nome_Pet, new.Especie_Pet, new.Porte_Pet_Id, new.Cliente_Id);
end $$
delimiter ;


-- para quando a reserva for inserida, aplicar os funcionarios aos serviços requiridos
-- para colocar os preços totais em uma tabela de faturamento
-- para para permitir a reserva somente com a carteira de vacina valida


-- ----------------------------------------------------------------------------------------------------------------------
-- PROCEDURES

delimiter $$
create procedure sp_cadastro (
 in Nome varchar(100),
 in Numero varchar(20),
 in Email varchar(100),
 in Pet varchar(100),
 in Especie varchar(100),
 in Porte int)

begin
 declare p_id_usuario int;
insert into CLIENTE(Nome_Cliente, Numero_Cliente, Email_Cliente) values
(Nome, Numero, Email);
set p_id_usuario = last_insert_id();
insert into PET(Nome_Pet, Especie_Pet, Porte_Pet_Id, Cliente_Id) values
(Pet, Especie, Porte, p_id_usuario);

end $$
delimiter ;
 



-- --------------------------------------------

delimiter $$
create procedure sp_cadastro_cliente (
in Nome_C varchar(100),
in Numero_C varchar(20),
in Email_C varchar(100))
begin
insert into CLIENTE(Nome_Cliente, Numero_Cliente, Email_Cliente) values
(Nome_C, Numero_C, Email_C);
end $$
delimiter ;



-- ---------------------------------------------

delimiter $$
create procedure sp_cadastro_pet (in Nome_P varchar(100),
 in Especie_P varchar(100),
 in Porte_P int,
 in Id_Usuario_P int)
begin
insert into PET(Nome_Pet, Especie_Pet, Porte_Pet_Id, Cliente_Id)
values (Nome_P, Especie_P, Porte_P, Id_Usuario_P);
end $$
delimiter ;



-- -------------------------------------------------

delimiter $$
create procedure sp_calcular_e_atualizar_preco_total_hospedagem(
in p_Id_Hospedagem int,
in p_Preço_Adicional decimal (10,2)

)
begin
declare v_Preco_Quarto DECIMAL(10,2);
declare v_Preco_Banho DECIMAL(10,2);
declare v_Preco_Brincadeiras DECIMAL(10,2);
declare v_Preco_Alimentacao DECIMAL(10,2);
declare v_Preco_Consultas DECIMAL(10,2);
declare v_Preco_Total DECIMAL(10,2);

set v_Preco_Quarto = 0.00;
set v_Preco_Banho = 0.00;
set v_Preco_Brincadeiras = 0.00;
set v_Preco_Alimentacao = 0.00;
set v_Preco_Consultas = 0.00;

select
coalesce(Q.Preco_Unitario_Quartos, 0),
coalesce(B.Preco_Unitario_Banho, 0),
coalesce(BR.Preco_Unitario_Brincadeiras, 0),
coalesce(A.Preco_Unitario_Alimentacao, 0),
coalesce(C.Preco_Unitario_Consultas, 0)
into
v_Preco_Quarto,
v_Preco_Banho,
v_Preco_Brincadeiras,
v_Preco_Alimentacao,
v_Preco_Consultas
from HOSPEDAGEM H
join SERVICOS_HOSPEDAGEM SH on H.Servicos_Hospedagem_Id = SH.Id_Servicos_Hospedagem
left join QUARTOS Q on SH.Quartos_Id = Q.Id_Quartos
left join BANHO B on SH.Banho_Id = B.Id_Banho
left join BRINCADEIRAS BR on SH.Brincadeiras_Id = BR.Id_Brincadeiras
left join ALIMENTACAO A on SH.Alimentacao_Id = A.Id_Alimentacao
left join CONSULTAS C on SH.Consultas_Id = C.Id_Consultas
where H.Id_Hospedagem = p_Id_Hospedagem;

set v_Preco_Total = v_Preco_Quarto + v_Preco_Banho + v_Preco_Brincadeiras + v_Preco_Alimentacao + v_Preco_Consultas + p_Preco_Adicional;

update HOSPEDAGEM
set Preco_Total_Hospedagem = v_Preco_Total
where Id_Hospedagem = p_Id_Hospedagem;
end $$
delimiter ;

-- ------------------------------------------------------

delimiter $$
create procedure sp_criar_reserva_hospedagem(
in p_Data_Entrada_Reserva datetime,
in p_Data_Saida_Reserva datetime,
in p_Cliente_Id int,
in p_Pet_Id int,
in p_Quartos_Id int,
in p_Banho_Id int,
in p_Brincadeiras_Id int,
in p_Alimentacao_Id int,
in p_Consultas_Id int)
begin
declare v_Disponibilidade_Quarto tinyint;
declare v_Id_Reserva int;
declare v_Id_Servicos_Hospedagem int;
declare v_Id_Hospedagem int;
start transaction;

select Disponibilidade_Quartos into v_Disponibilidade_Quarto
from QUARTOS
where Id_Quartos = p_Quartos_Id
for update;

IF v_Disponibilidade_Quarto = 1 then

insert into RESERVA (Data_Entrada_Reserva, Data_Saída_Reserva, Status_Reserva, Cliente_Id, Pet_Id)
values (p_Data_Entrada_Reserva, p_Data_Saida_Reserva, 1, p_Cliente_Id, p_Pet_Id);
set v_Id_Reserva = LAST_INSERT_ID();
        
insert into SERVICOS_HOSPEDAGEM (Quartos_Id, Banho_Id, Brincadeiras_Id, Alimentacao_Id, Consultas_Id)
values (p_Quartos_Id, p_Banho_Id, p_Brincadeiras_Id, p_Alimentacao_Id, p_Consultas_Id);
set v_Id_Servicos_Hospedagem = LAST_INSERT_ID();

insert into HOSPEDAGEM (Reserva_Id, Servicos_Hospedagem_Id)
values (v_Id_Reserva, v_Id_Servicos_Hospedagem);
set v_Id_Hospedagem = LAST_INSERT_ID();

update QUARTOS
set Disponibilidade_Quartos = 0
where Id_Quartos = p_Quartos_Id;
end if;
end $$
delimiter ;



#call sp_cadastro (nome, numero, email, nome do pet, especie, porte);
call sp_cadastro ('Julio', '11-99999999', 'julio@jmail.com', 'Milk', 'Gato', 2);
call sp_cadastro ('Laura', '11-999234999', 'Laura@Lmail.com', 'Olivia', 'Gato', 2);
call sp_cadastro_cliente ('Gabriel Barbosa', '11-934823954', 'Gabriel@gmail.com');
call sp_cadastro_pet ('LuLu', 'Cachorro Caramelo', 2, 3);
call sp_cadastro_cliente ('Larissa Szakacs', '11-936653942', 'Larissa@lmail.com');
call sp_cadastro_pet ('Preta', 'Cachorro', 3, 4);


# call sp_criar_reserva_hospedagem ('data','data saida', cliente, pet, quarto, banho, brincadeiras, alimentaçao, consulta);
call sp_criar_reserva_hospedagem ('2025-10-10 10:00:00','2025-10-15 16:00:00', 1, 1, 1, 3, 1, 1, 2);
call sp_criar_reserva_hospedagem ('2025-10-11 10:30:00','2025-10-16 16:00:00', 2, 2, 2, 1, 2, 2, 3);
call sp_criar_reserva_hospedagem ('2025-10-12 09:00:00','2025-10-17 16:00:00', 3, 3, 3, 2, 3, 4, null);
call sp_criar_reserva_hospedagem ('2025-10-12 11:00:00','2025-10-17 16:00:00', 4, 4, 5, 1, 3, 2, 1);


#call sp_calcular_e_atualizar_preco_total_hospedagem(id hospedagem, preço adicional);
call sp_calcular_e_atualizar_preco_total_hospedagem(1, 10.00);
call sp_calcular_e_atualizar_preco_total_hospedagem(2, 4.00);
call sp_calcular_e_atualizar_preco_total_hospedagem(3, 0.00);
call sp_calcular_e_atualizar_preco_total_hospedagem(4, 15.00);



-- para fazer o pagamento
-- para os funcionarios marcarem o serviço como concluído








