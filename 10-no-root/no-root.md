Segue a documentação em **Markdown** para o exercício de execução de containers Docker com **usuário não-root**:

---

```markdown
# Exercício – Criando Containers com Usuário Não-Root

## Objetivo

Demonstrar como criar uma imagem Docker segura, executando uma aplicação com um usuário não-root. Isso reduz os riscos de segurança ao isolar o processo de execução de privilégios elevados.

---

## Tecnologias Utilizadas

- Docker
- Python 3.12 (imagem Alpine)
- Aplicação simples em Python (ex: `app.py` + `requirements.txt`)

---

## Etapas

### 1. Estrutura do Projeto

```
.
├── Dockerfile
├── app.py
└── requirements.txt
```

### 2. Conteúdo do Dockerfile

```Dockerfile
FROM python:3.12-alpine

# Criação de grupo e usuário sem privilégios
RUN addgroup -S docker_pratica && adduser -S admin -G docker_pratica

# Diretório da aplicação
WORKDIR /app

# Copiando código-fonte e ajustando permissões
COPY . /app
RUN chown -R admin:docker_pratica /app

# Instalação de dependências
RUN pip install --no-cache-dir -r /app/requirements.txt

# Define o usuário não-root como padrão
USER admin

# Definição do ponto de entrada e comando padrão
ENTRYPOINT ["python3"]
CMD ["app.py"]

# Exposição da porta
EXPOSE 5000
```

---

## 3. Construção da Imagem

```bash
docker build -t python-nao-root .
```

---

## 4. Execução do Container

```bash
docker run -d --name app-nao-root -p 5000:5000 python-nao-root
```

---

## 5. Verificação do Usuário de Execução

Para confirmar que o processo está sendo executado pelo usuário `admin`:

```bash
docker exec -it app-nao-root whoami
```

**Saída esperada:**

```
admin
```

---

## Considerações

- **Nunca execute aplicações como root**, exceto se absolutamente necessário.
- Utilizar imagens base Alpine reduz a superfície de ataque e o tamanho da imagem.
- O uso de `USER` no Dockerfile é uma prática recomendada de segurança.

---

## Remoção do Container

```bash
docker stop app-nao-root && docker rm app-nao-root
docker rmi python-nao-root
```

```

Se quiser, posso complementar com um diagrama de segurança ou checklist de hardening para containers. Deseja esse reforço?