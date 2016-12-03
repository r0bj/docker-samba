FROM ubuntu:16.10

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install \
        --no-install-recommends \
        --fix-missing \
        --assume-yes \
        samba \
        wget \
        && apt-get --quiet --yes clean

RUN wget -qO /usr/bin/confd --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 && chmod +x /usr/bin/confd
COPY smb.toml /etc/confd/conf.d/smb.toml
COPY smb.conf.tmpl /etc/confd/templates/smb.conf.tmpl

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh 

EXPOSE 137/udp 138/udp 139 445

CMD ["/docker-entrypoint.sh"]
