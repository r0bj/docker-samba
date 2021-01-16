FROM alpine:3.13

ARG CONFD_VER=0.16.0

RUN wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 && chmod +x /usr/bin/confd \
  && apk add --no-cache bash samba

COPY etc /etc

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 137/udp 138/udp 139 445

ENTRYPOINT ["/docker-entrypoint.sh"]
