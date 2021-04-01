#!/bin/sh
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export BACKUP_LOCATION=/root/mailcow
mkdir -p $BACKUP_LOCATION
cd /opt/mailcow
date >$BACKUP_LOCATION/mailcow-backup.log 
tar cpzf $BACKUP_LOCATION/backup_data.tgz data/ >>$BACKUP_LOCATION/mailcow-backup.log 2>&1
/opt/mailcow/helper-scripts/backup_and_restore.sh backup all >>$BACKUP_LOCATION/mailcow-backup.log 2>&1
cd $BACKUP_LOCATION
STAMP=`ls -td mailcow-????-??-??-* | head -1 | sed 's/^mailcow-//'`
mv backup_data.tgz `ls -td mailcow-????-??-??-* | head -1`/
sleep 30 && cat $BACKUP_LOCATION/mailcow-backup.log | mail -s "mailcow backup log" admin@coredev.it
