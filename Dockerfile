FROM ubuntu:24.04

RUN apt-get update && apt-get install -y nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

COPY ./src/default /etc/nginx/sites-available/default

CMD ["nginx"]

EXPOSE 10443 10080
