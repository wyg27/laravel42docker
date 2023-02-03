FROM php:8.0.7-apache

RUN apt-get update - \
    && apt-get install -y \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-dev \
    libz-dev \
    libzip-dev \
    libssl-dev \
    zip \
    zlib1g-dev \
    libonig-dev
    
RUN pecl install mcrypt \
    && pecl install mongodb
    

RUN docker-php-ext-install \
    mbstring \
    zip \
    pdo_mysql \
    mysqli \
    bcmath \
    pcntl \
    gd

RUN docker-php-ext-configure pcntl --enable-pcntl \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-enable mongodb   
    
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && echo extension=mcrypt.so >> /usr/local/etc/php/php.ini \
    && a2enmod rewrite \
    && a2enmod headers
    

COPY ./000-default.conf /etc/apache2/sites-available
COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 80

# 《Run MySQL & phpMyAdmin locally in 3 steps using Docker》https://medium.com/@migueldoctor/run-mysql-phpmyadmin-locally-in-3-steps-using-docker-74eb735fa1fc
# 《用Docker部署一个Web应用》https://zhuanlan.zhihu.com/p/26418829
# 增加了composer 之后，就可以 使用 docker exec <id or IMAGE> composer install 来直接安装容器内的php composer 了。
# 由于lock文件和其他的composer 冲突，所以可以根据提示使用docker exec  <id or IMAGE> composer install --ignore-platform-req=ext-pcntl --ignore-platform-req=ext-gd
