FROM php:8.0.7-apache

RUN apt-get update - \
    && apt-get install -y \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libz-dev \
    libzip-dev \
    zip \
    zlib1g-dev \
    libonig-dev \
    && pecl install mcrypt \
    && pecl install mongodb \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-enable mongodb \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && echo extension=mcrypt.so >> /usr/local/etc/php/php.ini \
    && a2enmod rewrite \
    && a2enmod headers 

COPY ./000-default.conf /etc/apache2/sites-available
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 80

# 《Run MySQL & phpMyAdmin locally in 3 steps using Docker》https://medium.com/@migueldoctor/run-mysql-phpmyadmin-locally-in-3-steps-using-docker-74eb735fa1fc
# 《用Docker部署一个Web应用》https://zhuanlan.zhihu.com/p/26418829
