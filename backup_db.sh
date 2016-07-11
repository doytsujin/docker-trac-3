#!/bin/bash

trac-admin /home/trac/src/project hotcopy /tmp/backupdir
cp /tmp/backupdir/db/postgres-db-backup.sql.gz /home/trac/backup/

