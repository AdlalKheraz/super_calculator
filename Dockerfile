FROM golang:1.19-buster AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o /calculator

FROM gcr.io/distroless/base-debian10:sha256-0828a5cfb40820d9110d4fb379edfca129ff5ec01d32d4f8acfd60173e2c49f3.sig

WORKDIR /

COPY --from=build /calculator /calculator

USER nonroot:nonroot

ENTRYPOINT ["/calculator"]
