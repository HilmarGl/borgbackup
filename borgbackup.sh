#!/bin/sh
export BORG_FILES_CACHE_TTL=50
REPOSITORY=/backup/borgbackup
export BORG_PASSPHRASE='DFDFDF'
 #Backup all of /home and /var/www except a few
# excluded directories
borg create -v --stats --compression lz4 --nobsdflags          \
    $REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
    /                                      \
    --exclude /tmp                  \
    --exclude /backup    \
    --exclude /proc       \
    --exclude /dev \
    --exclude /mnt/ \
    --exclude /sys \
#    --one-file-system


borg prune -v --list $REPOSITORY --prefix '{hostname}-' --keep-daily=3 --keep-weekly=1 --keep-monthly=0


# mountpoint -q  /mnt/tmp/ ; echo $?
# rsync -avt --no-perms --no-owner --no-group --delete /backup/borgbackup /mnt/remotebackup/borgbackup/
