# ----------- Estágio 1: Build -----------
FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

# Copia o restante do código-fonte
COPY . .

RUN CGO_ENABLED=0 go build -o auth-service .

# ----------- Estágio 2: Runtime -----------
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/auth-service .

EXPOSE 8001

CMD ["./auth-service"]
