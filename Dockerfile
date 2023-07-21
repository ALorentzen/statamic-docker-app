#
# The following is an example dockerfile i used to build the statamic site
# to deploy in a single container, using php artisian serve
#
FROM php:8.0.9-fpm-alpine

#
# Add some required PHP "addons"
# and other addons
#
RUN apk add --no-cache \
    unzip wget git \
    php8 php8-fpm php8-opcache \
    php8-gd php8-mysqli php8-zlib php8-curl \
    php8-mbstring php8-xml php8-bcmath

#
# Install PHP composer
# Version and SHA can be found here : https://getcomposer.org/download/
#
ENV COMPOSER_VERSION 2.1.5
ENV COMPOSER_CHECKSUM be95557cc36eeb82da0f4340a469bad56b57f742d2891892dcb2f8b0179790ec
RUN wget -q https://getcomposer.org/download/$COMPOSER_VERSION/composer.phar && \
    echo "$COMPOSER_CHECKSUM  composer.phar" | sha256sum -c - && \
    mv composer.phar /usr/bin/composer && \
    chmod +x /usr/bin/composer

# Setup the default workdir
WORKDIR /var/www/html/

# Copy over the statamic files
# from the current project
COPY . /var/www/html/

# Run the permission nuke
# (used to resolve storage issues for now - there is probably a better way to do this)
RUN chmod -R 0777 /var/www/html/

# Run the composer install
RUN composer install

# The port to run on
EXPOSE 8080

# Run the statmic server on port 8080
# using artisian serve
ENTRYPOINT ["php"]
CMD ["artisan", "serve", "--host=0.0.0.0", "--port=8080"]
