#!/bin/bash
if [ -f "./composer.json" ]; then
  if [ ! -f "./composer.lock" ]; then
    /usr/bin/composer install;
  else
    /usr/bin/composer update;
  fi
fi

chown -R apache:apache /var/www/site;

rm -rf /run/httpd/* /tmp/httpd*;
exec /usr/sbin/apachectl -DFOREGROUND;