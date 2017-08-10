#!/bin/bash
set -e

SITEDIR=/var/www/site
APACHE_UID=$(id -u apache)
VOL_UID=$(stat -c "%u" $SITEDIR)

if [ "$VOL_UID" != "$APACHE_UID" ]; then
  usermod -u "$VOL_UID" apache
fi

chown -R apache:apache /var/www
chmod -R ugo+rwX,o-w /var/www
usermod -d /var/www apache

exec "$@"