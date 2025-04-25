Aqui está a documentação com os comandos para a criação das redes Docker antes de rodar o `docker-compose.yml`:

---

# Construção de Rede Docker para Comunicação entre Containers (Node.js + MongoDB)

##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Estrutura Inicial do Projeto

O projeto utiliza um repositório completo com a estrutura já configurada para comunicação entre os containers do frontend (React), backend (Node.js) e banco de dados (MongoDB).

O foco do exercício é a **configuração da rede Docker personalizada** para possibilitar a comunicação entre os containers.

<br>

---

## Objetivo

- **Criar redes Docker personalizadas** para permitir que containers do **Node.js** (backend) e **MongoDB** se comuniquem.
- **Alterar o arquivo `docker-compose.yml`** para definir as redes necessárias, mantendo a estrutura geral do projeto inalterada.
- **Testar a comunicação entre containers**, verificando o mapeamento de portas entre o frontend, backend e MongoDB.

<br>

---

## Alterações Realizadas

Para cumprir os requisitos do exercício, foram feitas as seguintes alterações no arquivo `docker-compose.yml`:

### 1. **Criação das Redes Docker**

Antes de rodar o `docker-compose.yml`, você precisa **criar as redes Docker** externas para garantir que os containers possam se comunicar entre si. 

Para verificar se as redes já existem, utilize o comando:

```bash
docker network ls
```

![alt text](<../assets/to_README/07 - REDES.png>)

Utilize os seguintes comandos para criar as redes:

```bash
docker network create rede-react
docker network create rede-mongo
```

![alt text](<../assets/to_README/07 - REDES CRIADAS.png>)

Essas redes agora serão usadas pelos containers definidos no `docker-compose.yml`.

<br>

### 2. **Alteração do `compose.yml`**

No serviço **backend**, foi incluída a configuração de rede `rede-mongo`, além de manter a rede `rede-react` para permitir a comunicação tanto com o frontend quanto com o banco de dados.

No serviço **frontend**, a rede `rede-react` foi mantida para garantir que o frontend possa se comunicar com o backend.

No serviço **mongo**, a rede `rede-mongo` foi adicionada para permitir que o backend se conecte ao banco de dados.

```yaml
services:
  frontend:
    build:
      context: frontend
      target: development
    ports:
      - 3000:3000
    stdin_open: true
    volumes:
      - ./frontend:/usr/src/app
      - /usr/src/app/node_modules
    restart: always
    networks:
      - rede-react
    depends_on:
      - backend

  backend:
    restart: always
    build:
      context: backend
      target: development
    volumes:
      - ./backend:/usr/src/app
      - /usr/src/app/node_modules
    depends_on:
      - mongo
    networks:
      - rede-mongo
      - rede-react
    expose: 
      - 3000
  mongo:
    restart: always
    image: mongo:4.2.0
    volumes:
      - mongo_data:/data/db
    networks:
      - rede-mongo
    expose:
      - 27017
networks:
  rede-react:
    external: true
  rede-mongo:
    external: true

volumes:
  mongo_data:

```

### 3. **Redes no `docker-compose.yml`**

As redes `rede-react` e `rede-mongo` foram configuradas como externas, para que os containers utilizem essas redes previamente criadas, ao invés de serem criadas automaticamente pelo Docker Compose:

```yaml
networks:
  rede-react:
    external: true
  rede-mongo:
    external: true
```

<br>

---

## Teste de Comunicação entre Containers

Após as modificações no `docker-compose.yml`, execute os seguintes passos para verificar a comunicação entre os containers:

1. **Subir os containers** com o comando:

```bash
docker-compose up -d
```

![alt text](<../assets/to_README/07 - COMPOSE UP.png>)

3. **Verificar os containers em execução**:

```bash
docker ps
```

Você deve ver os três containers (`frontend`, `backend`, `mongo`) em execução, com as portas mapeadas conforme especificado.

![alt text](<../assets/to_README/07 - DOCKER PS.png>)

4. **Testar a comunicação entre containers**:

Acesse a URL `http://localhost:3000` no seu navegador. Isso deve abrir a aplicação frontend, que se comunica com o backend e o banco de dados MongoDB.

![alt text](<../assets/to_README/07 - TESTE.png>)


Com isso, a comunicação entre os containers foi validada, confirmando que as redes foram configuradas corretamente.

<br>

---

## Considerações Finais

- A utilização de redes Docker personalizadas facilita a comunicação entre os containers de frontend, backend e banco de dados, mantendo o ambiente isolado e organizado.
- As modificações no `docker-compose.yml` foram focadas apenas na configuração das redes para atender ao requisito do exercício.
- O mapeamento de portas foi testado e validado para garantir que o frontend e backend estão acessíveis conforme o esperado.