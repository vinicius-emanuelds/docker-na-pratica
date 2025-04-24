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
