FROM alpine:3.15

LABEL maintainer="Santiago Alessandri <docker-radicale@salessandri.name>"

ARG RADICALE_VERSION=3.1.5

RUN apk add --no-cache \
        python3 \
        py3-pip && \
    apk add --no-cache --virtual build-dependencies \
        build-base \
        gcc \
        python3-dev \
        libffi-dev && \
    python3 -m pip install \
        wheel && \
    python3 -m pip install \
        Radicale==${RADICALE_VERSION} \
        bcrypt==3.2.0 \
        passlib==1.7.4 && \
    apk del build-dependencies

EXPOSE 5232

ENTRYPOINT ["/usr/bin/python3", "-m", "radicale"]
