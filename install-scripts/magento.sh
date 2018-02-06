#!/bin/bash

cd /bin
wget https://raw.githubusercontent.com/colinmollenhour/modman/master/modman
chmod +x modman
wget https://getcomposer.org/composer.phar
mv composer.phar composer
chmod +x composer
wget https://files.magerun.net/n98-magerun.phar
chmod +x ./n98-magerun.phar
mv n98-magerun.phar magerun

chown www-data /var/www/magento/pub
cd /var/www/magento/pub
sudo -u www-data git clone https://github.com/OpenMage/magento-mirror.git .
ln -s js mage-js
cp /root/config-files/local.xml app/etc/
rm -rf .git
modman init
modman clone https://github.com/lizards-and-pumpkins/magento-connector.git
cd .modman/magento-connector
composer dump

mkdir -p /root/sample-data
chown -R www-data /root/sample-data
cd /root/sample-data
wget https://github.com/riconeitzel/magento_sample_data_1.9.1.0_clean/archive/master.zip
sudo -u www-data unzip master.zip

rsync -ar magento_sample_data_1.9.1.0_clean-master/src/skin/ /var/www/magento/pub/skin/
rsync -ar magento_sample_data_1.9.1.0_clean-master/src/media/ /var/www/magento/pub/media/

mysql -e "CREATE DATABASE IF NOT EXISTS magento;"
mysql magento < /root/sample-data/magento_sample_data_1.9.1.0_clean-master/src/magento_sample_data_for_1.9.1.0.sql

mysql -e "grant all on magento.* to 'magento'@'localhost' identified by 'magento';"

cd /var/www/magento/pub

sudo -E -u www-data magerun admin:user:create lizards lap@examle.com pumpkins Lizards Pumpkins

rm -rf /root/sample-data
