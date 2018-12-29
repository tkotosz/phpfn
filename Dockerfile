FROM delabassee/hotwrap:latest as hotwrap
FROM alpine:latest

RUN apk add --no-cache php7 php7-json

WORKDIR /function
ADD func.php /function/
COPY --from=hotwrap /hotwrap /hotwrap 

CMD /usr/bin/php func.php

ENTRYPOINT ["/hotwrap"]
