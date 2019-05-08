FROM circleci/php:7.2-node-browsers

RUN gosu apt install -y libsqlite3-dev zlib1g-dev libldap-common libldap-dev && \
    gosu pecl install apcu-5.1.8 && \
    gosu docker-php-ext-install zip pdo_sqlite ldap && \
    gosu docker-php-ext-enable --ini-name 20-apcu.ini apcu && \
    gosu docker-php-ext-enable ldap