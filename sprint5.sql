create database comex;

create table categorias (
id bigint auto_increment primary key,
nome varchar (100)
);

create table produtos (
id bigint auto_increment primary key,
nome varchar (225),
preco decimal (10,2),
categoria_id bigint, foreign key (categoria_id) references categorias (id));

create table clientes(
id bigint auto_increment primary key,
nome varchar (225));

create table pedidos (
id bigint auto_increment primary key,
data datetime,
cliente_id bigint,
foreign key (cliente_id) references clientes (id));

create table item_pedido (
id bigint auto_increment primary key,
pedido_id bigint,
foreign key (pedido_id) references pedidos(id),
produto_id bigint,
foreign key (produto_id) references produtos (id),
preco_unitario decimal (10,2),
quantidade integer);

insert into clientes(
nome
) values ("ana"), ("Eli"), ("Dani"), ("Gabi"), ("bia"), ("Dani"), ("Caio");

insert into categorias(
nome
) values ("info"), ("moveis"), ("livros"), ("celulares"), ("automotiva");

insert into produtos(
nome,
preco,
categoria_id
) values ('NOTEBOOK SAMSUNG', 3536.00,1),
('SOFÁ 3 LUGARES',2500.00,2), 
('CLEAN ARCHITETURE', 102.90,3), 
('MESA DE JANTAR 6 LUGARES', 3678.98,3),
('IPHONE 13 PRO',9176.00,4),
('MONITOR DELL 27',1889.00,1),
('IMPLEMENTING DOMAIN-DRIVER DESING',144.07,3),
('JOGO DE PNEUS', 1276.79,5),
('CLEAN CODE',95.17,3),
('GALAXY S22 ULTRA',8549.10,4),
('MACBOOK PRO 16',31752.00,1),
('Refactoring Improving the Design of Existing Code',173.90,3),
('CAMA QUEEN SIZE',3100.00,2),
('CENTRAL MULTIMIDIA',711.18,5),
('BUILDING MICROSERVICE',300.28,3),
('GALAXY TAB S8',5939.10,1);

insert into pedidos(
data,
cliente_id) values ('2022-01-01',1),('2022-01-05',1),('2022-01-08',2),('2022-01-13',1),('2022-01-04',1),('2022-01-04',6),('2022-01-10',4),('2022-01-15',5),('2022-01-09',5),
('2022-01-14',6),('2022-01-03',7),('2022-01-12',6),('2022-01-07',6),('2022-01-16',7),('2022-01-11',7),('2022-01-02',5);



insert into item_pedido(
pedido_id,
produto_id,
preco_unitario,
quantidade
) values (17, 1, 3523.00, 1),
 (18,2,2500.00,1),
 (19,3,102.90,2),
 (20,4,3678.98,1),
 (21,5,9176.00,6),
 (22,6,1889.00,3),
 (23,7,144.07,3),
 (24,8,1276.79,1),
 (25,9,95.17,1),
 (26,10,8549.10,5),
 (27,11,31752.00,1),
 (23,12,173.90,1),
 (24,13,3100.00,2),
 (25,14,711.18,1),
 (26, 15, 300.28,2),
 (27,16,5949.10,4);
 
 #3
select * from categorias inner join produtos on categorias.id = produtos.id;

#4
select clientes.nome as cliente, categorias.nome as categorias, produtos.nome as produtos, item_pedido.preco_unitario as preco_unitario, item_pedido.quantidade as quantidade, pedidos.data as data
from categorias inner join produtos on categorias.id = produtos.categoria_id 
inner join item_pedido on produtos.id = item_pedido.produto_id
inner join pedidos on item_pedido.pedido_id = pedidos.id
inner join clientes on pedidos.cliente_id = clientes.id order by cliente;

#5
select categorias.nome as nome, 
sum(item_pedido.preco_unitario * item_pedido.quantidade) as total
from categorias
inner join produtos on categorias.id = produtos.categoria_id
inner join item_pedido on produtos.id = item_pedido.produto_id
group by categorias.id, categorias.nome;

#6
select
count(distinct pedidos.id) as quantidade,
sum(item_pedido.quantidade) as qauntidadeVendidas,
min(item_pedido.preco_unitario * item_pedido.quantidade) as ValoePedidoMaisBarato,
max(item_pedido.preco_unitario * item_pedido.quantidade) as ValorMaisCaro,

sum(item_pedido.preco_unitario * item_pedido.quantidade) as MontanteVendido
from
pedidos
inner join item_pedido on pedidos.id = item_pedido.pedido_id; 

#7
select
clientes.nome as nome,
count(pedidos.id) as quantidade 
from clientes 
left join pedidos on clientes.id = pedidos.cliente_id
group by clientes.id, clientes.nome;