FROM php:8.0-apache

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli && apt-get update && apt-get upgrade -y
RUN a2enmod rewrite

WORKDIR /app

COPY . /var/www/html/

EXPOSE 80

