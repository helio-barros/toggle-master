FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

# Resolve/baixa novas deps OTel e atualiza go.sum
RUN go mod tidy

RUN CGO_ENABLED=0 go build -o evaluation-service .


FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/evaluation-service .

EXPOSE 8004

CMD ["./evaluation-service"] 