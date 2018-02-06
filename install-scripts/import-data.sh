#!/bin/bash

if [ -f /root/.import-data.lock ]
  then
    exit 0
  fi

sleep 10

# set base url in magento
# $PORT and $BASE_URL need to be ENV Variables passed to "docker run"
if [ $PORT = 80 ]
  then
    mysql -e "replace into core_config_data (path, value) values ('web/secure/base_url', 'http://${BASE_URL}}/');" magento
    mysql -e "replace into core_config_data (path, value) values ('web/unsecure/base_url', 'http://${BASE_URL}/');" magento
  else
    mysql -e "replace into core_config_data (path, value) values ('web/secure/base_url', 'http://${BASE_URL}:${PORT}/');" magento
    mysql -e "replace into core_config_data (path, value) values ('web/unsecure/base_url', 'http://${BASE_URL}:${PORT}/');" magento
fi

cd /var/www/magento/pub
sudo -E -u www-data magerun cache:clean

# import products and categories into lizards
php /var/www/magento/pub/shell/lizards_and_pumpkins_export.php --all-products
php /var/www/magento/pub/shell/lizards_and_pumpkins_export.php --all-categories
php /var/www/magento/pub/shell/lizards_and_pumpkins_export.php --blocks
sudo -E -u www-data /var/www/lizards/vendor/bin/lp import:template product_listing
sudo -E -u www-data /var/www/lizards/vendor/bin/lp import:template product_detail_view
ls -1 /var/www/share/*.xml | xargs -L 1 sudo -E -u www-data /var/www/lizards/vendor/bin/lp import:catalog -i

touch /root/.import-data.lock
