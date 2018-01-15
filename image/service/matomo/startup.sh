#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

FIRST_START_DONE="${CONTAINER_STATE_DIR}/docker-matomo-first-start-done"

#
# HTTPS config
#
if [ "${MATOMO_HTTPS,,}" == "true" ]; then

  log-helper info "Set apache2 https config..."

  # generate a certificate and key if files don't exists
  # https://github.com/osixia/docker-light-baseimage/blob/stable/image/service-available/:ssl-tools/assets/tool/ssl-helper
  ssl-helper ${MATOMO_SSL_HELPER_PREFIX} "${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/certs/$MATOMO_HTTPS_CRT_FILENAME" "${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/certs/$MATOMO_HTTPS_KEY_FILENAME" "${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/certs/$MATOMO_HTTPS_CA_CRT_FILENAME"

  # add CA certificat config if CA cert exists
  if [ -e "${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/certs/$MATOMO_HTTPS_CA_CRT_FILENAME" ]; then
    sed -i "s/#SSLCACertificateFile/SSLCACertificateFile/g" ${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/https.conf
  fi

  ln -sf ${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/https.conf /etc/apache2/sites-available/matomo.conf
#
# HTTP config
#
else
  log-helper info "Set apache2 http config..."
  ln -sf ${CONTAINER_SERVICE_DIR}/matomo/assets/apache2/http.conf /etc/apache2/sites-available/matomo.conf
fi

a2ensite matomo | log-helper debug

#
# Reverse proxy config
#
if [ "${MATOMO_TRUST_PROXY_SSL,,}" == "true" ]; then
  echo 'SetEnvIf X-Forwarded-Proto "^https$" HTTPS=on' > /etc/apache2/mods-enabled/remoteip_ssl.conf
fi

#
# Matomo directory is empty, we use the bootstrap
#
if [ ! "$(ls -A -I lost+found /var/www/matomo)" ]; then

  log-helper info "Bootstap Matomo..."

  cp -R /var/www/matomo_bootstrap/* /var/www/matomo
  rm -rf /var/www/matomo_bootstrap
fi

#
#
#
if [ "${MATOMO_FORCE_UPDATE,,}" == "true" ]; then
  CURRENT_VERSION=""

  # test if new version need to be installed
  IMAGE_VERSION=$(cat /var/www/matomo_bootstrap/VERSION)
  [ -e "/var/www/matomo/VERSION" ] && CURRENT_VERSION=$(cat /var/www/matomo/VERSION)

  log-helper info "Check Matomo versions..."
  log-helper info "Docker image version: ${IMAGE_VERSION}"
  log-helper info "Current version: ${CURRENT_VERSION}"

  if [ "${IMAGE_VERSION}" != "${CURRENT_VERSION}" ]; then
    log-helper info "Remove current files (except config.ini.php and plugins)..."
    find /var/www/matomo -mindepth 1 -maxdepth 1 \( -path /var/www/matomo/config -o -path /var/www/matomo/plugins \) -prune -o -exec rm -rf {} + || true
    find /var/www/matomo/config -mindepth 1 -maxdepth 1 \( -path /var/www/matomo/config/config.ini.php \) -prune -o -exec rm -rf {} + || true

    log-helper info "Add image files..."
    cp -Rf /var/www/matomo_bootstrap/. /var/www/matomo
  fi
fi

# if there is no config
if [ ! -e "/var/www/matomo/config/config.ini.php" ] && [ -e "${CONTAINER_SERVICE_DIR}/matomo/assets/config/config.ini.php" ]; then

  log-helper debug "link ${CONTAINER_SERVICE_DIR}/matomo/assets/config/config.ini.php to /var/www/matomo/config/config.ini.php"
  ln -sf ${CONTAINER_SERVICE_DIR}/matomo/assets/config/config.ini.php /var/www/matomo/config/config.ini.php

fi

# Fix file permission
find /var/www/ -type d -exec chmod 755 {} \;
find /var/www/ -type f -exec chmod 644 {} \;
chown www-data:www-data -R /var/www

# symlinks special (chown -R don't follow symlinks)
if [ -e "/var/www/matomo/config/config.ini.php" ]; then

  chown www-data:www-data /var/www/matomo/config/config.ini.php
  chmod 600 /var/www/matomo/config/config.ini.php

fi

exit 0
