# Execução de Container Interativo com Ubuntu

<br>

## Objetivo

Iniciar um container Ubuntu em modo interativo, acessando o terminal do ambiente. Desenvolver e executar um script Bash para atualizar os pacotes e instalar o Nginx. Configurar o servidor para exibir uma página personalizada como validação da instalação.

<br>

## Pré-requisitos

- Docker instalado e configurado corretamente
    > Eu utilizo o [Rancher Desktop](https://rancherdesktop.io/), um aplicativo de código aberto que fornece todos os elementos essenciais para trabalhar com contêineres e Kubernetes.
- Acesso à internet para baixar a imagem e clonar o repositório

<br>

## Dockerfile



```Dockerfile
FROM ubuntu

WORKDIR /home/ubuntu

COPY instalador.sh .

RUN chmod +x instalador.sh
```


### Descrição das instruções

- `FROM ubuntu`: Utiliza a imagem oficial do Ubuntu como base.
- `WORKDIR`: Determina o diretório a ser utilizado para as instruções subsequentes.
- `COPY instalador.sh .`: Copia o script de instalação para o diretório de trabalho.
- `RUN chmod +x instalador.sh`: Torna o script de instalação executável.

<br>

## Como executar

### 1. Crie o `Dockerfile`

```bash
nano Dockerfile
# (cole o conteúdo acima e salve)
```

### 2. Construa a imagem Docker

```bash
docker build -t nginx-tailwind .
```

### 3. Inicie o container

```bash
docker run -d -p 8080:80 --name web-landing nginx-tailwind
```

<br>

## Validação

Abra o navegador e acesse:

```
http://localhost:8080
```

A landing page do Tailwind deverá ser exibida.

<br>

## Referências

- [Tailwind Toolbox - Landing Page](https://github.com/tailwindtoolbox/Landing-Page)
- [Docker Hub - Nginx](https://hub.docker.com/_/nginx)
- [Documentação oficial do Docker](https://docs.docker.com/)
