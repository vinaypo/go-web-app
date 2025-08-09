# --------------------------------------------------------
#          with multi-stage build
# --------------------------------------------------------
    
FROM golang:1.22 as builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./main"]

# --------------------------------------------------------
#          without multi-stage build
# --------------------------------------------------------
# FROM golang:1.22

# WORKDIR /app

# COPY go.mod ./

# RUN go mod download

# COPY . .

# RUN go build -o main .

# EXPOSE 8080

# CMD ["./main"]