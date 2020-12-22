FROM php:7-apache
LABEL maintainer="Sebastian Goetsch"

RUN docker-php-ext-install -j$(nproc) mysqli
RUN docker-php-ext-install -j$(nproc) pdo 
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN \
 apt update && \ 
 apt install unzip && \
 curl -o /tmp/ProjectSend.zip -L "https://www.projectsend.org/download/387/" && \
 unzip /tmp/ProjectSend.zip -d /var/www/html/ && \
 chown -R www-data /var/www/html/ && \
 rm -rf /tmp/* && \
 apt clean
RUN mkdir -p /defaults/ && \
 mv /var/www/html/upload /defaults/

COPY  start.sh /scripts/

CMD ["/bin/bash", "/scripts/start.sh"]

EXPOSE 80