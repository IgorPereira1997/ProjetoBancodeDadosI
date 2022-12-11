-- 1.1
SELECT * FROM public.clientes
ORDER BY user_id ASC, cpf ASC;

-- 1.2
SELECT * FROM public.fornecedores
ORDER BY user_id ASC, cnpj ASC;

-- 3.1
UPDATE pedidos_r_produtos
SET qtd = 10
WHERE produto_fk_id = 8;

-- 3.2
UPDATE pedidos_status
SET nome_status = 'Pagamento Foi Efetuado'
WHERE status_id = 1;

-- 6.1
SELECT LOWER(nome_status)
FROM pedidos_status
WHERE status_id = 0;

-- 6.2
SELECT LOWER(nome_status)
FROM pedidos_status
WHERE status_id = 1;

-- 7.1
SELECT UPPER(nome_status)
FROM pedidos_status
WHERE status_id = 0;

-- 7.2
SELECT UPPER(nome_status)
FROM pedidos_status
WHERE status_id = 1;

-- 8.1
SELECT INITCAP(nome_status)
FROM pedidos_status
WHERE status_id = 0;

-- 8.2
SELECT INITCAP(nome_status)
FROM pedidos_status
WHERE status_id = 1;

-- 9.1
SELECT nome_produto, length(descricao)
AS "Tamanho da descrição do Produto"
FROM produtos
WHERE lenght(descricao)>7;

-- 9.2
SELECT username, length(username)
AS "Quantidade de caracteres do nome do fornecedor"
FROM fornecedores
WHERE lenght(username)>8;

-- 10.1
SELECT nome_produto,cod_barra,POSITION('75' IN cod_barra)
FROM produtos
WHERE POSITION('95' IN cod_barra)>0;

-- 10.2
SELECT username,cpf,POSITION('44' IN cpf)
FROM clientes
WHERE POSITION('44' IN cpf)>0;

-- 11.1
SELECT MAX(cpf) FROM clientes;

-- 11.2
SELECT MAX(cnpj) FROM fornecedores;

-- 12.1
SELECT MIN(CPF) FROM clientes;

-- 12.2
SELECT MIN(cnpj) FROM fornecedores;

-- 13.1
SELECT SUM(preco_unitario) FROM produtos;

-- 13.2
SELECT SUM(preco_revenda) FROM produtos;

-- 14.1
SELECT AVG(preco_revenda) FROM produtos;

-- 14.2
SELECT AVG(preco_unitario) FROM produtos;

-- 15.1
SELECT COUNT(preco_unitario) FROM produtos
WHERE preco_unitario<10;

-- 15.2
SELECT COUNT(nome_status) FROM pedidos_status
WHERE POSITION('en' IN nome_status)>0;

-- 16.1
SELECT DISTINCT (transportadora_fk_id)
FROM pedidos;

-- 16.2
SELECT DISTINCT (user_id) FROM clientes;

-- 17.1
SELECT preco_unitario FROM produtos WHERE preco_unitario BETWEEN 5 AND 7;

-- 17.2
SELECT estoque FROM produtos WHERE estoque BETWEEN 50 AND 400;

-- 18.1
CREATE INDEX idx_precos ON produtos(nome_produto,preco_unitario,preco_revenda);

-- 18.2
ALTER INDEX idx_precos RENAME TO idx_precos_novo;

-- 18.3
ALTER USER postgres WITH PASSWORD 'postgres';

-- 19.1
SELECT descricao, concat('A descrição é: ',descricao,'.') FROM produtos;

-- 19.2
SELECT nome_produto, concat('Produto é ',nome_produto,': ',descricao) FROM produtos;

-- 20.1
SELECT nome_produto,substr(descricao,1,8) FROM produtos WHERE produto_id=18;

-- 20.2
SELECT nome_produto,substr(descricao,1,15) FROM produtos WHERE produto_id=19;

-- 21.1
SELECT nome_produto, lpad(descricao,15,'*') FROM produtos WHERE produto_id=19;

-- 21.2
SELECT nome_produto, lpad(descricao,30,'*') FROM produtos WHERE produto_id=20;

-- 22.1
ALTER TABLE produtos ADD CONSTRAINT preco_unitario_valido CHECK(preco_unitario > 0);

-- 22.2
ALTER TABLE clientes ADD CONSTRAINT cpf_valido CHECK (LENGTH(cpf)=11);

-- 23.1
SELECT produto_id, SUM(estoque) FROM produtos GROUP BY produto_id HAVING SUM(estoque)>100;

-- 23.2
SELECT produto_id, SUM(estoque) FROM produtos GROUP BY produto_id HAVING SUM(estoque)<300;

-- 24.1
SELECT produto_id FROM produtos UNION SELECT estoque FROM produtos ORDER BY produto_id;

-- 24.2
SELECT produto_id FROM produtos UNION SELECT preco_unitario FROM produtos ORDER BY produto_id;

-- 25.1
SELECT produto_id FROM produtos UNION ALL SELECT preco_unitario FROM produtos ORDER BY produto_id;

-- 25.2
SELECT produto_id FROM produtos UNION ALL SELECT estoque FROM produtos ORDER BY produto_id;

-- 26.1
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE preco_unitario > 5 INTERSECT
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE estoque > 100;

-- 26.2
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE tempo_entrega = 5 INTERSECT
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE estoque < 300;

-- 27.1
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE tempo_entrega = 5 EXCEPT
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE estoque < 300;

-- 27.2
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE preco_unitario < 10 EXCEPT
SELECT nome_produto, preco_unitario, estoque FROM produtos WHERE estoque > 100;

-- 28.1
DELETE FROM pedidos_status WHERE status_id=7;

-- 28.2
DELETE FROM fornecedores WHERE user_id = 1;

-- 29.1
SELECT estoque FROM produtos RIGHT JOIN pedidos_r_produtos estoque > qtd;

-- 29.2
SELECT estoque FROM produtos LEFT JOIN pedidos_r_produtos estoque < qtd;

-- 30.1
REVOKE TRUNCATE ON tr_vietna.public.pedidos_status FROM postgres;

-- 30.2
REVOKE TRIGGER ON tr_vietna.public.usuario FROM postgres;

-- 31.1
SELECT nome_produto, preco_unitario,estoque FROM produtos WHERE nome_produto LIKE '%Mu%';

-- 31.2
SELECT endereco_id, logradouro, cep FROM endereco WHERE logradouro LIKE 'R%';

-- 32.1
DROP TABLE pedidos_r_produtos;

-- 32.2
DROP DATABASE tr_vietna;
