
# Rodando um Container Básico com Nginx
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivos

- Executar um container utilizando a imagem oficial do Nginx.
- Substituir a página padrão por uma landing page estática baseada em TailwindCSS.
- Compreender o uso de montagem de volumes em containers.

<br>

---

## Pré-requisitos

- Docker instalado e em funcionamento  
- Git instalado  
- Acesso à internet para clonar o repositório  

> Recomendo o uso do [Rancher Desktop](https://rancherdesktop.io/), uma alternativa open-source ao Docker Desktop, mas qualquer engine Docker pode ser utilizada.

<br>

---

## Etapas de Execução

### 1. Clonar o repositório da landing page

Clone o repositório com o conteúdo HTML da página:

```bash
git clone https://github.com/tailwindtoolbox/Landing-Page.git
```

![alt text](<../assets/to_README/01 - CLONE.png>)

<br>

---

### 2. Rodar o container com Nginx

Execute o container mapeando o diretório clonado como volume:

```bash
docker run -d --name nginx-tailwind \
  -p 8080:80 \
  -v $(pwd)/Landing-Page:/usr/share/nginx/html \
  nginx
```

![alt text](<../assets/to_README/01 - RUN.png>)

**Parâmetros utilizados:**
- `-d`: Executa o container em segundo plano.
- `--name nginx-tailwind`: Define o nome do container.
- `-p 8080:80`: Mapeia a porta 80 do container para a 8080 do host.
- `-v $(pwd)/Landing-Page:/usr/share/nginx/html`: Substitui os arquivos padrão do Nginx.

Verifique se o container está em execução:

```bash
docker ps
```

![alt text](<../assets/to_README/01 - DOCKER PS.png>)

<br>

---

### 3. Acessar a landing page no navegador

Acesse no navegador:

```
http://localhost:8080
```

![alt text](<../assets/to_README/01 - TESTE.png>)

A página deverá estar funcional e refletindo os arquivos clonados.

<br>

---

## Finalização

Para remover o ambiente criado após os testes:

```bash
docker stop nginx-tailwind && docker rm nginx-tailwind
```

<br>

---

## Considerações Finais

- Este exercício **não requer a criação de uma imagem personalizada**.