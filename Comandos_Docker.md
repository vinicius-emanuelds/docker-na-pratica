# Comandos Essenciais do Docker
---
## `docker run` – Cria e inicia um novo container
```bash
docker run [opções] imagem [comando]
```
**Parâmetros:**
- `-d` – Executa em segundo plano (modo *detached*)
- `-p <host>:<container>` – Mapeia portas
- `--name <nome>` – Nome personalizado
- `-e VAR=valor` – Variáveis de ambiente
- `-v <host>:<container>` – Mapeia volumes
- `--rm` – Remove o container ao final
- `--network <nome>` – Define rede
- `--restart=always` – Reinício automático

---

## `docker ps` – Lista containers em execução
```bash
docker ps [opções]
```
**Parâmetros:**
- `-a` – Lista todos (ativos e parados)
- `-q` – Apenas IDs
- `--filter` – Filtros (ex: `status=exited`)

---

## `docker build` – Cria imagem a partir de um Dockerfile
```bash
docker build [opções] <caminho>
```
**Parâmetros:**
- `-t <nome>:<tag>` – Nome e tag
- `-f <arquivo>` – Dockerfile alternativo
- `--no-cache` – Sem cache
- `--build-arg VAR=valor` – Argumentos para build

---

## `docker exec` – Executa comandos em container ativo
```bash
docker exec [opções] <container> <comando>
```
**Parâmetros:**
- `-it` – Modo interativo com terminal
- `--user <usuario>` – Executa como usuário específico

---

## `docker logs` – Exibe logs de container
```bash
docker logs [opções] <container>
```
**Parâmetros:**
- `-f` – Segue os logs
- `--tail <n>` – Últimas `n` linhas
- `--since` – Desde horário específico (ex: `--since="10m"`)

---

## Controle de containers
```bash
docker stop <container>
docker start <container>
docker restart <container>
```

---

## `docker rm` – Remove containers
```bash
docker rm [opções] <container>
```
**Parâmetros:**
- `-f` – Força remoção
- `-v` – Remove volumes juntos

---

## `docker rmi` – Remove imagens
```bash
docker rmi [opções] <imagem>
```
**Parâmetro:**
- `-f` – Força remoção

---

## `docker images` – Lista imagens locais
```bash
docker images [opções]
```
**Parâmetros:**
- `-a` – Mostra todas (inclui intermediárias)
- `-q` – Apenas IDs

---

## `docker pull` – Baixa imagem do Docker Hub
```bash
docker pull nginx:latest
```

---

## `docker push` – Envia imagem para repositório
```bash
docker push meuusuario/imagem:tag
```
> É necessário estar autenticado (`docker login`)

---

## `docker network` – Gerencia redes
```bash
docker network ls
docker network create <nome>
docker network inspect <nome>
docker network rm <nome>
```

---

## `docker volume` – Gerencia volumes
```bash
docker volume ls
docker volume create <nome>
docker volume inspect <nome>
docker volume rm <nome>
```

---

## `docker inspect` – Mostra detalhes em JSON
```bash
docker inspect <container|imagem|volume|rede>
```

---
