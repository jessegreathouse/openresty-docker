FROM alpine:3.4
MAINTAINER Jesse Greathouse <jesse@greathouse.technology>

ENV OPENRESTY_VERSION=1.9.15.1
ENV PATH /app/bin:$PATH

# Get core utils
RUN apk add --no-cache \
    build-base autoconf openssl openssh perl python git \
    libc-dev readline-dev openssl-dev pcre-dev ncurses-libs

# Add preliminary file structure
RUN mkdir /app
RUN mkdir /app/bin
RUN mkdir /app/etc
RUN mkdir /app/opt
RUN mkdir /app/tmp
RUN mkdir /app/tmp/session
RUN mkdir /app/var
RUN mkdir /app/var/cache
RUN mkdir /app/var/logs
ADD opt/openresty-$OPENRESTY_VERSION.tar.gz /app/opt/

WORKDIR /app/opt/openresty-$OPENRESTY_VERSION

RUN /app/opt/openresty-$OPENRESTY_VERSION/configure --with-cc-opt="-I/usr/local/include -I/usr/local/opt/openssl/include" \
            --with-ld-opt="-L/usr/local/lib -L/usr/local/opt/openssl/lib" \
            --prefix=/app/opt/openresty \
            --with-pcre-jit \
            --with-ipv6 \
            --with-http_iconv_module \
            --with-http_realip_module \
            -j2
RUN make
RUN make install

RUN rm -rf /app/opt/openresty-$OPENRESTY_VERSION
RUN ln -sf /app/opt/openresty/nginx/sbin/nginx /app/bin/nginx

ADD etc/nginx /app/etc/nginx

# Expose ports
EXPOSE 80

CMD ["nginx", "-p", "/app/opt/openresty/nginx",  "-c", "/app/etc/nginx/nginx.conf"]