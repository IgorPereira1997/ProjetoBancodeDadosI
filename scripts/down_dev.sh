#!/usr/bin/env bash

docker compose -f docker-compose.yml down -v
docker system prune -f -a
docker volume prune -f
docker network prune -f

sudo rm -rf postgres_container/pgdata/
