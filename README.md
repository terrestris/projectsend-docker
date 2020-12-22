# projectsend-docker

Creates a docker image for projectsend. (https://www.projectsend.org/)

Influenced by https://github.com/linuxserver/docker-projectsend.

# About

This image is based on "php:7-apache" and projectsend r1295.

See Dockerfile for more infos.

# Usage

You can use the supplied docker-compose.yml:

    version: "3.0"
    services:
      web:
        restart: unless-stopped
        image: terrestris/projectsend:latest
        volumes:
          - /opt/projectsend/config:/config
          - /opt/projectsend/data:/data
        ports:
          - "8080:80"
      mysql:
        restart: unless-stopped
        image: mariadb:10.5
        volumes:
          - /opt/mariadb_data:/var/lib/mysql
        environment:
          MYSQL_ROOT_PASSWORD: password
          MYSQL_DATABASE: projectsend
          MYSQL_USER: projectsend
          MYSQL_PASSWORD: projectsend

If you have your own MySQL-DB you can of course use that as well.

After starting the compose-file you can access projectsend on http://localhost:8080.

You should see the install-script where you have to enter the database-credentials etc.  After that, you're good to go.