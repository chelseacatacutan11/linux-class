#!/bin/bash
echo "Apache HTTP Installation"
yum install httpd -y
echo " Start Apache"
systemctl start httpd.service

echo "Add Firrewall Rules"
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp

echo "Reload Firewall"
firewall-cmd --reload

echo "End Installation"



echo " Install PHP APACHE"
yum install php php-mysql -y

echo "Restart HTTPD.service"
systemctl restart httpd.service

echo "Install php-fpm"
yum install php-fpm -y

echo "<?php phpinfo();?>" > /var/www/html/info.php

echo "End Installation of PHP"