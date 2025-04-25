# Criando um Compose File para Rodar uma Aplicação com Banco de Dados
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo

Utilizar Docker Compose para configurar uma aplicação com PostgreSQL e uma interface gráfica de gerenciamento com pgAdmin4.

<br>

---

## Arquivos Necessários
### `compose.yml`

```yaml
services:
  postgres:
    image: postgres:latest
    container_name: postgres
    restart: always
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PW}
      POSTGRES_DB: ${POSTGRES_DB}
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  pgadmin:
    image: dpage/pgadmin4:latest
    container_name: pgadmin
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: ${PGADMIN_MAIL}
      PGADMIN_DEFAULT_PASSWORD: ${PGADMIN_PW}
    ports:
      - "5050:80"
    depends_on:
      - postgres
    volumes:
      - pgadmin_data:/var/lib/pgadmin

volumes:
  postgres_data:
  pgadmin_data:
```

#### Serviços Definidos
##### ***postgres*** - Banco de dados relacional PostgreSQL

- **image**: Utiliza a imagem oficial mais recente do PostgreSQL.
- **container_name**: Nome personalizado do container (`postgres`).
- **restart**: Sempre reinicia o container em caso de falha (`always`).
- **environment**: Variáveis de ambiente para configurar o banco:
  - `POSTGRES_USER`: nome do usuário administrador.
  - `POSTGRES_PASSWORD`: senha do usuário.
  - `POSTGRES_DB`: nome do banco de dados inicial.
  *(valores são lidos de variáveis de ambiente definidas em um arquivo `.env` ou no sistema)*
- **ports**: Mapeia a porta 5432 do container para a 5432 do host.
- **volumes**: Persistência dos dados do banco, mesmo que o container seja destruído.
 
 <br>

##### ***pgadmin*** - Interface gráfica para administração do PostgreSQL via navegador

- **image**: Imagem oficial do pgAdmin 4.
- **container_name**: Nome personalizado do container (`pgadmin`).
- **restart**: Reinício automático se falhar.
- **environment**:
  - `PGADMIN_DEFAULT_EMAIL`: e-mail do login no pgAdmin.
  - `PGADMIN_DEFAULT_PASSWORD`: senha correspondente.
- **ports**: Porta 80 do container é mapeada para 5050 do host (acesso via `http://localhost:5050`).
- **depends_on**: Aguarda o container do PostgreSQL iniciar primeiro.
- **volumes**: Persistência da configuração e dados do pgAdmin.

#### Volumes
Criação de volumes nomeados:

- `postgres_data`: volume persistente do PostgreSQL.
- `pgadmin_data`: volume persistente do pgAdmin.

<br>

### `.env`

```env
POSTGRES_USER=admin
POSTGRES_PW=1234
POSTGRES_DB=postgres
PGADMIN_MAIL=admin@admin.com
PGADMIN_PW=root123
```

<br>

---

## Execução

Para iniciar os containers:

```bash
docker compose --env-file .env up -d
```

Se `.env` estiver no mesmo diretório:

```bash
docker compose up -d
```

![alt text](<../assets/to_README/08 - RUN COMPOSE.png>)

Verifique os containers em execução:

```bash
docker ps
```
![alt text](<../assets/to_README/08 - PS.png>)


<br>

---

## Acesso

- **pgAdmin:** [http://localhost:5050](http://localhost:5050)  
  - **Usuário:** `admin@admin.com`  
  - **Senha:** `root123`
  
![alt text](<../assets/to_README/08 - TESTE.png>)

![alt text](<../assets/to_README/08 - LOGADO.png>)

<br>

---

## Considerações Finais
- A variável `depends_on` garante que o pgAdmin só seja iniciado após o container do PostgreSQL.
- Os volumes persistem os dados entre reinicializações.
```