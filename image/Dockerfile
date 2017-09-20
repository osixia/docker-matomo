FROM osixia/web-baseimage:1.1.0
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Piwik version
ARG PIWIK_VERSION=3.1.0

# MariaDB version
ARG MARIADB_MAJOR=10.2

# Install apache2 and php7.0-fpm using osixia/baseimage utils
# Caution: /container/tool/install-service-available arguments order is important
# php7.0-fpm install will detect apache2 and configure it

# Add MariaDB repository
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 \
    && echo "deb http://ftp.igh.cnrs.fr/pub/mariadb/repo/$MARIADB_MAJOR/debian stretch main" > /etc/apt/sources.list.d/mariadb.list \
    && { \
		     echo 'Package: *'; \
		     echo 'Pin: release o=MariaDB'; \
		     echo 'Pin-Priority: 999'; \
	     } > /etc/apt/preferences.d/mariadb

# Download, check integrity and unzip phpMyAdmin to /var/www/piwik_bootstrap
RUN apt-get update \
		&& /container/tool/add-multiple-process-stack \
		&& /container/tool/add-service-available :apache2 :php7.0-fpm :ssl-tools \
		&& LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       ca-certificates \
       curl \
       mariadb-client-$MARIADB_MAJOR \
       php7.0-cli \
       php7.0-curl \
       php7.0-gd \
       php7.0-geoip \
       php7.0-ldap \
       php7.0-mbstring \
       php7.0-mysql \
       php7.0-xml \
       ssmtp \
       zip \
		&& curl -o piwik.tar.gz -SL https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz \
		&& mkdir -p /var/www/piwik_bootstrap /var/www/piwik \
		&& tar -xzf piwik.tar.gz --strip 1 -C /var/www/piwik_bootstrap \
    && curl -fsSL -o /var/www/piwik_bootstrap/misc/GeoIPCity.dat.gz https://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz \
    && gunzip /var/www/piwik_bootstrap/misc/GeoIPCity.dat.gz \
		&& apt-get remove -y --purge --auto-remove curl ca-certificates \
    && rm piwik.tar.gz \
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
VOLUME ["/var/www/piwik", "/data/backup"]

# Expose http and https default ports
EXPOSE 80 443
