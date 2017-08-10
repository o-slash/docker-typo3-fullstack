#!/bin/bash
shopt -s expand_aliases
source $HOME/.bashrc

if [ -f "./composer.json" ]; then
  if [ ! -f "./composer.lock" ]; then
    composer install
  else
    composer update
  fi
fi

rm -rf /run/httpd/* /tmp/httpd*
exec /usr/sbin/apachectl -DFOREGROUND