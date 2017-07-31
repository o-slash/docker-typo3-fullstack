#!/bin/bash
shopt -s expand_aliases
source $HOME/.bashrc

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

if [ -f "./composer.json" ]; then
  if [ ! -f "./composer.lock" ]; then
    composer install
  else
    composer update
  fi
fi

rm -rf /run/httpd/* /tmp/httpd*
exec /usr/sbin/apachectl -DFOREGROUND