#!/bin/bash

appDir="/opt/compucorp";
mysqlBackupDir="${appDir}/backups";

# Store current date
now=$(date +"%F")
currTime=$(date +'%F-%H%M%S')

# Backup filename 
mysqlArchive="mysql.${currTime}.tar.gz"

# Set MySQL username and password
MYSQLUSER="root"
MYSQLPASSWORD="admin1234"

# Verify the backup buffer directory exists
[ ! -d $mysqlBackupDir ] && mkdir -p ${mysqlBackupDir}

# Log the backup initialization time in the /var/log/messages
logger "$0: *** MYSQL Database backup started @ $(date) ***"

# Backup MySQL
mysqldump -u${MYSQLUSER} -p${MYSQLPASSWORD} \
          --all-databases | gzip -9 > ${mysqlBackupDir}/${mysqlArchive};

# Log backup finalization time in /var/log/messages
logger "$0: *** MYSQL Database backup ended @ $(date) ***"
