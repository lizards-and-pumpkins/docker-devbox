#!/bin/bash

BASE_URL="127.0.0.1"

source /etc/profile.d/lizards-env.sh

SAMPLE_PROJECT_VERSION=2018-02-25-01

echo "Cloning https://github.com/lizards-and-pumpkins/sample-project.git"
cd /var/www/lizards
git clone --quiet https://github.com/lizards-and-pumpkins/sample-project.git .
git checkout tags/$SAMPLE_PROJECT_VERSION -b $SAMPLE_PROJECT_VERSION
rsync -r --chown=www-data:www-data src/magento-themes/magento-sample-theme/* /var/www/magento/pub/
rsync -r --chown=www-data:www-data src/magento-extensions/LizardsAndPumpkins_DemoTheme/* /var/www/magento/pub/
rm pub/index-magento.php
ln -s ../src/lizards-and-pumpkins/pub/{css,js,images} pub/
cd pub
ln -s . en
ln -s . de
ln -s . fr
mkdir -p /var/www/file-storage/
mkdir -p /var/www/lizards/var/log
mkdir -p /var/www/share/product-images
mkdir -p /var/www/lizards/pub/media
chown -R www-data /var/www/lizards/
chown -R www-data /var/www/share
cd /var/www/lizards
sudo -E -u www-data composer install --ignore-platform-reqs --no-progress --profile --prefer-dist --no-dev
chown -R www-data /var/www/file-storage
cd /var/www/magento/pub
sudo -E -u www-data magerun sys:setup:run
mysql magento < /root/config-files/lizards-magento-connector.sql
chown -R www-data /var/www/lizards/
sudo -E -u www-data magerun cache:clean
