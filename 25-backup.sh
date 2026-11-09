#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="$1"
DEST_DIR="$2"
DAYS=${3:-14}

log(){
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') | $1" | tee -a "$LOGS_FILE"
}

if [ "$USERID" -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N"
    exit 1
fi

mkdir -p "$LOGS_FOLDER"

USAGE(){
    log "$R USAGE:: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS> $N"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
    log "Source Directory: $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    log "Destination Directory: $DEST_DIR does not exist"
    exit 1
fi

### Find the files

FILES=$(find "$SOURCE_DIR" -name "*.log" -type f -mtime +"$DAYS")

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"

if [ -z "$FILES" ]; then
    log "No files to archive. Skipping."
else
    log "Files found to archive: $FILES"

    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"

    echo "Archive name: $ZIP_FILE_NAME"

    FILE_LIST=$(mktemp)

    find "$SOURCE_DIR" -type f -name "*.log" -mtime +"$DAYS" -print0 > "$FILE_LIST"

    if tar --null -zvcf "$ZIP_FILE_NAME" -T "$FILE_LIST"; then

        log "Archival is successful"

        while IFS= read -r -d '' filepath; do
            log "Deleting file: $filepath"
            rm -f -- "$filepath"
            log "Deleted file: $filepath"
        done < "$FILE_LIST"

    else
        log "Archival failed"
        rm -f "$FILE_LIST"
        exit 1
    fi

    rm -f "$FILE_LIST"
fi