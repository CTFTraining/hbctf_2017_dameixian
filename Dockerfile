FROM php:7.0-fpm-alpine
LABEL Author="CoColi <cocolizdf@gmail.com>"
LABEL Blog="http://www.cocoli.top"

COPY ./ /tmp/

RUN sed -i 's/dl-cdn.alpinelinux.org/mirror.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk update \
    &&apk add --no-cache nginx mysql mysql-client\
    &&docker-php-source extract \
    &&docker-php-ext-install mysqli \
    &&docker-php-source delete\
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i -e 's/display_errors.*/display_errors = Off/' /usr/local/etc/php/php.ini \

    #mysql
    &&mysql_install_db --user=mysql --datadir=/var/lib/mysql\
    &&sh -c 'mysqld_safe &' \
    &&sleep 5s\
    &&mysqladmin -uroot password 'root' \
    &&mysql  -e "CREATE DATABASE  dsqli  DEFAULT CHARACTER SET utf8;"  -uroot  -proot\
    &&mysql -e "grant select,insert on dsqli.* to 'admin'@'localhost' identified by 'password987~!@' "  -uroot -proot   \ 
    &&mysql -e "use dsqli;source /tmp/dsqli.sql;"  -uroot -proot \
    &&rm /tmp/dsqli.sql \
    &&mkdir /run/nginx \
    #configure file 

    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    &&  mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    &&  mv /tmp/default /etc/nginx/conf.d/default.conf \

    #www
    &&mv /tmp/src/* /var/www/html \
    && chmod -R -w /var/www/html \
    && chmod 755 /var/www/html/Up10aDs \
    && chown -R www-data:www-data /var/www/html \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && rm -rf /tmp/* \
    && rm -rf /etc/apk

EXPOSE 80 3306
CMD ["sh","-c","docker-php-entrypoint"]