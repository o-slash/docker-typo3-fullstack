#!/bin/bash
shopt -s expand_aliases
source $HOME/.bashrc

VOL_GROUP=$(stat -c "%G" .)
VOL_GROUP_ID=$(stat -c "%g" .)

if [ "$VOL_GROUP" != "apache" ]; then
  groupadd -f -g $VOL_GROUP_ID $VOL_GROUP;
  usermod -a -G "$VOL_GROUP" apache;
fi

if [ -f "./composer.json" ]; then
  if [ ! -f "./composer.lock" ]; then
    composer install;
  else
    composer update;
  fi
fi

rm -rf /run/httpd/* /tmp/httpd*;
exec /usr/sbin/apachectl -DFOREGROUND;