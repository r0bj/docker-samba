FROM alpine:3.15

ARG CONFD_VER=0.16.0

RUN wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 \
  && chmod +x /usr/bin/confd \
  && apk add --no-cache bash samba avahi \
  && sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

COPY etc /etc

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

RUN rm -f /etc/avahi/services/*
COPY samba.service /etc/avahi/services

ENTRYPOINT ["/docker-entrypoint.sh"]
