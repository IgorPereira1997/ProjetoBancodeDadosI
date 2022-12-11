#!/usr/bin/env bash

echo ""
echo "Starting script..."
# create temporary directory for postgres in docker
mkdir "/tmp/stat_temporary" 

# copy your postgresql.conf to postgresql config location in docker
cp /db_config/postgresql.conf /var/lib/postgresql/data/postgresql.conf

USER=tr_vietna #Nome do usuário de dados
DB=tr_vietna #Nome do banco de dados

echo ""
echo "Criando e alimentando base de dados inicial..."

echo ""
# cria base, usuários e concede permissões, se necessário
psql -U $USER -c "create user postgres with password 'postgres'"

# executa o restore do banco no container da máquina local .
psql -U $USER -d $DB -f /db_backup/db_bd2.sql

echo ""
echo "Base de dados criada com sucesso!"
echo ""

echo "Alimentando o Banco de dados com dados fictícios...."
psql -U $USER -d $DB -f /db_backup/inserts.sql

echo ""
echo "Base de dados alimentada com sucesso!" 

#psql "nomedobanco" < transportadora_vietna