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
    && rm -rf /var/lib/apt/lists/*

# Install the PHP extensions required by Admidio using the installer intended for
# official PHP container images. It resolves the required build dependencies itself.
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN install-php-extensions \
        curl \
        gd \
        mbstring \
        pdo_mysql \
        pdo_pgsql \
        simplexml \
        zip

COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

WORKDIR /workspaces/admidio

USER vscode
