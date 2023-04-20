

FROM ubuntu:22.04
LABEL author="Prakash" organization="qualitythought"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install nginx -y
RUN apt install php8.1-fpm -y
RUN chmod -R 777 /var/www/html
RUN	echo "<?php phpinfo() ?>" >> /var/www/html/info.php
RUN systemctl restart nginx
EXPOSE 80
CMD ["nginx","-g", "daemon off;"]



FROM ubuntu:22.04
LABEL author="Prakash" organization="qualitythought"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install nginx -y
RUN apt install php8.1-fpm -y
RUN chmod -R 777 /var/www/html
RUN	echo "<?php phpinfo() ?>" >> /var/www/html/info.php
RUN service nginx restart
EXPOSE 80
CMD ["nginx","-g", "daemon off;"]



# Base image
FROM nginx:latest

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Define variables
ARG PHP_VERSION=7.4
ENV PHP_VERSION=${PHP_VERSION}

# Install PHP and other required packages
RUN apt-get update && \
    apt-get install -y \
        php${PHP_VERSION} \
        php${PHP_VERSION}-fpm \
        && \
    rm -rf /var/lib/apt/lists/*

# Copy the PHPinfo page to the working directory
COPY phpinfo.php .

# Configure Nginx to run PHP
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx and PHP-FPM
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]