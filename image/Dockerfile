FROM osixia/web-baseimage:release-1.2.0-dev

# Matomo version
ARG MATOMO_VERSION=3.12.0

# Add multiple process stack to supervise apache2 and php7.3-fpm
# sources: https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/add-multiple-process-stack
#          https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/add-service-available
#          https://github.com/osixia/docker-web-baseimage/blob/stable/image/service-available/:apache2/download.sh
#          https://github.com/osixia/docker-web-baseimage/blob/stable/image/service-available/:php7.3-fpm/download.sh
#          https://github.com/osixia/light-baseimage/blob/stable/image/service-available/:ssl-tools/download.sh
# Install ca-certificates, curl and php dependencies
# Download matomo, check file integrity, and unzip matomo to /var/www/matomo_bootstrap
# Remove curl
RUN apt-get update \
  && /container/tool/add-multiple-process-stack \
  && /container/tool/add-service-available :apache2 :php7.3-fpm :ssl-tools \
  && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  mariadb-client \
  php-cli \
  php-curl \
  php-gd \
  php-geoip \
  php-ldap \
  php-mbstring \
  php-mysql \
  php-xml \
  msmtp \
  zip \
  && curl -o matomo.tar.gz -SL https://builds.matomo.org/matomo-${MATOMO_VERSION}.tar.gz \
  && mkdir -p /var/www/matomo_bootstrap /var/www/matomo \
  && tar -xzf matomo.tar.gz --strip 1 -C /var/www/matomo_bootstrap \
  && echo "${MATOMO_VERSION}" > /var/www/matomo_bootstrap/VERSION \
  && curl -fsSL -o /var/www/matomo_bootstrap/misc/GeoLite2-City.tar.gz https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz \
  && cd /var/www/matomo_bootstrap/misc \
  && tar -xvf /var/www/matomo_bootstrap/misc/GeoLite2-City.tar.gz --strip-components 1 \
  && rm -rf GeoLite2-City.tar.gz COPYRIGHT.txt LICENSE.txt README.txt \
  && cd - \
  && apt-get remove -y --purge --auto-remove curl \
  && rm matomo.tar.gz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default

# Set wordpress data directory in a data volume
VOLUME ["/var/www/matomo", "/data/backup"]

# Expose http and https default ports
EXPOSE 80 443
