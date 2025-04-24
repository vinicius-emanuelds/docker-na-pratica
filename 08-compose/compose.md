# Exercício 08 – Criando um Compose File para Rodar uma Aplicação com Banco de Dados

## 🎯 Objetivo

Utilizar Docker Compose para configurar uma aplicação com PostgreSQL e uma interface gráfica de gerenciamento com pgAdmin4.

## Arquivo `docker-compose.yml`

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

---

## Execução

Para iniciar os containers:

```bash
docker compose --env-file .env up -d
```

Ou simplesmente:

```bash
docker compose up -d
```

(Se `.env` estiver no mesmo diretório)

---

## Acesso

- **PostgreSQL:** `localhost:5432`
- **pgAdmin:** [http://localhost:5050](http://localhost:5050)  
  - **Usuário:** `admin@admin.com`  
  - **Senha:** `root123`

---

## Verificação

1. Acesse o pgAdmin via navegador.
2. Adicione uma nova conexão com:
   - Host: `postgres`
   - Usuário: `admin`
   - Senha: `1234`

---

## Notas Finais

- A variável `depends_on` garante que o pgAdmin só seja iniciado após o container do PostgreSQL.
- Os volumes persistem os dados entre reinicializações.
```