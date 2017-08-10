#!/bin/bash
set -e

SITEDIR=/var/www/site
APACHE_UID=48
VOL_UID=$(stat -c "%u" $SITEDIR)

if [ "$VOL_UID" != "$APACHE_UID" ]; then
  usermod -u "$VOL_UID" apache
fi

chown -R apache:apache /var/www/site
chmod -R ugo+rwX,o-w /var/www/site

chown -R apache:apache /var/www/.composer
chmod -R ugo+rwX,o-w /var/www/.composer

exec "$@"