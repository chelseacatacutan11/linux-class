#!/bin/bash
today=$(date + '%m%d%y')

cd /opt/
mkdir backs
cd /opt/backs

echo "Creation of the MySQLDUMP"
mysqldump -u wordpressuser -p password wordpress > wordpress_$today.sql

cd /opt/backs

echo "FILE COMPRESSING"
tar -zcf wordpress_$today.tar.gz wordpress_$today.sql

echo "DATABASE BACKUP SUCCESSFULL"
