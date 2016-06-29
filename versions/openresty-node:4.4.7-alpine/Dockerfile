FROM jessegreathouse/openresty:1.9.15-alpine
MAINTAINER Jesse Greathouse <jesse@greathouse.technology>

ENV NODE_VERSION=v4.4.7

# Get core utils
RUN apk add --no-cache linux-headers nasm libpng-dev libjpeg-turbo-dev giflib-dev

ADD opt/node-$NODE_VERSION.tar.gz /app/opt/

WORKDIR /app/opt/node-$NODE_VERSION

RUN /app/opt/node-$NODE_VERSION/configure --prefix=/app/opt/node
RUN make
RUN make install

RUN rm -rf /app/opt/node-$NODE_VERSION
RUN ln -sf /app/opt/node/bin/node /app/bin/node
RUN ln -sf /app/opt/node/bin/npm /app/bin/npm

# Expose ports
EXPOSE 80

CMD ["nginx", "-p", "/app/opt/openresty/nginx",  "-c", "/app/etc/nginx/nginx.conf"]