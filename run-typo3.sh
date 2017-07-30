#!/bin/bash
MOUNT_GROUP=$(stat -c "%G" .)
MOUNT_GROUP_ID=$(stat -c "%g" .)
MOUNT_GROUP_EXISTS=$(grep "^$MOUNT_GROUP:" /etc/group | wc -l)

if [ "$MOUNT_GROUP" != "apache" ]; then
  groupadd -f -g $MOUNT_GROUP_ID $MOUNT_GROUP;
  usermod -a -G "$MOUNT_GROUP" apache;
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