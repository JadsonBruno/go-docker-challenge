FROM golang:latest AS builder

WORKDIR /app

RUN go mod init fullcycle
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o main .

FROM scratch

WORKDIR /app

COPY --from=builder /app/main .

CMD ["./main"]
