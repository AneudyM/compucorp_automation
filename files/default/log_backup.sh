#!/bin/bash

appDir="/opt/compucorp";
webLogsBackupDir="${appDir}/backups/nginx";
bufferDir="${backupDir}/buffer";
logsDir="/var/log/nginx";
NGINXPID=$(cat /var/run/nginx.pid);
currTime=$(date +'%Y-%m-%d-%H%M%S');

[ ! -d $appDir ] && mkdir -p ${appDir}
[ ! -d $webLogsBackupDir ] && mkdir -p ${webLogsBackupDir}
[ ! -d $bufferDir ] && mkdir -p ${bufferDir}

# Archive filename structure
archiveFile="nginx_log.${currTime}.tar.gz";

logger "$0: *** NGINX logs backup started @ $(date) ***"

mv $logsDir/access.log $bufferDir/access.log_$currTime;
mv $logsDir/error.log $bufferDir/access.log_$currTime;

kill -USR1 ${NGINXPID}
sleep 1

tar -czf ${webLogsBackupDir}/$archiveFile -C $bufferDir access.log_$currTime error.log_$currTime
rm ${bufferDir}/access.log_${currTime} ${bufferDir}/error.log_${currTime}		

logger "$0: *** NGINX logs backup ended @ $(date) ***"
