FROM alpine:3.6

RUN apk update && apk add squid bash openssl
COPY ./squid.conf /etc/squid.conf
COPY ./start.sh /bin/start.sh

RUN chmod +x /bin/start.sh

ENV CACHE_SIZE_MB=10000 TARGET_REGISTRY_IP=172.17.0.1 TARGET_REGISTRY_PORT=443
RUN openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=US/ST=NC/L=Local/O=Dev/CN=mysite.local" -keyout /etc/ssl/key.pem -out /etc/ssl/cert.pem
CMD [ "/bin/start.sh" ]