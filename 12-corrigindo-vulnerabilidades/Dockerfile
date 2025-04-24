# Escolhi a imagem 3.9-slim:
# 	- Mais leve e segura em relação a 3.9
#	- Menor chance de causar erros por falta de depêndencias se comparada à 3.9-alpine
FROM python:3.9-slim

# Agora, para evitar o acesso root, eu defini um grupo e um usuario no container
RUN groupadd -r docker_pratica && useradd -r -g docker_pratica admin

# Crio a pasta de trabalho
WORKDIR /app

# Eu modifico as permissões da "pasta de trabalho" para que o novo usuario tenha acesso
RUN chown -R admin:docker_pratica /app


# Para otimizar o uso do cache, vou copiar o "requirements.txt" separado do conteúdo principal
#	 - Isso garante que o Docker somente irá reinstalar as dependências quando o "requirements.txt" mudar.
COPY requirements.txt .

# O pip install só é executado SE o "requirements.txt" mudar
RUN pip install --no-cache-dir -r requirements.txt

# Agora eu copio o restante do conteúdo
COPY . .

# ESSE TRECHO FOI INCLUIDO APÓS A PRIMEIRA ANÁLISE COM O TRIVY PARA EVITAR AS VULNERABILIDADES RELACIONADAS AOS PACOTES DEBIAN
RUN apt-get update && apt-get upgrade -y && apt-get clean

# Agora, eu "mudo" para este novo usuario, garantindo que as próximas instruções serão executadas por ele.
USER admin
