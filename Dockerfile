FROM alpine:latest as build-stage
RUN apk add --no-cache php7 php7-openssl php7-phar php7-json php7-curl php7-iconv
RUN apk add --no-cache build-base curl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
WORKDIR /function
ADD composer.json /function/
RUN composer install

FROM alpine:latest
RUN apk add --no-cache php7 php7-openssl php7-phar php7-json php7-curl php7-iconv php7-sockets
WORKDIR /function
ADD . /function/
COPY --from=build-stage /function/vendor/ /function/vendor/
ENTRYPOINT ["php", "func.php"]
