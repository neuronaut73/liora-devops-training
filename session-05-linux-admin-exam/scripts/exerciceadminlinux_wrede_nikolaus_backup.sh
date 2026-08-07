#!/usr/bin/env bash

set -euo pipefail

BACKUP_ROOT="/home/ubuntu/liora/session-05-linux-admin-exam/backups"
STAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
DEST="$BACKUP_ROOT/$STAMP"

mkdir -p "$DEST"

# 1. WordPress application files
tar -czf "$DEST/wordpress_files.tar.gz" \
    /var/www/wordpress

# 2. MariaDB database
mariadb-dump --single-transaction wordpress \
    | gzip > "$DEST/wordpress_database.sql.gz"

# 3. Server configuration
tar -czf "$DEST/system_configs.tar.gz" \
    /etc/nginx \
    /etc/php/8.3/fpm \
    /etc/mysql \
    /etc/letsencrypt

# Keep backups for 7 days
find "$BACKUP_ROOT" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -mtime +7 \
    -exec rm -rf {} +

echo "$(date -Is) - Backup completed successfully: $DEST"
