#!/bin/bash

DRUPAL_HOME="/var/www/html"
appDir="/opt/compucorp";
drupalBackupDir="${appDir}/backups/drupal";

# Store current date
now=$(date +"%F")
currTime=$(date +'%Y-%m-%d-%H%M%S');

# Backup filename
drupalArchive="drupal_backup.$currTime.tar.gz"

# Verify directory exists
[ ! -d $drupalBackupDir ] && mkdir -p ${drupalBackupDir}

# Log backup process initialization time
logger "$0: *** DRUPAL SITE BACKUP STARTED @ $(date) ***"

# Create backup archive
tar -czf ${drupalBackupDir}/${drupalArchive} ${DRUPAL_HOME} 

# Log backup finalization time
logger "$0: *** DRUPAL SITE BACKUP ENDED @ $(date) ***"
 
