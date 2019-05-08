FROM circleci/php:7.2-node-browsers

RUN sudo apt-get install -y libsqlite3-dev zlib1g-dev libldap-common libldap-dev && \
    sudo pecl install apcu-5.1.8 && \
    sudo docker-php-ext-install zip pdo_sqlite ldap && \
    sudo docker-php-ext-enable --ini-name 20-apcu.ini apcu && \
    sudo docker-php-ext-enable ldap