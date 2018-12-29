FROM fnproject/base as build-stage
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
  && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add --no-cache php7 php7-openssl php7-phar php7-json php7-curl php7-iconv \
  && apk add --no-cache build-base curl
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
WORKDIR /function
ADD composer.json /function/
RUN composer install

FROM fnproject/base
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
  && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add --no-cache php7 php7-openssl php7-phar php7-json php7-curl php7-iconv php7-sockets \
  && apk add --no-cache build-base curl
WORKDIR /function
ADD . /function/
COPY --from=build-stage /function/vendor/ /function/vendor/
ENTRYPOINT ["php", "func.php"]


