#!/bin/bash

set -e

if [ $# -lt 3 ] || [$# -gt 4]; then
    echo "Usage: promote.sh PROJECT_NAME INSTANCE_NAME FAILOVER_NAME [BACKUP_TIME]"
    exit 1
fi

DEFAULT_BACKUP="23:00"
PROJECT_NAME=$1
INSTANCE_NAME=$2
FAILOVER_NAME=$3
BACKUP_TIME="${$4:-$DEFAULT_BACKUP}"

echo "Promoting replica: $INSTANCE_NAME"
gcloud sql instances promote-replica $INSTANCE_NAME \
    -- project $PROJECT_NAME

echo "Enabling backups and binary logging"
gcloud sql instances patch $INSTANCE_NAME \
    --project $PROJECT_NAME \
    --enable-bin-log \
    --backup-start-time 23:00

echo "Adding failover replica"
gcloud sql instances create $FAILOVER_NAME \
    --project $PROJECT_NAME \
    --master-instance-name=$INSTANCE_NAME \
    --replica-type=FAILOVER