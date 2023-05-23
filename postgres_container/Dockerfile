FROM postgres:alpine

COPY feedDB.sh /docker-entrypoint-initdb.d/10-init.sh
RUN chmod +x /docker-entrypoint-initdb.d/10-init.sh
RUN /docker-entrypoint-initdb.d/10-init.sh
