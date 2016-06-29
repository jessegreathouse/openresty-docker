FROM jessegreathouse/openresty:1.9.15-alpine
MAINTAINER Jesse Greathouse <jesse@greathouse.technology>

ENV PHP_VERSION=7.0.7
ENV DEBUG=false

# Get core utils
RUN apk add --no-cache libc6-compat curl-dev libssl1.0 libxml2-dev icu-dev libmcrypt-dev \
                       libxslt gmp-dev iso-codes py-curl libjpeg-turbo-dev \
                       libpng-dev bzip2-dev bzip2 supervisor re2c bison bash

ADD opt/php-$PHP_VERSION.tar.gz /app/opt/

WORKDIR /app/opt/php-$PHP_VERSION

RUN /app/opt/php-$PHP_VERSION/configure \
        --prefix=/app/opt/php \
        --with-config-file-path=/app/etc/php \
        --enable-opcache \
        --enable-zip \
        --enable-mbstring \
        --enable-bcmath \
        --enable-fpm \
        --enable-ftp \
        --enable-exif \
        --enable-calendar \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-wddx \
        --enable-intl \
        --with-gd \
        --with-curl \
        --with-mcrypt \
        --with-iconv \
        --with-gmp \
        --with-openssl \
        --enable-mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-mysql-sock=/app/tmp/mysql.sock
RUN make
RUN make install

RUN rm -rf /app/opt/php-$PHP_VERSION
RUN ln -sf /app/opt/php/bin/php /app/bin/php
RUN ln -sf /app/opt/php/bin/pear /app/bin/pear
RUN ln -sf /app/opt/php/bin/pecl /app/bin/pecl
RUN ln -sf /app/opt/php/bin/phpize /app/bin/phpize
RUN touch /app/error.log

ADD bin/configure_opcache.sh /app/bin/configure_opcache.sh
ADD etc /app/etc
ADD web /app/web

# Expose ports
EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/app/etc/supervisor/conf.d/supervisord.conf"]