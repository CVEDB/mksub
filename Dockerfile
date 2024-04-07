FROM golang:1.17.2-alpine AS build-env

RUN apk add git
ADD . /go/src/mksub
WORKDIR /go/src/mksub
RUN go build -o mksub

FROM alpine:3.14
LABEL licenses.mksub.name="MIT" \
      licenses.mksub.url="https://github.com/cvedb/mksub/blob/main/LICENSE" \
      licenses.golang.name="bsd-3-clause" \
      licenses.golang.url="https://go.dev/LICENSE?m=text"

COPY --from=build-env /go/src/mksub/mksub /bin/mksub

RUN mkdir -p /hive/in /hive/out

WORKDIR /app
RUN apk add bash

ENTRYPOINT [ "mksub" ]
