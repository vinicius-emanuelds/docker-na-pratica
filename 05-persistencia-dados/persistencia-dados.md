# Criando e Utilizando Volumes para Persistência de Dados com Docker Compose
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo
O objetivo deste exercício é criar um container MySQL utilizando o Docker Compose, configurando um volume persistente para armazenar os dados do banco de dados de forma que eles não sejam perdidos após a remoção do container.

<br>

---

## Passos para a Execução

### Preparação do Ambiente

#### 1. **Obtenção do Docker Compose**: 

Baixe o repositório do projeto com a configuração já pronta para o Docker Compose a partir do link fornecido:
[react-express-mysql](https://github.com/docker/awesome-compose/tree/master/react-express-mysql).

<br>


#### 2. **Configuração do Docker Compose**:

No arquivo `docker-compose.yml` fornecido, o serviço do banco de dados utiliza o MariaDB por padrão. Para substituir por MySQL, basta descomentar a linha que usa a imagem `mysql:8.0.27` e comentar a linha da imagem `mariadb`.

O trecho alterado no arquivo `docker-compose.yml` ficará da seguinte forma:

```yaml
db:
    image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    restart: always
    secrets:
    - db-password
    volumes:
    - mysql-persistente:/var/lib/mysql
    networks:
    - private
    environment:
    - MYSQL_DATABASE=example
    - MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db-password
```

<br>

#### 3. **Criação do Volume**:
Criar um volume nomeado manualmente para persistir os dados do MySQL, como prática adicional:

No terminal, execute o comando:

```bash
docker volume create mysql-dados
```

![alt text](<../assets/to_README/05 - CREATE VOLUME.png>)

<br>

#### 4. **Atualização do docker-compose.yml**: Alterar o arquivo `docker-compose.yml` para usar o volume `mysql-dados` em vez do volume `db-data`.

O trecho final do arquivo atualizado é:

```yaml
services:
    db:
    image: mysql:8.0.27
    command: '--default-authentication-plugin=mysql_native_password'
    restart: always
    secrets:
        - db-password
    volumes:
        - mysql-dados:/var/lib/mysql
    networks:
        - private
    environment:
        - MYSQL_DATABASE=example
        - MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db-password

volumes:
    back-notused:
    mysql-dados:
```

<br>

---

### **Subir os containers**

Para rodar o projeto, execute o comando:

```bash
docker compose up -d
```

![alt text](<../assets/to_README/05 - COMPOSE UP.png>)

<br>

---

### Testando os Serviços

#### 1. Verificar se os Serviços Estão no Ar
Execute o comando para verificar os containers e suas portas:

```bash
docker compose ps
```

Certifique-se de que os serviços `frontend`, `backend` e `db` estão com o status `Up`.

Use o comando `docker inspect` para verificar se o volume `mysql-dados` está sendo utilizado pelo container do banco de dados:

```bash
docker inspect <nome-do-container> | grep mysql-dados"
```
![alt text](<../assets/to_README/05 - VERIFICAÇÃO.png>)

#### 2. Acessar as Portas Expostas
No seu navegador, acesse:

<br>

**Frontend (React)** 

```
http://localhost:3000
```

![alt text](<../assets/to_README/05 - PORTA FE.png>)

<br>

**Backend (Express)**

```bash
http://localhost:80
```

![alt text](<../assets/to_README/05 - PORTA BE.png>)

Se todas as portas responderem corretamente, os serviços estão funcionando corretamente.

<br>

---

### Testando a Persistência de Dados no MySQL

### 1. Acessar o Container do Banco

Para acessar o container do banco de dados, use o comando:

```bash
docker exec -it <nome-do-container-db> bash
```

Substitua `<nome-do-container-db>` pelo nome real do container do banco, que pode ser obtido com o comando `docker ps`.

![alt text](<../assets/to_README/05 - ACESSO IT.png>)

<br>

#### 2. Acessar o MySQL Dentro do Container
No terminal do container, execute o comando para acessar o MySQL:

```bash
mysql -u root -p
```

![alt text](<../assets/to_README/05 - ACESSO MYSQL.png>)

Quando solicitado, forneça a senha definida no arquivo `db/password.txt`.

<br>

#### 3. Verificar o Banco e Criar uma Tabela de Teste
Dentro do MySQL, execute os seguintes comandos SQL:

```sql
USE example;

CREATE TABLE teste_persistencia (
id INT AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(100)
);

INSERT INTO teste_persistencia (nome) VALUES ('Docker Presente o/');

SELECT * FROM teste_persistencia;
```

Você verá a linha `Docker Presente o/` inserida na tabela `teste_persistencia`.

![alt text](<../assets/to_README/05 - TABELA.png>)

<br>

#### 4. Validar Persistência de Dados
Execute o comando para derrubar os containers:

```bash
docker compose down
```

![alt text](<../assets/to_README/05 - COMPO DN.png>)

Suba os containers novamente:

```bash
docker compose up -d
```

Acesse o MySQL novamente e execute:

```sql
USE example;
SELECT * FROM teste_persistencia;
```

![alt text](<../assets/to_README/05 - TESTE.png>)

Se a linha `Docker Presente o/` ainda estiver presente, a persistência de dados foi validada com sucesso.