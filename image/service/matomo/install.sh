#!/bin/bash -e
# this script is run during the image build

# add Matomo virtualhosts
ln -sf /container/service/matomo/assets/apache2/matomo.conf /etc/apache2/sites-available/matomo.conf
ln -sf /container/service/matomo/assets/apache2/matomo-ssl.conf /etc/apache2/sites-available/matomo-ssl.conf

cat /container/service/matomo/assets/php7.3-fpm/pool.conf >> /etc/php/7.3/fpm/pool.d/www.conf
rm /container/service/matomo/assets/php7.3-fpm/pool.conf

cp -f /container/service/matomo/assets/php7.3-fpm/opcache.ini /etc/php/7.3/fpm/conf.d/opcache.ini
rm /container/service/matomo/assets/php7.3-fpm/opcache.ini

echo "open_basedir = /var/www" >> /etc/php/7.3/fpm/php.ini
echo "geoip.custom_directory=/var/www/matomo/misc" >> /etc/php/7.3/fpm/php.ini

mkdir -p /var/www/tmp
chown www-data:www-data /var/www/tmp
chmod 700 /var/www/tmp

# remove apache default host
a2dissite 000-default
rm -rf /var/www/html

# copy robots.txt
cp -f /container/service/matomo/assets/robots.txt /var/www/matomo_bootstrap/robots.txt
