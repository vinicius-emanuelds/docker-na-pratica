# 🚀 Exercícios Docker

Este repositório contém todos os exercícios propostos de Docker, organizados por nível de dificuldade.

---

## 🟢 Fácil

### 1. Rodando um container básico
- Execute um container usando a imagem do **Nginx** e acesse a página padrão no navegador.  
- 🔹 *Exemplo de aplicação:* Use a landing page do **TailwindCSS** como site estático dentro do container.

### 2. Criando e rodando um container interativo
- Inicie um container **Ubuntu** e interaja com o terminal dele.  
- 🔹 *Exemplo de aplicação:* Teste um script **Bash** que imprime logs do sistema ou instala pacotes de forma interativa.

### 3. Listando e removendo containers
- Liste todos os containers em execução e parados, pare um container em execução e remova um container específico.  
- 🔹 *Exemplo de aplicação:* Gerenciar containers de testes criados para verificar configurações ou dependências.

### 4. Criando um Dockerfile para uma aplicação simples em Python
- Crie um Dockerfile para uma aplicação **Flask** que retorna uma mensagem ao acessar um endpoint.  
- 🔹 *Exemplo de aplicação:* Use a **Flask Restful API Starter** para criar um endpoint de teste.

---

## 🟢 Médio

### 5. Criando e utilizando volumes para persistência de dados
- Execute um container **MySQL** e configure um volume para armazenar os dados do banco de forma persistente.  
- 🔹 *Exemplo de aplicação:* Use o sistema de login e cadastro do **Laravel Breeze**, que utiliza MySQL.

### 6. Criando e rodando um container multi-stage
- Utilize um **multi-stage build** para otimizar uma aplicação **Go**, reduzindo o tamanho da imagem final.  
- 🔹 *Exemplo de aplicação:* Compile e rode a API do **Go Fiber Example** dentro do container.

### 7. Construindo uma rede Docker para comunicação entre containers
- Crie uma rede Docker personalizada e faça dois containers (um **Node.js** e um **MongoDB**) se comunicarem.  
- 🔹 *Exemplo de aplicação:* Utilize o projeto **MEAN Todos** para criar um app de tarefas.

### 8. Criando um compose file para rodar uma aplicação com banco de dados
- Utilize **Docker Compose** para configurar uma aplicação **Django** com um banco de dados **PostgreSQL**.  
- 🔹 *Exemplo de aplicação:* Use o projeto **Django Polls App** para criar uma pesquisa de opinião integrada ao banco.

---

## 🟢 Difícil

### 9. Criando uma imagem personalizada com um servidor web e arquivos estáticos
- Construa uma imagem baseada no **Nginx** ou **Apache**, adicionando um site HTML/CSS estático.  
- 🔹 *Exemplo de aplicação:* Utilize a landing page do **Creative Tim** para criar uma página moderna hospedada no container.

---
docker-exercicios/
├── README.md
├── facil/
│   ├── 01-container-nginx/
│   │   └── index.html
│   ├── 02-container-ubuntu/
│   │   └── script.sh
│   ├── 03-listar-remover/
│   │   └── comandos.txt
│   └── 04-dockerfile-python/
│       ├── app.py
│       └── Dockerfile
├── medio/
│   ├── 05-mysql-volume/
│   │   └── docker-compose.yml
│   ├── 06-multi-stage-go/
│   │   ├── main.go
│   │   └── Dockerfile
│   ├── 07-rede-node-mongo/
│   │   ├── backend/
│   │   │   └── server.js
│   │   ├── database/
│   │   │   └── init.js
│   │   └── docker-compose.yml
│   └── 08-django-compose/
│       ├── django_app/
│       └── docker-compose.yml
├── dificil/
│   └── 09-servidor-web/
│       ├── site/
│       │   └── index.html
│       └── Dockerfile

