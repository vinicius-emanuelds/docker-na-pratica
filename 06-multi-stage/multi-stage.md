Claro! Aqui está a documentação em **Markdown**, com um passo a passo completo e didático sobre como construir e executar uma imagem Docker multi-stage para uma aplicação Go, com foco na **otimização e compatibilidade** usando **compilação estática**.

---

```markdown
# 🐳 Construção de Imagem Docker Multi-Stage para Aplicação Go (GS Ping)

Este guia apresenta o passo a passo para criar uma imagem Docker multi-stage otimizada para uma aplicação escrita em Go, utilizando como base o projeto **GS Ping**.

## 📁 Estrutura Inicial do Projeto

Após clonar o repositório e remover os Dockerfiles antigos, a estrutura base é:

```
06-multi-stage/
├── go.mod
├── go.sum
├── main.go
└── main_test.go
```

---

## ⚙️ Objetivo

- Utilizar **Docker multi-stage build** para gerar uma imagem enxuta.
- Compilar o binário Go de forma **estática**, eliminando dependências como `glibc`.
- Executar o container mapeando a porta 8080.

---

## 🛠️ Dockerfile

Crie um arquivo chamado `Dockerfile` na raiz do projeto com o seguinte conteúdo:

```dockerfile
# Etapa 1: Build
FROM golang:1.24 AS builder

# Diretório de trabalho
WORKDIR /app-go

# Copia os arquivos de dependências
COPY go.mod go.sum ./
RUN go mod download

# Copia o restante do projeto
COPY . .

# Compila o binário de forma estática (sem dependência do sistema)
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Etapa 2: Imagem final
FROM debian:bullseye-slim

WORKDIR /root/

# Copia apenas o binário compilado
COPY --from=builder /app-go/main .

# Expõe a porta padrão da aplicação
EXPOSE 8080

# Comando padrão ao iniciar o container
CMD ["./main"]
```

---

## 🧪 Build e Execução

Execute os comandos abaixo no terminal para construir a imagem e rodar o container:

```bash
# Construir a imagem
docker build -t go-app .

# Executar o container mapeando a porta 8080
docker run -t -p 8080:8080 --name multi-stage go-app
```

---

## ✅ Benefícios do Multi-Stage com Build Estático

| Aspecto                  | Vantagem                                                  |
|--------------------------|-----------------------------------------------------------|
| Tamanho da Imagem Final  | Redução significativa (sem dependências do sistema Go)    |
| Portabilidade            | Pode rodar em qualquer base Linux, inclusive Alpine       |
| Segurança                | Menor superfície de ataque                                |
| Performance              | Binário nativo otimizado para Linux                       |

---

## 📌 Considerações Finais

- O uso de `CGO_ENABLED=0` + `GOOS=linux` garante um binário estático, portável e independente da `glibc`.
- Esse padrão é ideal para containers minimalistas.
- O multi-stage separa o ambiente de build (Go completo) do ambiente de execução (minimalista), garantindo performance e segurança.

---

> Documentação elaborada para fins educacionais e práticos no contexto do projeto **Docker na Prática**.
```

---

Se quiser, posso salvar isso em um arquivo `README.md` para você. Deseja isso?