# Estágio de compilação
FROM golang:1.22-alpine as builder

# Instalar ferramentas necessárias para a compilação (se necessário).
# RUN apk add --no-cache git

# Definir o diretório de trabalho
WORKDIR /

# Cache das dependências
# COPY go.mod go.sum ./
COPY go.mod ./
# RUN go mod download

# Copiar os arquivos do projeto
COPY . .

# Compilar o aplicativo. Desativa CGO para criar um binário estático
# e permite que o aplicativo seja executado em uma imagem base alpine sem libc.
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Estágio de execução
FROM alpine:latest  

# Adicionar um usuário não root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Adiciona suporte para HTTPS
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Copiar o binário do construtor para o diretório de trabalho
COPY --from=builder /main .

# Mudar para o usuário não root
USER appuser

# Comando para executar o aplicativo binário
ENTRYPOINT ["./main"]