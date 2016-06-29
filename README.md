# Openresty layer for combining PHP, Node.js

## Supported tags `Dockerfile` links

-   [`jessegreathouse/openresty:1.9.15-alpine`,  (*openresty:1.9.15-alpine/Dockerfile*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty:1.9.15-alpine/Dockerfile)
-   [`jessegreathouse/openresty-node:4.4.7-alpine`,  (*openresty-node:4.4.7-alpine/Dockerfile*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty-node:4.4.7-alpine/Dockerfile)
-   [`jessegreathouse/openresty-node:6.2.2-alpine`,  (*openresty-node:6.2.2-alpine/Dockerfile*)](https://github.com/jessegreathouse/openresty-docker/versions/openresty-node:6.2.2-alpine/Dockerfile)
-   [`jessegreathouse/openresty-php:7.0.7-alpine`,  (*openresty-php:7.0.7-alpine*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty-php:7.0.7-alpine/Dockerfile)
-   [`jessegreathouse/openresty-php:7.0.7-minimal-alpine`,  (*openresty-php:7.0.7-minimal-alpine*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty-php:7.0.7-minimal-alpine/Dockerfile)
-   [`jessegreathouse/openresty-node-php:7.0.7-node-4.4.7-alpine`,  (*openresty-node-php:7.0.7-node-4.4.7-alpine*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty-node-php:7.0.7-node-4.4.7-alpine/Dockerfile)
-   [`jessegreathouse/openresty-node-php:7.0.7-node-6.2.2-alpine`,  (*openresty-node-php:7.0.7-node-6.2.2-alpine*)](https://github.com/jessegreathouse/openresty-docker/blob/master/versions/openresty-node-php:7.0.7-node-6.2.2-alpine/Dockerfile)
    

Table of Contents
=================

* [Overview](#overview)
* [Directions](#directions)
* [Copyright & License](#copyright--license)

Overview
===========
The appeal to this brand of openresty based web server is the application layout, and layering in of PHP, Node.Js or both

I have multiple production applications using this app layout and it has gone through an interesting evolution since its 
conception. Through this repository I'm providing the fruits of that labor. A sensible project layout where everything 
stems from the root /app folder, including the components like openresty/nginx, php and Node.js

With this layout you can feel confident and truly have mastery over the configuration of your project. What this is not,
is an image to run your app with zero configuration. The image comes with a generic nginx (php, php-fpm, supervisor) 
configuration, however even if you can manage to use these generic configurations, you probably shouldn't. See the Next 
section for more information.

Directions
===========

This image provides a directory structure in which everything must stem from the root folder: /app. 

The structure is as follows:

* /app
* /app/bin
* /app/etc
* /app/tmp
* /app/tmp/session
* /app/var
* /app/var/cache
* /app/var/logs
* /app/opt
* /app/opt/openresty
* /app/opt/openresty/nginx
* /app/opt/openresty/node (Node.js versions only)
* /app/opt/openresty/php (PHP versions only)

The bin folder: /app/bin is added to $PATH and will have symlinks to relevant binaries:

* /app/bin/nginx
* /app/bin/node (Node.js versions only)
* /app/bin/npm (Node.js versions only)
* /app/bin/php (PHP versions only)
* /app/bin/phpize (PHP versions only)
* /app/bin/pecl (PHP versions only)
* /app/bin/pear (PHP versions only)

This image expects you to add your own necessary code/files inside this structure, for example:

* /app/src
* /app/web
* /app/test

The configurations for nginx and other components are very generic and probably should be overwritten in derived images:

* /app/etc/nginx/nginx.conf
* /app/etc/php/php.ini (PHP versions only)
* /app/etc/php/php-fpm.conf (PHP versions only)
* /app/etc/supervisor/conf.d/supervisord.conf (PHP versions only)

Your CMD line would look like this:

    CMD ["nginx", "-p", "/app/opt/openresty/nginx",  "-c", "/app/etc/nginx/nginx.conf"]

If you are using one of the PHP versions, you will need to run supervisor to manage the nginx and php-fpm processes:

    CMD ["/usr/bin/supervisord", "-c", "/app/etc/supervisor/conf.d/supervisord.conf"]


Copyright & License
===================

openresty-docker is licensed under the 2-clause BSD license.

Copyright (c) 2016, Jesse Greathouse <jesse@greathouse.technology>.

This module is licensed under the terms of the BSD license.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.