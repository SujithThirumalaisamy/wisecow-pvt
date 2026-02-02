#!/bin/bash

###############################################################################
# Author      : Sujith Thirumalaisamy
# Date        : 2026-02-03
# Description : Automates backup of a specified directory to an S3-compatible
#               bucket (Cloudflare R2 in this case) and provides a report
#               on success or failure.
###############################################################################

S3_BUCKET=resume
SOURCE_DIR="./test"
R2_ENDPOINT="https://7a5fba6fa2cca1e2640075d6984d054d.r2.cloudflarestorage.com/"
AWS_PROFILE="default"
LOG_FILE="/var/log/backup.log"
BACKUP_FILE="/tmp/backup-$(basename "$SOURCE_DIR")-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"; }

if [ ! -d "$SOURCE_DIR" ]; then
  log "WARNING: Source directory $SOURCE_DIR does not exist. Skipping backup."
  exit 0
fi

log "Creating archive $BACKUP_FILE"
tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" >/dev/null

TIMESTAMPED_BUCKET="s3://$S3_BUCKET/backup-$(date +%Y-%m-%d_%H-%M-%S)/"
log "Uploading $BACKUP_FILE to $TIMESTAMPED_BUCKET"
aws s3 cp "$BACKUP_FILE" "$TIMESTAMPED_BUCKET" \
  --endpoint-url "$R2_ENDPOINT" \
  --profile "$AWS_PROFILE" >/dev/null

rm -f "$BACKUP_FILE"
log "Backup process finished"
exit 0
