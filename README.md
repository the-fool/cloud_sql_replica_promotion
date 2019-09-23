# Cloud SQL Replication Promotion

Promote your Cloud SQL replica to be a master!

## Usage

```bash
promote.sh PROJECT_NAME INSTANCE_NAME FAILOVER_NAME [BACKUP_TIME]
```

For example: `./promote.sh my-gcp-project replica-db replica-db-failover 12:00`

## Why this script?

This script does more than just promotion -- it enables backups, binary logging, and high-availability (failover replication for your new master).