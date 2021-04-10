#!/bin/bash

# Description: install and configure LAMP in Debian/Ubuntu

FILE="/var/www/html/test-php.php"

# Check the root rights
if [ "$(id -un)" != "root" ]; then
  echo "ERROR: You must be root to run this script." >&2
  exit 1
fi

# Update packages
apt-get update && apt-get upgrade -yqq

# Install LAMP
if apt-get install -y --reinstall git curl wget mc apache2 mariadb mariadb-server; then
  apt-get install -y --reinstall php libapache2-mod-php php-cli php-mysqlnd php-json \
  php-gd php-ldap php-odbc php-pdo php-opcache php-pear php-xml php-xmlrpc php-mbstring \
  php-snmp php-soap php-zip
fi

# Pre-setup mariadb-server
/usr/bin/mysql_secure_installation

# Running/restart mariadb service
systemctl status mysql | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]; then
  systemctl restart mysql > /dev/null
fi

# Running/restart apache2 service
systemctl status apache2  | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]; then
  systemctl restart apache2 > /dev/null
fi

# Create file test-php.php and test php
echo "<?php phpinfo(); ?>" > /var/www/html/test-php.php

# Check file test-php.php
if [ -f "$FILE" ]; then
  echo "$FILE exist"
else
  echo "$FILE doesn't exist"
fi
