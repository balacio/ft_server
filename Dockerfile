FROM debian:buster

ENV AUTOINDEX on

RUN apt-get update && apt-get install -y \
    nginx \
    mariadb-server \
    php-fpm \
    php-mysql \
    php-mbstring \
    wget \
	vim

COPY /srcs/.bashrc /root/.bashrc
COPY /srcs/.vimrc /root/.vimrc

# NGINX
RUN     echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN		rm var/www/html/index.nginx-debian.html
COPY	srcs/nginx/*.conf /tmp/

# PHPMYADMIN
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz && \
    tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
    mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-5.0.2-english.tar.gz
COPY srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin

# WordPress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf latest.tar.gz
COPY srcs/wordpress/wp-config.php /var/www/html/wordpress

# SSL
RUN mkdir ~/mkcert && cd ~/mkcert && \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 && \
	mv mkcert-v1.4.1-linux-amd64 mkcert && chmod +x mkcert && \
	./mkcert -install && ./mkcert localhost

RUN	chown -R www-data:www-data /var/www/html/*

COPY srcs/*.sh ./

EXPOSE 80 443

CMD bash start.sh
