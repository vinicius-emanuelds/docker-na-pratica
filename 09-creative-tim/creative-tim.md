Seu Dockerfile para o exercício 9 tem a ideia certa, mas há um **erro na linha de clonagem do repositório**. O comando `RUN https://...` não é válido.

Você precisa **usar o `git clone`** e **copiar os arquivos corretos para o diretório do Nginx**.

---

### ✅ Dockerfile corrigido para o Exercício 9

```Dockerfile
FROM nginx

# Mantém o Nginx em execução em foreground
CMD ["nginx", "-g", "daemon off;"]

# Instala o Git
RUN apt-get update && apt-get install -y git

# Clona a landing page do Creative Tim
RUN git clone https://github.com/creativetimofficial/material-kit.git /tmp/material-kit

# Copia os arquivos da landing page para o diretório padrão do Nginx
RUN cp -r /tmp/material-kit/* /usr/share/nginx/html/
```

---

### 📄 Documentação em Markdown

```markdown
# Exercício 9 – Criando uma Imagem Personalizada com Nginx

## Objetivo

Criar uma imagem Docker personalizada baseada no Nginx, incorporando uma landing page estática do Creative Tim. O container resultante deve ser capaz de servir o conteúdo HTML/CSS automaticamente ao ser iniciado.

---

## Estrutura do Dockerfile

```Dockerfile
FROM nginx

CMD ["nginx", "-g", "daemon off;"]

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/creativetimofficial/material-kit.git /tmp/material-kit

RUN cp -r /tmp/material-kit/* /usr/share/nginx/html/
```

---

## Passo a Passo

### 1. Criar o Dockerfile

Crie um arquivo chamado `Dockerfile` com o conteúdo acima no diretório do seu projeto.

### 2. Construir a imagem personalizada

```bash
docker build -t custom-nginx-material-kit .
```

### 3. Rodar o container

```bash
docker run -d --name custom-web -p 8080:80 custom-nginx-material-kit
```

### 4. Acessar no navegador

Abra:

```
http://localhost:8080
```

Você verá a landing page estática do Creative Tim sendo servida via Nginx.

---

## Finalização

Para remover o container e a imagem:

```bash
docker stop custom-web && docker rm custom-web
docker rmi custom-nginx-material-kit
```

---

## Considerações

- Este exercício envolve a **criação de uma imagem personalizada com Dockerfile**.
- A landing page é incluída na imagem durante o processo de build.
- Esse padrão é útil para deploys em produção com conteúdo estático.

```

Se desejar, posso te mostrar como otimizar esse Dockerfile com `multi-stage build` ou sem instalar o Git. Deseja essa melhoria?