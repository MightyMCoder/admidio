#!/usr/bin/env bash
set -euo pipefail

cd /workspaces/admidio

composer install --prefer-dist --no-progress --no-interaction

php tests/bin/setup-test-env.php

printf '\nCodespace setup completed.\n'
printf 'Run tests with: composer test:unit, composer test:integration, composer test:cli\n'
