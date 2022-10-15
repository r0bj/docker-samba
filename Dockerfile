FROM alpine:3.16

RUN apk add --no-cache bash gettext samba avahi \
  && sed -i 's/#enable-dbus=yes/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY smb.conf.tmpl .

RUN rm -f /etc/avahi/services/*
COPY samba.service /etc/avahi/services

ENTRYPOINT ["/docker-entrypoint.sh"]
