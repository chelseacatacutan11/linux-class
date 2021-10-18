#!/bin/bash


echo "Apache HTTP Installation"
yum install httpd -y
echo " Start Apache"
systemctl start httpd.service

echo "Add Firewall Rules"
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


echo " Install MARIADB"
yum install mariadb-server mariadb -y

echo "Start MARIADB"
systemctl start mariadb

echo "mysql_secure_installaition"
mysql_secure_installation << EOF

Y
claymeone
claymeone
Y
Y
Y
Y
EOF

echo "enable mariadb.service"
systemctl enable mariadb.service

echo "Testing of Installation"
mysqladmin -u root -p version
echo "root"


echo "Creating the database"
mysql -u root --password=claymeone << EOF
CREATE DATABASE wordpress;
CREATE USER wordpressuser@localhost IDENTIFIED BY 'qwerty';
GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'qwerty';
FLUSH PRIVILEGES;

EOF


echo "Installing of Wordpress"
yum install php-gd -y

systemctl restart httpd

cd ~

echo "Installing of WGET"
yum install wget -y

echo "Installing of Wordpress for website"
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz


rsync -avP ~/wordpress/ /var/www/html/
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*

echo "Configuring wordpress"
cd /var/www/html
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
sed -i 's/username_here/wordpressuser/g' /var/www/html/wp-config.php
sed -i 's/password_here/qwerty/g' /var/www/html/wp-config.php

echo "restart httpd"
systemctl restart httpd

echo "Installation for browser"
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum install yum-utils -y
yum-config-manager --enable remi-php56  -y
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo -y
 
echo "restart httpd"
systemctl restart httpd
 
echo "End of Installation in Wordpress"
