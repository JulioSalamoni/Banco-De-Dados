# drop database sistema_vendas;
create database sistema_vendas;
use sistema_vendas;

create table PRODUTO(
	Id_Produto int auto_increment primary key,
    Nome_Produto varchar(100),
    Preco_Produto decimal(10,2),
    Estoque_Produto int
);

create table VENDA(
	Id_Venda int auto_increment primary key,
    Quantidade_Venda int,
    Data_Venda datetime default now(),
    Produto_Id int,
    foreign key (Produto_Id) references PRODUTO(Id_Produto)
);

insert into PRODUTO(Nome_Produto,Preco_Produto,Estoque_Produto) values 
('Notebook lenovo', 3500.00, 10),
('Mouse Gamer logitech', 150.00, 30),
('Monitor LG 25"', 899.99,15),
('Headset HyperX', 299.45, 25);


create table LOG_VENDA(
	Id_Log_Venda int auto_increment primary key,
    Quantidade_Log_Venda int,
    Data_Venda datetime,
    Data_Log_Venda datetime,
    Venda_Id int,
    Produto_Id int
);

create table ESTOQUE_HISTORICO(
	Id_Estoque_Historico int auto_increment primary key,
    Antigo_Estoque_Historico int,
    Novo_Estoque_Historico int,
    Data_Estoque_Historico datetime default now(),
    Produto_Id int
);

select * from PRODUTO;

select * from VENDA;

describe VENDA;

insert INTO VENDA (Quantidade_Venda,Produto_Id) VALUES (2,1);

delimiter $$

create trigger tr_atualiza_estoque
after insert on VENDA
for each row
begin 
	update PRODUTO 
	set  Estoque_Produto =  Estoque_Produto - new.Quantidade_Venda
	where Id_Produto = new.Produto_Id;
end $$

delimiter ;


select * from PRODUTO;
insert INTO VENDA (Quantidade_Venda,Produto_Id) VALUES (5,2);


#drop trigger tr_valida_estoque;
delimiter $$
create trigger tr_valida_estoque
before insert on VENDA
for each row 
begin
	declare estoque_atual int;
	select Estoque_Produto into estoque_atual from PRODUTO where Id_Produto = new.Produto_Id;

	if estoque_atual < new.Quantidade_Venda then
    signal sqlstate '45000'
    set message_text = 'estoque insuficiente para a venda.';
    end if;
end $$
delimiter ;

# drop trigger tr_repor_estoque;

-- tr_repor_estoque
delimiter $$

create trigger tr_repor_estoque
after delete on VENDA
for each row
begin
    update PRODUTO
    set Estoque_Produto = Estoque_Produto + old.Quantidade_Venda 
    where Id_Produto = old.Produto_Id;
    
end $$

delimiter ;




#tr_historico_estoque
#tr_log_venda

delimiter $$
create trigger tr_historico_estoque
after update on PRODUTO 
for each row
begin
	if new.Estoque_Produto <> old.Estoque_Produto then
	insert into ESTOQUE_HISTORICO(
Antigo_Estoque_Historico,
Novo_Estoque_Historico,
Data_Estoque_Historico,
Produto_Id)
	values(
old.Estoque_Produto,
new.Estoque_Produto,
now(),
old.Id_Produto);
end if;
end $$
delimiter ;

-- aekraiu

delimiter $$
create trigger tr_log_venda
after insert on VENDA
for each row
begin
	insert into LOG_VENDA(
 Quantidade_Log_Venda,
 Data_Venda,
 Data_Log_Venda,
 Venda_Id,
 Produto_Id)
	values(
new.Quantidade_Venda,
new.Data_Venda,
now(),
new.Id_Venda,
new.Produto_Id);
end $$
delimiter ;

insert INTO VENDA (Quantidade_Venda,Produto_Id) VALUES (6,3);