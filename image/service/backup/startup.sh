#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# install image tools
ln -sf ${CONTAINER_SERVICE_DIR}/backup/assets/tool/* /sbin/

# add cron jobs
ln -sf ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs /etc/cron.d/backup
chmod 600 ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs

FIRST_START_DONE="${CONTAINER_STATE_DIR}/docker-backup-backup-first-start-done"
# container first start
if [ ! -e "$FIRST_START_DONE" ]; then
    
    if [ "$MATOMO_SERVER_PATH" = "/" ]; then
        MATOMO_SERVER_PATH=""
    fi
    
    # adapt cronjobs file
    sed -i "s|{{ MATOMO_BACKUP_CRON_EXP }}|${MATOMO_BACKUP_CRON_EXP}|g" ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs
    
    sed -i "s|{{ MATOMO_ARCHIVE_CRON_EXP }}|${MATOMO_ARCHIVE_CRON_EXP}|g" ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs
    sed -i "s|{{ MATOMO_SERVER_BASE_URL }}|${MATOMO_SERVER_BASE_URL}|g" ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs
    sed -i "s|{{ MATOMO_SERVER_PATH }}|${MATOMO_SERVER_PATH}|g" ${CONTAINER_SERVICE_DIR}/backup/assets/cronjobs
    
    touch $FIRST_START_DONE
fi

exit 0
