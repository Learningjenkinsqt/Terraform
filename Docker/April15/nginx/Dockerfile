FROM ubuntu:22.04
LABEL author="Prakash" organization="qualitythought"
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install nginx -y
RUN apt install php8.1-fpm -y
RUN chmod -R 777 /var/www/html
RUN	echo "<? php phpinfo();?>" > /var/www/html/info.php
RUN systemctl restart nginx
EXPOSE 80
CMD ["nginx","-g", "daemon off;"]