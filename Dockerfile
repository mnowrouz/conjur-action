FROM alpine:3.19

# Set up apk to ignore SSL certificate errors
RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/v3.19/main/ ca-certificates wget && \
    wget -O /etc/apk/repositories https://raw.githubusercontent.com/alpinelinux/alpine-conf/master/alpine-apkrepos/etc/apk/repositories && \
    sed -i 's/https/http/g' /etc/apk/repositories


RUN apk update && apk add --no-cache ca-certificates
RUN update-ca-certificates

RUN apk add --no-cache bash curl jq

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
