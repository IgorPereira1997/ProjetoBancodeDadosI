INSERT INTO 
	clientes 
VALUES
	(000, 'fulano@gmail.com', 'Fulano1987', '987654', 'Fulano da Silva', 1, '11122233344'),
	(010, 'Cicrano@gmail.com', 'Cicrano30', '654987', 'Cicrano Berreira', 3, '99988877744'),
	(020, 'Beltrano@gmail.com', 'Beltran_2', '321654', 'Beltrano Fontes',5, '66655544411');

INSERT INTO 
	fornecedores 
VALUES
	(1000, 'FornecedoraMaringa@gmail.com', 'Maringa89', '123456', 'Fornecedora Maringa', 0, '11122233344455'),
	(2000, 'FornecedoraUnica@gmail.com', 'Unica_@', '654321', 'Forncecedora Unica', 2, '99988877744455'),
	(3000, 'FornecedoraSãoFrancisco@gmail.com', 'SãoFrancisco', '555888', 'Fornecedora São Francisco', 4, '44455566611122');

INSERT INTO 
	endereco(endereco_id, cep, logradouro, numero, complemento, bairro, cidade, estado) 
VALUES
	(0, '56304-205', 'Av. José de Sá Maniçoba', -1, 'Comercial', 'Maria Auxiliadora', 'Petrolina', 'PE'),
	(1, '48902-300', 'Av. Antônio C. Magalhães', 510, 'Comercial', 'Country Club', 'Juazeiro', 'BA'),
	(2, '56000-000', 'R. Antônio Figueira Sampaio', 134, 'Comercial', 'Nossa Sra. de Graças', 'Salgueiro', 'PE'),
	(3, '64770-000', 'Rua João F. dos Santos', -1, 'Comercial', 'Campestre', 'São Raimundo Nonato', 'PI'),
	(4, '48605-560', 'Rua da Aurora', -1, 'Comercial', 'General Dutra', 'Paulo Afonso', 'BA'),
	(5, '71225-510', 'STRC Trecho 3', -1, 'Comercial', 'Guará', 'Brasília', 'DF'),
	(6, '05323-002', 'Av. Presidente Altino', 1079, 'Comercial', 'Jaguaré' ,'São Paulo', 'SP'),
	(7, '89275-000', 'Rua Marechal Castelo Branco', 661, 'Comercial','Schroeder', 'Santa Catarina', 'SC'),
	(8, '77023-120', 'Q. 812 Sul Alameda 5, Lote 13', -1 , 'Comercial','Plano Diretor Sul', 'Palmas', 'TO');

INSERT INTO 
	pedidos_status
VALUES
	(0, 'Aguardando Pagamento'),
	(1, 'Pagamento Efetuado'),
	(2, 'Cancelado'),
	(3, 'Saiu para Entrega'),
	(4, 'Aguardando Envio'),
	(5, 'Entregue');

INSERT INTO 
	transportadoras 
VALUES
	(10000, 1000 ,'11122233344455', '44477755583434', 'Entregadora Saltimbanco', '74888555999', 2),
	(20000, 3000,'44455566611122','66633322255657', 'Entregadora Auxiliadora', '74555666222', 4),
	(30000, 2000,'99988877744455','99966633322677', 'Entregadora Dom Bosco', '74111666555', 6);

INSERT INTO 
	produtos
VALUES
	(1,	'Biscottis', 'All-natural bite-sized biscuits.','7891518238009', '15', 10.00, 20.00,100, 1000 ,'11122233344455'),
	(2,	'Organic Earl Grey','Because once in a blue moon you might want something besides coffee. This blend of black and green teas is highly aromatic, rich and flavorful with a hint of light citrus.', '7891518237988',8,6.00,9.00,1000,1000,'11122233344455'),
	(3,	'Sugar','How many spoonfuls do you need? Crystallized from 100% organic sugar cane, and milled within 24 hours of harvest to ensure its as fresh as our coffee beans.','789151823797',	8,1.00,3.00,500,1000 ,'11122233344455'),
	(4,	'Non-Diary Creamer', 'If running out of milk or cream for your coffee is tantamount to a state of emergency, we suggest you stock up on these delicious non-dairy creamers just in case.','789151823796',5,2.00,3.00,500, 3000,'44455566611122'),
	(5,	'Steel Mug', 'Here is one way to make sure your coffee stays warm during a long commute. Made of lightweight metal alloy.',	'789151823795',	15,	15.00,21.00,300, 3000,'44455566611122'),
	(6,	'Ceramic Mug', 'Handcrafted by Colorado artisans. These generous mugs feature an opaque green satin glaze over classic stoneware.',	'789151823799',15,10.00,14.00,80, 3000,'44455566611122'),
	(7,	'Plastic Mug','If you are a little klutzy in the morning, we recommend this shatter-proof, durable plastic commuter mug.','789151823795',8,5.00,7.00,750, 2000,'99988877744455'),
	(8,	'Thermometer','Ideal for microwaving your coffee. With a stainless steel stem, large, easy-to-read digital display and case.','789151823654',30,1.50,3.00,45, 2000,'99988877744455');

insert into 
    produtos_standby 
values 
    ( 1, 900, 100),
    ( 5, 6, 101),
    ( 7, 300, 102);

insert into 
    produtos_clientes 
values 
    (0,11122233344, 8, 9, 101),
    (20, 66655544411, 6, 50, 102),
    (10, 99988877744, 3, 521, 100);

INSERT INTO 
	pedidos 
VALUES
	(200, 0,'11122233344', 10000 , '2022-07-12', '2022-09-12', '2022-10-12', 1, 12.15),
	(201, 10,'99988877744', 20000 , '2022-01-12', '2022-10-12' , '2022-11-12' , 2, 1000.2),
	(202, 20,'66655544411', 30000 , '2022-08-12', '2022-08-12','2022-10-12' , 3, 123.45);

insert into 
    pedidos_r_produtos 
values 
    (2, 200, 434),
    (8, 201, 1000),
    (5, 202, 8);
