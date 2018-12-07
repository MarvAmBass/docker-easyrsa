FROM alpine:3.6

RUN apk add --no-cache bash \
                       openssl \
                       wget \
 \
 && wget --no-check-certificate -P /tmp https://github.com/OpenVPN/easy-rsa/releases/download/2.2.2/EasyRSA-2.2.2.tgz \
 && tar -xvzf /tmp/EasyRSA-*.tgz -C /tmp \
 && rm -v /tmp/EasyRSA-*/vars /tmp/EasyRSA-*.tgz \
 \
 && mv -v /tmp/EasyRSA-* /usr/share/easy-rsa \
 \
 && openssl dhparam -out /usr/share/easy-rsa/dh.pem 4096 \
 \
 && mkdir /ca

COPY root / 
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]

COPY vars /usr/share/easy-rsa/vars
COPY README.md /usr/share/easy-rsa/README.md
