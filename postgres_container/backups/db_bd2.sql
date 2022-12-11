-- Database: tr_vietna

DO $$
BEGIN
IF EXISTS (SELECT FROM pg_database WHERE datname = 'tr_vietna') THEN
	RAISE NOTICE 'Database tr_vietna já existe! Pulando para permissões e criação de tabelas...';
ELSE
	CREATE DATABASE tr_vietna
		WITH
		OWNER = tr_vietna
		ENCODING = 'UTF8'
		LC_COLLATE = 'en_US.utf8'
		LC_CTYPE = 'en_US.utf8'
		TABLESPACE = pg_default
		CONNECTION LIMIT = -1
		IS_TEMPLATE = False;
	RAISE NOTICE 'Database tr_vietna criada com sucesso!';
END IF;
END $$;

GRANT TEMPORARY, CONNECT ON DATABASE tr_vietna TO PUBLIC;

GRANT ALL ON DATABASE tr_vietna TO tr_vietna;

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
	cnpj VARCHAR(14),
	PRIMARY KEY(user_id,cnpj)
)INHERITS (usuario);

CREATE TABLE IF NOT EXISTS clientes (
	cpf VARCHAR(11),
	PRIMARY KEY(user_id,cpf)
)INHERITS(usuario);

CREATE TABLE IF NOT EXISTS transportadoras(
	transportadora_id INTEGER PRIMARY KEY,
	fk_user_id INTEGER,
	fk_fornecedor_cnpj VARCHAR(14),
	cnpj VARCHAR(14),
	nome_transportadora VARCHAR(100),
    telefone VARCHAR(11),
	endereco_fk_id INTEGER,
	FOREIGN KEY(endereco_fk_id) 
		REFERENCES endereco(endereco_id), 
	FOREIGN KEY(fk_user_id, fk_fornecedor_cnpj) 
		REFERENCES fornecedores(user_id,cnpj)

);

CREATE TABLE IF NOT EXISTS pedidos_status(
	status_id INTEGER PRIMARY KEY,
	nome_status VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS pedidos(
	pedido_id INTEGER PRIMARY KEY,
	fk_user_id INTEGER,
	fk_cliente_cpf VARCHAR(11),
	transportadora_fk_id INTEGER,
	data_pedido TIMESTAMP WITH TIME ZONE,
	data_saida TIMESTAMP WITH TIME ZONE,
	data_entrega TIMESTAMP WITH TIME ZONE,
	status INTEGER,
	valor FLOAT, 
	FOREIGN KEY(fk_user_id,fk_cliente_cpf) 
		REFERENCES clientes(user_id,cpf), 
	FOREIGN KEY(transportadora_fk_id) 
		REFERENCES transportadoras(transportadora_id),
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
	fk_user_id INTEGER,
	fk_fornecedor_cnpj VARCHAR(14), 
	FOREIGN KEY(fk_user_id,fk_fornecedor_cnpj) 
		REFERENCES fornecedores(user_id,cnpj)
);

CREATE TABLE IF NOT EXISTS produtos_standby(
	produto_fk_id INTEGER,
	qtd_reservada INTEGER,
	reserva_id INTEGER PRIMARY KEY,
	CONSTRAINT produto_fk_id
		FOREIGN KEY(produto_fk_id)
		REFERENCES produtos(produto_id)
		ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS produtos_clientes(
	fk_user_id INTEGER,
	fk_cliente_cpf VARCHAR(11),
	produto_fk_id INTEGER,
	estoque_cliente INTEGER,
	reserva_fk_id INTEGER,
	FOREIGN KEY(produto_fk_id)
		REFERENCES produtos(produto_id)
		ON DELETE CASCADE,
	FOREIGN KEY(fk_user_id,fk_cliente_cpf)
		REFERENCES clientes(user_id,cpf)
		ON DELETE CASCADE,
	FOREIGN KEY(reserva_fk_id)
		REFERENCES produtos_standby(reserva_id)
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
