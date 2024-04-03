FROM golang:1.22-alpine as builder

# set workdir folder
WORKDIR /usr/src/app

# copy source code from local folder to container
COPY go/ .

RUN CGO_ENABLED=0 GOOS=linux go build app.go

FROM scratch

# set workdir folder
WORKDIR /usr/src/app
# copy compiled files to light image
COPY --from=builder /usr/src/app/app .

ENTRYPOINT [ "./app" ]