#!/bin/bash -e
# this script is run during the image build

# add Piwik virtualhosts
ln -sf /container/service/piwik/assets/apache2/piwik.conf /etc/apache2/sites-available/piwik.conf
ln -sf /container/service/piwik/assets/apache2/piwik-ssl.conf /etc/apache2/sites-available/piwik-ssl.conf

cat /container/service/piwik/assets/php7.0-fpm/pool.conf >> /etc/php/7.0/fpm/pool.d/www.conf
rm /container/service/piwik/assets/php7.0-fpm/pool.conf

cp -f /container/service/piwik/assets/php7.0-fpm/opcache.ini /etc/php/7.0/fpm/conf.d/opcache.ini
rm /container/service/piwik/assets/php7.0-fpm/opcache.ini

echo "open_basedir = /var/www" >> /etc/php/7.0/fpm/php.ini
echo "geoip.custom_directory=/var/www/piwik/misc" >> /etc/php/7.0/fpm/php.ini


mkdir -p /var/www/tmp
chown www-data:www-data /var/www/tmp
chmod 700 /var/www/tmp

# remove apache default host
a2dissite 000-default
rm -rf /var/www/html
