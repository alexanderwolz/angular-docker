FROM node:24.9.0-alpine3.21
LABEL maintainer="mail@alexanderwolz.de"

RUN apk update && apk add --no-cache bash git curl \
    && deluser --remove-home node \
    && addgroup -S -g 1000 angular \
    && adduser -S -u 1000 angular -G angular \
    && chown angular:angular /home/angular \
    && npm install -g @angular/cli \
    && printf '#!/bin/sh\nng serve --host 0.0.0.0\n' >> /serve.sh \
    && chown angular /serve.sh && chmod +x /serve.sh \
    && echo 'alias run="bash /serve.sh"' >> /home/angular/.bashrc

WORKDIR /app

USER angular

ENV NG_CLI_ANALYTICS=false

CMD ["ng"]
