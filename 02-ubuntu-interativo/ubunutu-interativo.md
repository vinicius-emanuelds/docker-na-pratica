# Execução de Container Interativo com Ubuntu
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivos

- Iniciar um container Ubuntu em modo interativo, acessando o terminal do ambiente.
- Desenvolver e executar um script Bash para atualizar pacotes e instalar o Nginx.
- Configurar o servidor para exibir uma página personalizada como validação da instalação.

<br>

---

## Pré-requisitos

- Docker instalado e funcionando corretamente
- Acesso à internet para download da imagem base e atualizações

<br>

---

## Dockerfile

```Dockerfile
FROM ubuntu

WORKDIR /home/ubuntu

COPY instalador.sh .

RUN chmod +x instalador.sh
```

📌 **Explicação das instruções**:

- `FROM ubuntu`: Define a imagem base do container.
- `WORKDIR`: Define o diretório de trabalho padrão.
- `COPY`: Copia o script de instalação para o container.
- `RUN chmod +x`: Garante permissão de execução ao script.

<br>

---

## Script de Instalação (`instalador.sh`)

```bash
#!/usr/bin/env bash

apt-get update -y && apt-get upgrade -y
apt-get install nginx -y
service nginx start

# Página HTML personalizada
cat << 'EOF' > /var/www/html/index.html
<!-- AQUI VOCÊ DEVE ADICIONAR O CONTEÚDO DA NOVA PÁGINA HTML -->
<h1>Servidor Nginx configurado com sucesso!</h1>
EOF
```

<br>

---

## Etapas para Execução

### 1. Criar o Dockerfile

```bash
vi Dockerfile
# Cole o conteúdo mostrado acima
```
![alt text](<../assets/to_README/02 - DOCKERFILE.png>)

<br>

---

### 2. Criar o script instalador

```bash
vi instalador.sh
# Cole o conteúdo do script de instalação
```
![alt text](<../assets/to_README/02 - VI INSTALADOR.png>)

<br>

---

### 3. Construir a imagem Docker

```bash
docker build -t ubuntu-interativo .
```
![alt text](<../assets/to_README/02 - BUILD.png>)

Use `docker image ls` para verificar se a imagem foi criada corretamente.
![alt text](<../assets/to_README/02 - IMAGE LS.png>)

<br>

---

### 4. Executar o container interativamente

```bash
docker run -it --name ubuntu-interativo ubuntu-interativo
```

> Esse comando abre o terminal interativo no container.

![alt text](<../assets/to_README/02 - ACESSO I.png>)

<br>

---

### 5. Executar o script de instalação dentro do container

```bash
./instalador.sh
```

> Isso instalará o Nginx e substituirá a página padrão.

![alt text](<../assets/to_README/02 - INSTALADOR.png>)
![alt text](<../assets/to_README/02 - INSTALADOR 2.png>)

<br>

---

### 6. Testar no navegador

Acesse:

```
http://localhost:8080
```
Você deverá visualizar a nova página definida no `index.html`.

![alt text](<../assets/to_README/02 - TESTE.png>)
