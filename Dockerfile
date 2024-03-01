FROM composer:2 as composer
FROM php:8.1-fpm-alpine as base

ARG USER_UID=82
ARG USER_GID=82

# Recreate www-data user with user id matching the host
RUN deluser --remove-home www-data && \
    addgroup -S -g ${USER_GID} www-data && \
    adduser -u ${USER_UID} -D -S -G www-data www-data

# Necessary tools
RUN apk add --update --no-cache ${PHPIZE_DEPS} git bash curl

# ZIP module
RUN apk add --no-cache libzip-dev && docker-php-ext-configure zip && docker-php-ext-install zip pdo pdo_mysql

# XDebug from PECL
RUN pecl install xdebug-3.1.5

# Necessary build deps not longer needed
RUN apk del --no-cache ${PHPIZE_DEPS} \
    && docker-php-source delete

# Composer
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# XDebug wrapper
COPY ./artifacts/xdebug /usr/local/bin/xdebug
RUN chmod +x /usr/local/bin/xdebug

# Clean up image
RUN rm -rf /tmp/* /var/cache
