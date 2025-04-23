# Container Nginx com Landing Page do TailwindCSS

<br>

## Objetivo

Executar um container Docker utilizando a imagem do **Nginx**, substituindo sua página padrão por uma landing page estática retirada do repositório oficial do [Tailwind Toolbox](https://github.com/tailwindtoolbox/Landing-Page). A página estará acessível via navegador após a execução.

<br>

## Pré-requisitos

- Docker instalado e configurado corretamente
    > Eu utilizo o [Rancher Desktop](https://rancherdesktop.io/), um aplicativo de código aberto que fornece todos os elementos essenciais para trabalhar com contêineres e Kubernetes.
- Acesso à internet para baixar a imagem e clonar o repositório

<br>

## Dockerfile



```Dockerfile
FROM nginx

CMD ["nginx", "-g", "daemon off;"]

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/tailwindtoolbox/Landing-Page.git /home/Landing-Page

RUN cp /home/Landing-Page/index.html /usr/share/nginx/html/index.html
```


### Descrição das instruções

- `FROM nginx`: Utiliza a imagem oficial do Nginx como base.
- `CMD`: Mantém o Nginx em execução em primeiro plano.
- `RUN apt-get ...`: Instala o Git para permitir o clone do repositório.
- `RUN git clone ...`: Clona a landing page para uma pasta temporária.
- `RUN cp ...`: Substitui a página inicial padrão do Nginx pela landing page.

<br>

## Como executar

### 1. Crie o `Dockerfile`

```bash
vi Dockerfile
# (cole o conteúdo acima e salve)
```

![01 - 01.png](src\assets\to_README\01 - 01.png)

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
