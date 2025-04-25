FROM python:3.9-slim

RUN groupadd -r docker_pratica && useradd -r -g docker_pratica admin

WORKDIR /app

RUN chown -R admin:docker_pratica /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get clean

USER admin