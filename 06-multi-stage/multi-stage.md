# Construção de Imagem Docker Multi-Stage para Aplicação Go (GS Ping)
##### [Voltar para a lista de exercícios](../README.md)

<br>

---

## Estrutura Inicial do Projeto

Após clonar o repositório e remover os Dockerfiles antigos, a estrutura base é:

```
06-multi-stage/
├── go.mod
├── go.sum
├── main.go
└── main_test.go
```

<br>

---

## Objetivo

- Utilizar **Docker multi-stage build** para gerar uma imagem enxuta.
- Compilar o binário Go de forma **estática**, eliminando dependências como `glibc`.
- Executar o container mapeando a porta 8080.

<br>

---

## Dockerfile

Crie um arquivo chamado `Dockerfile` na raiz do projeto com o seguinte conteúdo:

```dockerfile
FROM golang:1.24 AS builder

WORKDIR /app-go

COPY go.mod go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .


# A partir daqui, eu começo a gerar a imagem final, utilizando apenas o binário gerado pelo Golang


FROM debian:bullseye-slim

WORKDIR /root/

COPY --from=builder /app-go/main .

EXPOSE 8080

CMD ["./main"]
```

<br>

---

## Build e Execução

Execute os comandos abaixo no terminal para construir a imagem e rodar o container:

```bash
docker build -t go-app .
```
![alt text](<../assets/to_README/06 - BUILD.png>)

<br>

Executar o container mapeando a porta 8080
```bash
docker run -t -p 8080:8080 --name multi-stage go-app
```
![alt text](<../assets/to_README/06 - RUN.png>)

<br>

---

## Validação
No navegador, acesse:

```
http://localhost:5000
```

![alt text](<../assets/to_README/06 - TESTE.png>)

## Benefícios do Multi-Stage com Build Estático

| Aspecto                  | Vantagem                                                  |
|--------------------------|-----------------------------------------------------------|
| Tamanho da Imagem Final  | Redução significativa (sem dependências do sistema Go)    |
| Portabilidade            | Pode rodar em qualquer base Linux, inclusive Alpine       |
| Segurança                | Menor superfície de ataque                                |
| Performance              | Binário nativo otimizado para Linux                       |

<br>

---

## Considerações Finais

- O uso de `CGO_ENABLED=0` + `GOOS=linux` garante um binário estático, portável e independente da `glibc`.
- Esse padrão é ideal para containers minimalistas.
- O multi-stage separa o ambiente de build (Go completo) do ambiente de execução (minimalista), garantindo performance e segurança.