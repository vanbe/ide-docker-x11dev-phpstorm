# Étape 1 : Téléchargement de PHPSTORM
FROM alpine:latest as phpstorm-downloader
RUN apk add --no-cache wget tar bash

ARG PHPStorm_VERSION=2024.3.5

WORKDIR ${/root/}

RUN wget -qO- https://download.jetbrains.com/webide/PhpStorm-${PHPStorm_VERSION}.tar.gz -O /tmp/PhpStorm.tar.gz

RUN mkdir /tmp/PhpStorm && \
        tar -xzf /tmp/PhpStorm.tar.gz -C /tmp/PhpStorm --strip-components=1 && \
        mv /tmp/PhpStorm /root/ && \
	rm -rf /tmp/*

