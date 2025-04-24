# Rodando um Container Básico com Nginx

<br>

## Objetivo

Executar um container utilizando a imagem oficial do Nginx, substituindo a página padrão por uma landing page estática desenvolvida com TailwindCSS. Este exercício visa introduzir o uso básico de containers Docker, sem criação de imagens personalizadas.

<br>

## Pré-requisitos

- Docker instalado e em funcionamento
  > Eu utilizo o [Rancher Desktop](https://rancherdesktop.io/), um aplicativo de código aberto que fornece todos os elementos essenciais para trabalhar com contêineres e Kubernetes, mas você pode usar o Docker Desktop ou o Docker Engine, dependendo do seu sistema operacional.
- Git instalado
- Acesso à internet para clonar o repositório

<br>

## Passo a Passo

### 1. Clonar o repositório da landing page

Execute o seguinte comando para clonar a landing page estática baseada em TailwindCSS:

```bash
git clone https://github.com/tailwindtoolbox/Landing-Page.git
```

![alt text](<../assets/to_README/01 - CLONE.png>)

### 2. Rodar o container com Nginx

Utilize o comando abaixo para iniciar um container com a imagem oficial do Nginx, mapeando o diretório clonado como volume:

```bash
docker run -d --name nginx-tailwind \
  -p 8080:80 \
  -v $(pwd)/Landing-Page:/usr/share/nginx/html \
  nginx
```

![alt text](<../assets/to_README/01 - RUN.png>)

- `-d`: executa o container em segundo plano
- `--name web`: nome do container
- `-p 8080:80`: mapeia a porta 80 do container para a porta 8080 do host
- `-v $(pwd)/Landing-Page:/usr/share/nginx/html`: monta o volume local com os arquivos da landing page no diretório padrão do Nginx

Agora, utilize o comando `Docker ps` para verificar se o container está em execução:

![alt text](<../assets/to_README/01 - DOCKER PS.png>)

### 3. Acessar o site no navegador

Abra o navegador e acesse:

```
http://localhost:8080
```

Você verá a landing page carregada diretamente no container.

![alt text](<../assets/to_README/01 - TESTE.png>)

<br>

## Finalização

Para parar e remover o container após os testes:

```bash
docker stop nginx-tailwind && docker rm nginx-tailwind
```

---

## Considerações

- Esse exercício **não envolve a criação de uma imagem Docker personalizada**, apenas o uso da imagem oficial do Nginx.
- O conteúdo estático é servido por meio de **montagem de volume**, prática comum em ambientes de desenvolvimento.
