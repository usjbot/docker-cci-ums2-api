FROM circleci/php:7.3-node-browsers

# RUN sudo apt-get install -y libsqlite3-dev zlib1g-dev && \
#     sudo pecl install apcu-5.1.18 && \
#     sudo docker-php-ext-install zip pdo_sqlite && \
#     sudo docker-php-ext-enable --ini-name 20-apcu.ini apcu

ENV PERSISTENT_DEPS libpq5 libldap-common zlib1g libicu63 zip librabbitmq4

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    $PERSISTENT_DEPS \
    git && \
    sudo rm -rf /var/lib/apt/lists/*

ENV BUILD_DEPS libc-client-dev libpq-dev libldap-dev zlib1g-dev libicu-dev libkrb5-dev libgcrypt20-dev libmagickwand-dev libzip-dev librabbitmq-dev

ENV APCU_VERSION 5.1.18
ENV XDEBUG_VERSION 2.9.0

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    $BUILD_DEPS && \
    sudo docker-php-ext-configure imap --with-kerberos --with-imap-ssl  && \
    sudo docker-php-ext-install intl pdo_mysql pdo_pgsql zip bcmath ldap imap sockets gd && \
    sudo pecl install apcu-${APCU_VERSION} redis imagick xdebug-${XDEBUG_VERSION} amqp && \
    sudo docker-php-ext-enable --ini-name 20-apcu.ini apcu && \
    sudo docker-php-ext-enable --ini-name 05-opcache.ini opcache && \
    sudo docker-php-ext-enable redis && \
    sudo docker-php-ext-enable --ini-name 06-imagick.ini imagick && \
    sudo docker-php-ext-enable --ini-name 07-imap.ini imap && \
    sudo docker-php-ext-enable ldap sockets gd amqp && \
    sudo rm -rf /var/lib/apt/lists/*