# Criando Containers com Usuário Não-Root
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivo

Demonstrar como criar uma imagem Docker segura, executando uma aplicação com um usuário não-root. Isso reduz os riscos de segurança ao isolar o processo de execução de privilégios elevados.

<br>

---

## Tecnologias Utilizadas

- Docker
- Python 3.12 (imagem Alpine)
- Aplicação simples em Python (ex: `app.py` + `requirements.txt`)

<br>

---

## Etapas

### 1. Estrutura do Projeto

```
.
├── Dockerfile
├── app.py
└── requirements.txt
```

<br>




### 2. Conteúdo do Dockerfile

```Dockerfile
FROM python:3.12-alpine

RUN addgroup -S docker_pratica && adduser -S admin -G docker_pratica

WORKDIR /app

RUN chown -R admin:docker_pratica /app

COPY requirements.txt .

RUN pip install --no-cache-dir  -r requirements.txt

COPY . /app

USER admin

ENTRYPOINT ["python3"]

CMD ["app.py"]

EXPOSE 5000
```

<br>



## 3. Construção da Imagem

```bash
docker build -t no-root .
```

![alt text](<../assets/to_README/10 - BUILD.png>)

<br>


## 4. Execução do Container

```bash
docker run -d -p 5000:5000 --name no-root no-root
```
![alt text](<../assets/to_README/10 - RUN.png>)

<br>


## 5. Verificação do Usuário de Execução

Para confirmar que o processo está sendo executado pelo usuário `admin`:

```bash
docker exec -it no-root whoami
```

**Saída esperada:**

```
admin
```

![alt text](<../assets/to_README/10 - TESTE WHOAMI.png>)

Você também pode verificar se a aplicação está acessível na porta 5000 do host. Digite o seguinte comando no seu navegador:

```bash
http://localhost:5000
```

![alt text](<../assets/to_README/10 - TESTE.png>)

<br>

---

## Considerações

- **Nunca execute aplicações como root**, exceto se absolutamente necessário.
- Utilizar imagens base Alpine reduz a superfície de ataque e o tamanho da imagem.
- O uso de `USER` no Dockerfile é uma prática recomendada de segurança.