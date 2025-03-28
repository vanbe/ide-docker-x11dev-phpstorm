FROM ubuntu:latest

USER root

ENV PHP_PREFIX=/home/ubuntu/ressources/php/8.2.10 \
    COMPOSER_HOME=/home/ubuntu/ressources/composer \
    SYMFONY_HOME=/home/ubuntu/ressources/symfony

# Installation des dépendances
RUN apt update && apt install -y \
    # Utilitaires
    wget \
    curl \
    unzip \
    git \
    nano \
    jq \
    # X11 deviation
    libx11-6 \
    libxrender1 \
    libxtst6 \
    libfreetype6 \
    libxi6 \
    x11-apps \
    # Runtime dependencies PHP
    libxml2 \
    libcurl4 \
    libonig5 \
    libzip4 \
    libsqlite3-0 \
    libssl3 \
    libedit2 \
    # For running PhpStorm with ubuntu user
    sudo \ 
    && rm -rf /var/lib/apt/lists/*

# Téléchargement et installation de PhpStorm
WORKDIR /home/ubuntu

RUN mkdir /home/ubuntu/workspace && \
	mkdir /home/ubuntu/ressources && \
	mkdir /home/ubuntu/ressources/php && \
	mkdir ${COMPOSER_HOME} && \
	mkdir ${PHP_PREFIX} && \
	mkdir ${SYMFONY_HOME} 
RUN git config --global --add safe.directory /home/ubuntu/workspace 

COPY --from=php-builder:8.2.10 /opt/php/8.2.10 ${PHP_PREFIX} 
COPY --from=composer:latest /usr/bin/composer ${COMPOSER_HOME}
COPY --from=symfony-cli:latest /usr/local/bin/symfony ${SYMFONY_HOME}
COPY --from=phpstorm-downloader:latest /root/ /home/ubuntu

# PhpStorm Plugin "Php Inspections (EA Extended)"
RUN /home/ubuntu/PhpStorm/bin/phpstorm installPlugins de.espend.idea.php.annotation
# PhpStorm Plugin "Symfony Support"
RUN /home/ubuntu/PhpStorm/bin/phpstorm installPlugins fr.adrienbrault.idea.symfony2plugin
# PhpStorm Plugin "PHP Annotations"
RUN /home/ubuntu/PhpStorm/bin/phpstorm installPlugins de.espend.idea.php.annotation

# Changer de propriétaire pour éviter les problèmes de permission
RUN chown -R ubuntu:ubuntu /home/ubuntu
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "export PATH=\"${PHP_PREFIX}/bin:\$PATH\"" | tee -a /etc/environment
RUN echo "export PATH=\"${COMPOSER_HOME}:\$PATH\"" | tee -a /etc/environment
RUN echo "export PATH=\"${SYMFONY_HOME}:\$PATH\"" | tee -a /etc/environment
RUN echo "source /etc/environment" >> /etc/bash.bashrc

# Commande pour lancer PhpStorm
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
