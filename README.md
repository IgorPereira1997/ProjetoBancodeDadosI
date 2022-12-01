# ProjetoBancodeDadosII

Este é um projeto desenvolvido para a Disciplina Banco de Dados II da Universidade Federal do Vale do São Francisco (UNIVASF) e traz o banco de dados de um e-commerce entre distribuidoras, classificadas como fornecedores, e seus clientes, que podem ser mercados, clientes finais, entre outros.

1 - Para fazer o uso e manipulação do projeto, faça o download e instalação do Docker:
    
    1.1 - Instalção no Windows:
        
        1.1.1 - Baixe o instaldor através do link a seguir: https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
        
        1.1.2 - Abra uma janela do terminal do windows (cmd, powershell ou Windows Terminal) e digite o seguinte comando, para instalar o Windows Subsystem for Linux (WSL) necessário para o Docker:
            wsl --install
        
        1.1.3 - Após isto, inicie o instalador do Docker e configure-o conforme pedido pelo executável.
    
    1.2 - Instalação no Linux:

        1.2.1 - Abra uma janela do terminal e instale o pré requisito do Docker para a plataforma, através do seguinte comando:

            sudo apt update && sudo apt install gnome-terminal wget -y

        1.2.2 - Remover quaisquer resquícios de instalações anteriores do docker ou versões betas do mesmo, pelos comandos:

            sudo apt remove docker-desktop
            rm -r $HOME/.docker/desktop
            sudo rm /usr/local/bin/com.docker.cli
            sudo apt purge docker-desktop

        1.2.3 - Faça o download do docker e após isto, faça a instalação do mesmo, através dos comandos:

            wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.15.0-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64

            sudo apt-get update && sudo apt-get install ./docker-desktop-4.15.0-amd64.deb -y

    1.3 - Instalação no macOS:

        1.3.1 - Faça o download do Docker de acordo com o processador que utiliza (Intel ou Apple Silicon):

            Intel - https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-amd64

            Apple Silicon - https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64

        1.3.2 - Instale o docker através dos seguintes comandos:

            sudo hdiutil attach Docker.dmg
            sudo /Volumes/Docker/Docker.app/Contents/MacOS/install --accept-license --user=(id -un)
            sudo hdiutil detach /Volumes/Docker

2 - Crie os arquivos .env necessários para funcionamento dos containers docker, colocando os conteúdos descritos abaixo:

    2.1 - .env.dev.db e .env.prod.db (coque as informações das base de dados de desenvolvimento e produção, de acordo com a necessidade):

        POSTGRES_USER=tr_vietna
        POSTGRES_PASSWORD=admin
        DATABASE_HOST=postgres
        DATABASE_PORT=5432

    2.2 - .env.dev.pgadmin e .env.prod.pgadmin (coloque as informações do pgadmin conforme for adequado ao desenvolvimento e à produção):

        PGADMIN_DEFAULT_EMAIL: "transportadoravietna@gmail.com"
        PGADMIN_DEFAULT_PASSWORD: "admin"
        # 10=DEBUG,20=INFO,25=SQL,30=WARNING,40=ERROR
        PGADMIN_CONFIG_CONSOLE_LOG_LEVEL: 40

3 - Abra o terminal e vá ao diretório aonde baixou o projeto e rode os comandos abaixo, para resolução das permissões de todos os scripts presentes no projeto
    OBS.: Apenas sistemas UNIX rodam os comandos abaixo, ou seja, Linux ou macOS. Para Windows utilize o WSL:

    chmod +x fix_permissions_scripts.sh
    ./fix_permissions_scripts.sh

4 - (Opcional) Caso tenha modificado os dados do banco de dados, como usuário e nome da base de dados na instrução acima, proceda da seguinte forma:

    3.1 - Altere a linha 19, colocando após a instrução -U o nome de usuário escolhido e após o parâmetro -d o nome do banco de dados escolhido. Ex:

        psql -U nome_usuario -d nome_banco -f /db_backup/db_bd2.sql


5 - Altere o arquivo servers.json existente na pasta pgadmin_container com o usuário escolhido no arquivo .env.(dev/prod).db no parâmetro POSTGRES_USER, da seginte forma, sem o <>:

    "Username": "<nome escolhido no POSTGRES_USER>",

6 - Com o docker instalado, para levantar o projeto, há duas alternativas, development (dev) e production (prod). Para levantar os containers do projeto, faça:

    DEV:  docker compose -f docker-compose.yml up -d   
    PROD: docker compose -f docker-compose.prod.yml up -d

7 - As informações para login do pgadmin são as descritas no arquivo .env.(dev/prod).pgadmin respectivamente por PGADMIN_DEFAULT_EMAIL e PGADMIN_DEFAULT_PASSWORD, e o acesso do servidor encontrado no pgadmin pode ser feito com o parâmetro POSTGRES_PASSWORD encontrado no arquivo .env.(dev/prod).db.

