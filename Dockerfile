FROM circleci/php:7.3-node-browsers

RUN apt install -y libsqlite3-dev zlib1g-dev && \
    pecl install apcu-5.1.8 && \
    docker-php-ext-install zip pdo_sqlite && \
    docker-php-ext-enable --ini-name 20-apcu.ini apcu
