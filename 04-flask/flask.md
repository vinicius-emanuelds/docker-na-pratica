# Aplicação Flask com Dockerfile
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Objetivos

- Criar uma aplicação simples com Flask que responda a uma requisição HTTP.
- Construir uma imagem Docker com `Dockerfile` personalizado.
- Executar a aplicação em um container Docker.

<br>

---

## Pré-requisitos

- Docker instalado e funcional
- Acesso a terminal ou CLI compatível com Unix (Linux, macOS ou WSL)

<br>

---

## Estrutura dos Arquivos

O projeto deverá conter os seguintes arquivos:

```
/docker-flask-app
│
├── app.py
├── Dockerfile
└── requirements.txt
```

<br>


### `app.py`

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Olá, mundo!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

<br>

### `requirements.txt`

```
flask
```

<br>

### `Dockerfile`

```Dockerfile
FROM python:3.12-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app

ENTRYPOINT ["python3"]
CMD ["app.py"]

EXPOSE 5000
```


**Explicações rápidas:**
- `FROM python:3.12-alpine`: Imagem leve do Python 3.12 baseada em Alpine Linux.
- `WORKDIR /app`: Define o diretório de trabalho.
- `COPY requirements.txt .`: Copia o arquivo de dependências.
- `RUN pip install ...`: Instala o Flask.
- `COPY . /app`: Copia os arquivos da aplicação.
- `ENTRYPOINT` e `CMD`: Iniciam a aplicação com `python3 app.py`.
- `EXPOSE 5000`: Expõe a porta 5000 para acesso à aplicação.

<br>

---

## Etapas de Execução

### 1. Construir a imagem Docker

Navegue até o diretório onde estão os arquivos e execute:

```bash
docker build -t flask .
```
![alt text](<../assets/to_README/4 - BUILD.png>)

<br>

---

### 2. Rodar o container

```bash
docker run -d -p 5000:5000 --name flask flask
```

![alt text](<../assets/to_README/4 - RUN.png>)

- `-d`: executa o container em segundo plano
- `-p 5000:5000`: mapeia a porta da aplicação para o host
- `--name`: define um nome personalizado para o container

<br>

---

### 3. Acessar a aplicação

No navegador, acesse:

```
http://localhost:5000
```

A mensagem **"Olá, mundo!"** será exibida como resposta ao endpoint raiz.

![alt text](<../assets/to_README/4 - TESTE.png>)

<br>

---

## Finalização

Para parar e remover o container:

```bash
docker stop flask && docker rm flask
```

Se desejar remover a imagem:

```bash
docker rmi flask
```

<br>

---

## 📌 Considerações Finais

- Utilize o `requirements.txt` para manter dependências organizadas e reprodutíveis.