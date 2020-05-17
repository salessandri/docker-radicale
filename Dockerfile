FROM alpine:3.11

LABEL maintainer="Santiago Alessandri <docker-radicale@salessandri.name>"

ARG RADICALE_VERSION=2.1.11

RUN apk add --no-cache \
        python3 && \
    apk add --no-cache --virtual build-dependencies \
        build-base \
        gcc \
        python3-dev \
        libffi-dev && \
    python3 -m pip install \
        Radicale==${RADICALE_VERSION} \
        bcrypt==3.1.7 \
        passlib==1.7.2 && \
    apk del build-dependencies

EXPOSE 5232

ENTRYPOINT ["/usr/bin/python3", "-m", "radicale"]
