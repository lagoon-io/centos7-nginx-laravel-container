#!/bin/sh
export COMPOSER_HOME="/usr/bin/composer"

if [ -d "/var/www/app/public/app" ] && [ ! -d "/var/www/app/public/vendor" ]; then
  cd /var/www/app/public
  chmod -R 777 ./*
  composer install
fi
