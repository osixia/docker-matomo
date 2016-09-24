#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

FIRST_START_DONE="${CONTAINER_STATE_DIR}/docker-piwik-first-start-done"

#
# HTTPS config
#
if [ "${PIWIK_HTTPS,,}" == "true" ]; then

  log-helper info "Set apache2 https config..."

  # generate a certificate and key if files don't exists
  # https://github.com/osixia/docker-light-baseimage/blob/stable/image/service-available/:ssl-tools/assets/tool/ssl-helper
  ssl-helper ${PIWIK_SSL_HELPER_PREFIX} "${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/certs/$PIWIK_HTTPS_CRT_FILENAME" "${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/certs/$PIWIK_HTTPS_KEY_FILENAME" "${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/certs/$PIWIK_HTTPS_CA_CRT_FILENAME"

  # add CA certificat config if CA cert exists
  if [ -e "${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/certs/$PIWIK_HTTPS_CA_CRT_FILENAME" ]; then
    sed -i "s/#SSLCACertificateFile/SSLCACertificateFile/g" ${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/https.conf
  fi

  ln -sf ${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/https.conf /etc/apache2/sites-available/piwik-ssl.conf
  a2ensite piwik-ssl | log-helper debug

#
# HTTP config
#
else
  log-helper info "Set apache2 http config..."
fi
# unable http no matter what :)
ln -sf ${CONTAINER_SERVICE_DIR}/piwik/assets/apache2/http.conf /etc/apache2/sites-available/piwik.conf

#
# Reverse proxy config
#
if [ "${PIWIK_TRUST_PROXY_SSL,,}" == "true" ]; then
  echo 'SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on' > /etc/apache2/mods-enabled/remoteip_ssl.conf
fi

a2ensite piwik | log-helper debug

#
# Piwik directory is empty, we use the bootstrap
#
if [ ! "$(ls -A -I lost+found /var/www/piwik)" ]; then

  log-helper info "Bootstap Piwik..."

  cp -R /var/www/piwik_bootstrap/* /var/www/piwik
  rm -rf /var/www/piwik_bootstrap
fi


# if there is no config
if [ ! -e "/var/www/piwik/config/config.ini.php" ] && [ -e "${CONTAINER_SERVICE_DIR}/piwik/assets/config.ini.php" ]; then

  log-helper debug "link ${CONTAINER_SERVICE_DIR}/piwik/assets/config.ini.php to /var/www/piwik/config/config.ini.php"
  ln -sf ${CONTAINER_SERVICE_DIR}/piwik/assets/config.ini.php /var/www/piwik/config/config.ini.php

fi

# Fix file permission
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;
chown www-data:www-data -R /var/www

# symlinks special (chown -R don't follow symlinks)
if [ -e "/var/www/piwik/config/config.ini.php" ]; then

  chown www-data:www-data /var/www/piwik/config/config.ini.php
  chmod 400 /var/www/piwik/config/config.ini.php

fi

exit 0
