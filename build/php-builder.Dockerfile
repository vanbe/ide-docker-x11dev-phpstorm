# Étape 1: Construction de PHP
FROM ubuntu:latest as php-builder

# Installer les dépendances de compilation
RUN apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    libbz2-dev \
    libcurl4-openssl-dev \
    libedit-dev \
    libonig-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libzip-dev \
    pkg-config \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Télécharger et compiler PHP
WORKDIR /build
RUN wget https://www.php.net/distributions/php-8.2.10.tar.xz && \
    tar xf php-8.2.10.tar.xz && \
    cd php-8.2.10 && \
    ./configure --prefix=/opt/php/8.2.10 \
               --with-openssl \
               --with-zip \
               --enable-mbstring \
               --with-curl && \
    make -j$(nproc) && \
    make install && \
    rm -rf /build/*
