
#!/bin/bash

# Description: install and configure LAMP Debian/Ubuntu

FILE=/var/www/html/test-php.php

# Check root Rights
if [ "$UID" != "0" ]; then
    [ ! -f /usr/bin/sudo ] && echo "Install sudo!" && exit 1;
    if sudo echo &> /dev/null; then
        echo "Self rerun with sudo..."
        exec sudo bash $0
    else
        echo "Script must be runned as root or by user with sudo permissions!" && exit 1;
    fi
fi

# Update packages
apt update && apt upgrade -yqq

# Install LAMP
if apt install -y --reinstall git curl wget mc apache2 mariadb mariadb-server; then
        apt install -y --reinstall php libapache2-mod-php php-cli php-mysqlnd php-json php-gd php-ldap \
        php-odbc php-pdo php-opcache php-pear php-xml php-xmlrpc php-mbstring php-snmp \
        php-soap php-zip
fi

# Pre-setup mariadb-server
/usr/bin/mysql_secure_installation

# Running/restart mariadb service
systemctl status mysql | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]
        then
                systemctl restart mysql > /dev/null
fi

# Running/restart apache2 service
systemctl status apache2  | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]
        then
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
