FROM mcr.microsoft.com/devcontainers/php:1-8.2-bookworm

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
        libzip-dev \
        php8.2-curl \
        php8.2-gd \
        php8.2-mbstring \
        php8.2-mysql \
        php8.2-pgsql \
        php8.2-xml \
        php8.2-zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /workspaces/admidio

USER vscode
