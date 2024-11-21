#FROM php:8.2-apache
FROM php:8.2-apache-buster

RUN a2enmod rewrite

# Install PHP extensions deps
RUN apt-get update && \
    apt-get install -y \
        curl \
        libcurl4-openssl-dev \
        libzip-dev \
        zip \
        libpng-dev \
        libonig-dev \
        libxml2 \
        libxml2-dev \
        libtidy-dev \
        libmemcached-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libgd-dev \
        subversion

# Install PHP extension from pecl and enabled it.
RUN pecl install sync && \
    pecl install xdebug-3.2.2 && \
    pecl install apcu && \
    pecl install memcached && \
    pecl install yac && \
    docker-php-ext-enable \
      sync \
      xdebug \
      apcu \
      memcached \
      yac \
      opcache

# Configure GD extension
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/

# Install PHP extensions
RUN docker-php-ext-install \
    mysqli \
    bcmath \
    curl \
    gd \
    mbstring \
    soap \
    tidy \
    zip \
    xml \
    exif \
    calendar

# Install NodeJs and lessc
RUN apt-get install -y nodejs npm && npm install less@3.9.0 -g

RUN mkdir -p /cache/wl.trunk && \
    mkdir -p /cache/wl.stable && \
    mkdir -p /cache/studio.trunk && \
    mkdir -p /cache/wl.production && \
    chmod -R 777 /cache

# The lines below are making the local user on the host machine to be the same as the apache2 user inside the container.
# This can cause issues on non-ubuntu machines and those that have UID and GID different from 1000:1000.
# Yet it can be very useful for local development. Uncomment these lines with proper UID:GID settings for your machine,
# if experiencing issues with file permissions.
RUN sed -i 's/www-data:x:33:33/www-data:x:1000:1000/' /etc/passwd
RUN sed -i 's/www-data:x:33:/www-data:x:1000:/' /etc/group