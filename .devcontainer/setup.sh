#!/usr/bin/env bash
set -euo pipefail

cd /workspaces/admidio

printf 'Installing Composer dependencies...\n'
composer install --prefer-dist --no-progress --no-interaction

printf '\nPreparing Admidio configuration...\n'
mkdir -p adm_my_files

if [[ -n "${CODESPACE_NAME:-}" ]]; then
    CODESPACES_DOMAIN="${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:-app.github.dev}"
    ADMIDIO_ROOT_URL="https://${CODESPACE_NAME}-8081.${CODESPACES_DOMAIN}"
else
    ADMIDIO_ROOT_URL="http://localhost:8081"
fi

cat > adm_my_files/config.php <<EOF
<?php
/**
 * Automatically generated configuration for the Codespaces demo environment.
 */

\$gDbType = 'mariadb';
\$g_tbl_praefix = 'adm';

\$g_adm_srv  = 'mariadb';
\$g_adm_port = 3306;
\$g_adm_db   = 'admidio_test';
\$g_adm_usr  = 'admidio';
\$g_adm_pw   = 'admidio_test';

\$g_root_path = '${ADMIDIO_ROOT_URL}';
\$gTimezone = 'Europe/Berlin';

// Required by demo_data/build.php.
\$gImportDemoData = true;
EOF

printf 'Configuration written for %s\n' "$ADMIDIO_ROOT_URL"

printf '\nVerifying test services...\n'
php tests/bin/setup-test-env.php

printf '\nLoading Admidio demo data...\n'
php demo_data/build.php

printf '\nCodespace setup completed.\n'
printf 'Admidio: %s\n' "$ADMIDIO_ROOT_URL"
printf 'The demo database may require the normal Admidio update wizard before use.\n'
printf 'Run tests with: composer test:unit, composer test:integration, composer test:cli\n'
