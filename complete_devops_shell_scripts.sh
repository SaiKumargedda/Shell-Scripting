#!/bin/bash

############################################################
# COMPLETE DEVOPS SHELL SCRIPTS (WITH OUTPUT + EXPLANATION)
############################################################

############################
# 1. SCRIPT MODES & EXIT CODES
############################
# set -e -> exit on error
# set -u -> undefined variable error
# set -x -> debug mode
# set -o pipefail -> pipeline failure detection

set -euo pipefail

echo "Script running in strict mode"
echo "Exit code of last command: $?"

# Expected Output:
# Script running in strict mode
# Exit code of last command: 0

############################
# 2. FUNCTIONS + ARGUMENTS
############################

log() {
    echo "$(date) - $1"
}

check_arg() {
    if [ $# -eq 0 ]; then
        echo "No arguments passed"
    else
        echo "Arguments: $@"
    fi
}

log "Testing functions"
check_arg "dev" "prod"

# Output:
# <date> - Testing functions
# Arguments: dev prod

############################
# 3. WHILE LOOP EXAMPLE
############################

count=1
while [ $count -le 3 ]
do
    echo "Count: $count"
    ((count++))
done

# Output:
# Count: 1
# Count: 2
# Count: 3

############################
# 4. LOG ROTATION + CLEANUP
############################

LOG_DIR="/tmp/myapp"
LOG_FILE="$LOG_DIR/app.log"
ARCHIVE_DIR="$LOG_DIR/archive"
DAYS=20
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p $ARCHIVE_DIR

echo "Sample log data" >> $LOG_FILE

# Rotate
mv $LOG_FILE $ARCHIVE_DIR/app_$DATE.log

touch $LOG_FILE

# Cleanup old logs
find $ARCHIVE_DIR -type f -name "*.log" -mtime +$DAYS -exec rm -f {} \;

echo "Log rotated and old logs deleted"

# Output:
# Log rotated and old logs deleted

############################
# 5. DISK USAGE CHECK
############################

THRESHOLD=80

df -h | awk '{print $5 " " $1}' | tail -n +2 | while read output
do
    usage=$(echo $output | cut -d'%' -f1)
    partition=$(echo $output | awk '{print $2}')

    if [ $usage -ge $THRESHOLD ]; then
        echo "ALERT: $partition usage $usage%"
    fi
done

# Output (example):
# ALERT: /dev/sda1 usage 85%

############################
# 6. GREP / AWK / SED
############################

echo -e "ERROR\nINFO\nWARN" > sample.log

grep "ERROR" sample.log
awk '{print $1}' sample.log
sed -i 's/INFO/DEBUG/g' sample.log

# Output:
# ERROR
# ERROR
# INFO
# WARN

############################
# 7. KUBERNETES POD CLEANUP
############################

# Simulated output (kubectl required in real)
echo "pod1 Running"
echo "pod2 CrashLoopBackOff" | while read pod status

do
    if [[ "$status" != "Running" ]]; then
        echo "Deleting $pod"
    fi
done

# Output:
# Deleting pod2

############################
# 8. BACKUP SCRIPT
############################

SRC="/tmp/data"
DEST="/tmp/backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p $SRC $DEST

echo "data" > $SRC/file.txt

tar -czf $DEST/backup_$DATE.tar.gz $SRC

echo "Backup created"

# Output:
# Backup created

############################
# 9. DOCKER BUILD (SIMULATED)
############################

IMAGE="myapp"
TAG=123

echo "docker build -t $IMAGE:$TAG ."
echo "docker push repo/$IMAGE:$TAG"

# Output:
# docker build -t myapp:123 .
# docker push repo/myapp:123

############################
# 10. SERVER HEALTH CHECK
############################

echo "CPU:"
echo "Memory:"
echo "Disk:"

# Output:
# CPU:
# Memory:
# Disk:

############################################################
# END
############################################################
