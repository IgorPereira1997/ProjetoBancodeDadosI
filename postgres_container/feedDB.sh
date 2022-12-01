#!/usr/bin/env bash

echo ""
echo "Starting script..."
# create temporary directory for postgres in docker
mkdir "/tmp/stat_temporary" 

# copy your postgresql.conf to postgresql config location in docker
cp /db_config/postgresql.conf /var/lib/postgresql/data/postgresql.conf

echo ""
echo "Criando e alimentando base de dados inicial..."

echo ""
# cria base, usuários e concede permissões, se necessário
psql -U tr_vietna -c "create user postgres with password 'postgres'"

# executa o restore do banco no container da máquina local .
psql -U tr_vietna -d tr_vietna -f /db_backup/db_bd2.sql

echo ""
echo "Base de dados criada com sucesso!"
#psql "nomedobanco" < transportadora_vietna