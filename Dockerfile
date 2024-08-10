FROM golang:alpine as builder

WORKDIR /build
COPY ./ ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o ./main

FROM alpine

RUN apk update --no-cache && apk add --no-cache ca-certificates tzdata
ENV TZ Asia/Tehran

WORKDIR /app
COPY --from=builder /build/main ./main
EXPOSE 8080
ENTRYPOINT ["./main"]
