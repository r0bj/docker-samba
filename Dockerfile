FROM alpine:3.21

# gettext required for envsubst
RUN apk add --no-cache bash gettext samba

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

COPY smb.conf.tmpl .

ENTRYPOINT ["/docker-entrypoint.sh"]
