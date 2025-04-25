
# Criando uma Imagem Personalizada com Nginx
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo

Criar uma imagem Docker personalizada baseada no Nginx, incorporando uma landing page estática do Creative Tim. O container resultante deve ser capaz de servir o conteúdo HTML/CSS automaticamente ao ser iniciado.

<br>

---

## Estrutura do Dockerfile

```Dockerfile
FROM nginx

CMD ["nginx", "-g", "daemon off;"]

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/creativetimofficial/material-kit.git /tmp/material-kit

RUN cp -r /tmp/material-kit/* /usr/share/nginx/html/
```

<br>

---

## Passo a Passo

### 1. Criar o Dockerfile

Crie um arquivo chamado `Dockerfile` com o conteúdo acima no diretório do seu projeto.

```bash
vi Dockerfile
```
![alt text](<../assets/to_README/09 - DOCKERFILE.png>)

<br>


### 2. Construir a imagem personalizada

```bash
docker build -t creative-tim .
```
![alt text](<../assets/to_README/09 - BUILD.png>)

<br>

### 3. Rodar o container

```bash
docker run -d -p 8080:80 --name creative-tim creative-tim
```

![alt text](<../assets/to_README/09 - RUN.png>)

### 4. Acessar no navegador

Abra:

```
http://localhost:8080
```

Você verá a landing page estática do Creative Tim sendo servida via Nginx.

![alt text](<../assets/to_README/09 - TESTE.png>)

