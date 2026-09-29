FROM mcr.microsoft.com/devcontainers/php:1-8.2-bookworm

USER root

# The base image currently contains a Yarn APT source whose signing key may be unavailable
# in Codespaces. Remove that optional source before refreshing package metadata.
RUN rm -f /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
        libzip-dev \
        php-curl \
        php-gd \
        php-mbstring \
        php-mysql \
        php-pgsql \
        php-xml \
        php-zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /workspaces/admidio

USER vscode
