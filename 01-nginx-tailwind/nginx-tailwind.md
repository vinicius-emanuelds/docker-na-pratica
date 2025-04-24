# Container Nginx com Landing Page do TailwindCSS

<br>

## Objetivo

Executar um container Docker utilizando a imagem do **Nginx**, substituindo sua página padrão por uma landing page estática retirada do repositório oficial do [Tailwind Toolbox](https://github.com/tailwindtoolbox/Landing-Page). A página estará acessível via navegador após a execução.

<br>

## Pré-requisitos

- Docker instalado e configurado corretamente
    > Eu utilizo o [Rancher Desktop](https://rancherdesktop.io/), um aplicativo de código aberto que fornece todos os elementos essenciais para trabalhar com contêineres e Kubernetes.
- Git instalado para clonar o repositório
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


Segue abaixo a documentação em **Markdown** para o **Exercício 1: Rodando um container básico com Nginx e site estático (TailwindCSS)**.

---

```markdown
# Exercício 1 – Rodando um Container Básico com Nginx

## Objetivo

Executar um container utilizando a imagem oficial do Nginx, substituindo a página padrão por uma landing page estática desenvolvida com TailwindCSS. Este exercício visa introduzir o uso básico de containers Docker, sem criação de imagens personalizadas.

---

## Pré-requisitos

- Docker instalado e em funcionamento
- Git instalado
- Acesso à internet para clonar o repositório

---

## Passo a Passo

### 1. Clonar o repositório da landing page

Execute o seguinte comando para clonar a landing page estática baseada em TailwindCSS:

```bash
git clone https://github.com/tailwindtoolbox/Landing-Page.git
```

### 2. Rodar o container com Nginx

Utilize o comando abaixo para iniciar um container com a imagem oficial do Nginx, mapeando o diretório clonado como volume:

```bash
docker run -d --name web \
  -p 8080:80 \
  -v $(pwd)/Landing-Page:/usr/share/nginx/html \
  nginx
```

- `-d`: executa o container em segundo plano
- `--name web`: nome do container
- `-p 8080:80`: mapeia a porta 80 do container para a porta 8080 do host
- `-v $(pwd)/Landing-Page:/usr/share/nginx/html`: monta o volume local com os arquivos da landing page no diretório padrão do Nginx

### 3. Acessar o site no navegador

Abra o navegador e acesse:

```
http://localhost:8080
```

Você verá a landing page carregada diretamente no container.

---

## Finalização

Para parar e remover o container após os testes:

```bash
docker stop web && docker rm web
```

---

## Considerações

- Esse exercício **não envolve a criação de uma imagem Docker personalizada**, apenas o uso da imagem oficial do Nginx.
- O conteúdo estático é servido por meio de **montagem de volume**, prática comum em ambientes de desenvolvimento.

```

Se quiser, posso gerar uma versão com comentários explicativos ou diagramas. Deseja algo mais visual também?