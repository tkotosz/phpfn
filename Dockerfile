FROM fnproject/php:dev as build-stage
WORKDIR /build
ADD composer.json /build/
RUN composer install

FROM fnproject/php
RUN apk add --no-cache php7-sockets
WORKDIR /function
ADD . /function/
COPY --from=build-stage /build/vendor/ /function/vendor/
ENTRYPOINT ["php", "func.php"]
