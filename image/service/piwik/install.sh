#!/bin/bash -e
# this script is run during the image build

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# add Piwik virtualhosts
ln -sf /container/service/piwik/assets/apache2/piwik.conf /etc/apache2/sites-available/piwik.conf
ln -sf /container/service/piwik/assets/apache2/piwik-ssl.conf /etc/apache2/sites-available/piwik-ssl.conf

cat /container/service/piwik/assets/php5-fpm/pool.conf >> /etc/php5/fpm/pool.d/www.conf
rm /container/service/piwik/assets/php5-fpm/pool.conf

echo "open_basedir = /var/www" >> /etc/php5/fpm/php.ini
echo "geoip.custom_directory=/var/www/piwik/misc" >> /etc/php5/fpm/php.ini


mkdir -p /var/www/tmp
chown www-data:www-data /var/www/tmp
chmod 700 /var/www/tmp

# remove apache default host
a2dissite 000-default
rm -rf /var/www/html
