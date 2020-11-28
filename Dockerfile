FROM alpine:latest

RUN apk add --no-cache curl

COPY entrypoint.sh /usr/bin

ENTRYPOINT ["/usr/bin/entrypoint.sh"]