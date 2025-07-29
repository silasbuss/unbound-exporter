FROM golang:1.22-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git

RUN git clone https://github.com/silasbuss/unbound-exporter.git .

RUN go build -o unbound-exporter .

FROM alpine:latest

WORKDIR /usr/local/bin

COPY --from=builder /app/unbound-exporter .

CMD ["./unbound-exporter", "-u", "unix:///unbound/unbound.sock", "-a", "0.0.0.0:9167"]
