# Étape 1 : Téléchargement de Symfony CLI
FROM alpine:latest as symfony-cli
RUN apk add --no-cache curl bash
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony
