-- Database: ddi6bisncdt0sf

-- DROP DATABASE IF EXISTS tr_vietna_db;

CREATE DATABASE IF NOT EXISTS tr_vietna
    WITH
    OWNER = tr_vietna
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

GRANT TEMPORARY, CONNECT ON DATABASE tr_vietna TO PUBLIC;

GRANT ALL ON DATABASE tr_vietna_db TO tr_vietna;

CREATE TABLE IF NOT EXISTS endereco(
	endereco_id INTEGER PRIMARY KEY,
	cep VARCHAR (9),
	logradouro VARCHAR(200),
	numero INTEGER,
	complemento VARCHAR(20),
	bairro VARCHAR (50),
	cidade VARCHAR (50),
	estado VARCHAR (50)
);

CREATE TABLE IF NOT EXISTS usuario (
	user_id INTEGER PRIMARY KEY,
	email VARCHAR(100),
	username VARCHAR(100),
	senha VARCHAR(20),
	nome_completo VARCHAR(150),
	endereco_fk_id INTEGER,
    CONSTRAINT endereco_fk_id 
		FOREIGN KEY(endereco_fk_id) 
			REFERENCES endereco(endereco_id)
);

CREATE TABLE IF NOT EXISTS fornecedores(
	cnpj VARCHAR(14) PRIMARY KEY
)INHERITS (usuario);

CREATE TABLE IF NOT EXISTS clientes (
	cpf VARCHAR(11) PRIMARY KEY
)INHERITS(usuario);

CREATE TABLE IF NOT EXISTS transportadoras(
	transportadora_id INTEGER PRIMARY KEY,
	fornecedor_fk_id VARCHAR(14),
	cnpj VARCHAR(14),
	nome_transportadora VARCHAR(100),
    telefone VARCHAR(11),
	endereco_fk_id INTEGER,
    CONSTRAINT endereco_fk_id 
		FOREIGN KEY(endereco_fk_id) 
			REFERENCES endereco(endereco_id),
    CONSTRAINT fornecedor_fk_id 
		FOREIGN KEY(fornecedor_fk_id) 
			REFERENCES fornecedores(cnpj)

);

CREATE TABLE IF NOT EXISTS pedidos_status(
	status_id INTEGER PRIMARY KEY,
	nome_status VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS pedidos(
	pedido_id INTEGER PRIMARY KEY,
	cliente_fk_id VARCHAR(11),
	transportadora_fk_id INTEGER,
	data_pedido TIMESTAMP WITH TIME ZONE,
	data_saida TIMESTAMP WITH TIME ZONE,
	data_entrega TIMESTAMP WITH TIME ZONE,
	status INTEGER,
	conhecimento INTEGER,
	valor FLOAT,
	CONSTRAINT cliente_fk_id 
		FOREIGN KEY(cliente_fk_id) 
			REFERENCES clientes(cpf),
	CONSTRAINT transportadora_fk_id 
		FOREIGN KEY(transportadora_fk_id) 
			REFERENCES transportadoras(transportadora_id),
	CONSTRAINT status 
		FOREIGN KEY(status) 
			REFERENCES pedidos_status(status_id)
);

CREATE TABLE IF NOT EXISTS produtos(
	produto_id INTEGER PRIMARY KEY,
	nome_produto VARCHAR(100),
	descricao VARCHAR(2000),
	cod_barra VARCHAR(13),
	tempo_entrega INTEGER,
	preco_unitario FLOAT,
	preco_revenda FLOAT,
	estoque INTEGER,
	fornecedor_fk_id VARCHAR(14),
    CONSTRAINT fornecedor_fk_id 
		FOREIGN KEY(fornecedor_fk_id) 
			REFERENCES fornecedores(cnpj)
);

CREATE TABLE IF NOT EXISTS produtos_standby(
	produto_fk_id INTEGER,
	qtd_reservada INTEGER,
	CONSTRAINT produto_fk_id
		FOREIGN KEY(produto_fk_id)
		REFERENCES produtos(produto_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS produtos_clientes(
	cliente_fk_id VARCHAR(11),
	produto_fk_id INTEGER,
	estoque_cliente INTEGER,
	CONSTRAINT produto_fk_id
		FOREIGN KEY(produto_fk_id)
		REFERENCES produtos(produto_id)
		ON DELETE CASCADE,
	CONSTRAINT cliente_fk_id
		FOREIGN KEY(cliente_fk_id)
		REFERENCES clientes(cpf)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pedidos_r_produtos(
	produto_fk_id INTEGER,
	pedido_fk_id INTEGER,
	qtd INTEGER,
	CONSTRAINT pedidos_r_produtos_pk 
		PRIMARY KEY (produto_fk_id, pedido_fk_id),
	CONSTRAINT produto_fk_id
		FOREIGN KEY(produto_fk_id) 
			REFERENCES produtos(produto_id),
	CONSTRAINT pedido_fk_id
		FOREIGN KEY(pedido_fk_id) 
			REFERENCES pedidos(pedido_id)
);
