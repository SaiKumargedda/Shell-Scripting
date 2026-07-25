# Shell Scripting README – Part 3

## (Enterprise Shell Scripts, Error Handling, Cron Jobs & Debugging)

---

# 1. Enterprise Script Structure

A production-ready shell script should typically follow this structure:

```bash
#!/bin/bash

set -e
set -u
set -o pipefail

LOG_FILE="/var/log/deploy.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $1" | tee -a "$LOG_FILE"
}

main() {

    log "Deployment Started"

    # Validate prerequisites

    # Execute deployment

    # Verify deployment

    log "Deployment Completed"

}

main
```

---

# 2. Understanding set -euo pipefail

## set -e

Exit immediately if any command fails.

Example

```bash
#!/bin/bash

set -e

echo "Step 1"

mkdir /tmp/test

cp file.txt /backup/

echo "Completed"
```

If `cp` fails:

Output

```
Step 1

cp: cannot stat file.txt

Script exits immediately
```

---

## set -u

Fails when an undefined variable is used.

Example

```bash
#!/bin/bash

set -u

echo $APP_NAME
```

Output

```
bash: APP_NAME: unbound variable
```

---

## set -o pipefail

Without pipefail

```bash
cat file.txt | grep ERROR
```

If `cat` fails but `grep` succeeds, the script may still return success.

With

```bash
set -o pipefail
```

the pipeline fails if **any** command fails.

---

# 3. Logging Function

```bash
log(){

echo "$(date '+%Y-%m-%d %H:%M:%S') : $1"

}
```

Example

```bash
log "Deployment Started"
```

Output

```
2026-07-23 10:15:22 : Deployment Started
```

---

# 4. Enterprise Deployment Script

```bash
#!/bin/bash

set -euo pipefail

APP="payment-api"

NAMESPACE="dev"

echo "Checking Cluster..."

kubectl cluster-info

echo "Deploying..."

kubectl apply -f deployment.yaml -n $NAMESPACE

kubectl rollout status deployment/$APP -n $NAMESPACE

echo "Deployment Successful"

exit 0
```

---

# 5. Health Check Script

```bash
#!/bin/bash

echo "Hostname"

hostname

echo

echo "Disk"

df -h

echo

echo "Memory"

free -m

echo

echo "CPU"

top -bn1 | head -5
```

---

# 6. Disk Monitoring Script

```bash
#!/bin/bash

THRESHOLD=80

usage=$(df -h / | awk 'NR==2 {gsub("%","",$5);print $5}')

if [ "$usage" -ge "$THRESHOLD" ]
then

echo "Disk Usage High"

else

echo "Disk Usage Normal"

fi
```

Example Output

```
Disk Usage Normal
```

---

# 7. Memory Monitoring Script

```bash
#!/bin/bash

free -m | awk 'NR==2{print "Used:",$3,"MB"}'
```

Output

```
Used: 2145 MB
```

---

# 8. CPU Monitoring Script

```bash
#!/bin/bash

top -bn1 | grep Cpu
```

Example Output

```
Cpu(s): 12%us 4%sy 84%id
```

---

# 9. Service Monitoring Script

```bash
#!/bin/bash

SERVICE="nginx"

if systemctl is-active --quiet $SERVICE

then

echo "Service Running"

else

echo "Restarting"

systemctl restart $SERVICE

fi
```

---

# 10. Process Monitoring Script

```bash
#!/bin/bash

PROCESS="java"

if pgrep $PROCESS >/dev/null

then

echo "Process Running"

else

echo "Process Not Running"

fi
```

---

# 11. Backup Script

```bash
#!/bin/bash

SOURCE=/app

DEST=/backup

DATE=$(date +%F)

tar -czf $DEST/app-$DATE.tar.gz $SOURCE

echo "Backup Completed"
```

Output

```
Backup Completed
```

---

# 12. Log Cleanup Script

Delete logs older than 30 days.

```bash
#!/bin/bash

find /var/log/myapp -name "*.log" -mtime +30 -delete
```

---

# 13. File Existence Script

```bash
#!/bin/bash

FILE="/etc/passwd"

if [ -f "$FILE" ]

then

echo "Exists"

else

echo "Missing"

fi
```

Output

```
Exists
```

---

# 14. User Creation Script

```bash
#!/bin/bash

USER=$1

if id "$USER" >/dev/null 2>&1

then

echo "Already Exists"

else

useradd "$USER"

echo "Created"

fi
```

---

# 15. Ping Script

```bash
#!/bin/bash

HOST=google.com

if ping -c 2 $HOST >/dev/null

then

echo "Reachable"

else

echo "Not Reachable"

fi
```

---

# 16. Docker Container Check

```bash
#!/bin/bash

docker ps | grep nginx
```

Output

```
nginx running
```

---

# 17. Kubernetes Cluster Check

```bash
#!/bin/bash

kubectl get nodes
```

Example Output

```
aks-nodepool1 Ready

aks-nodepool2 Ready
```

---

# 18. Rollout Verification

```bash
kubectl rollout status deployment/payment-api
```

Output

```
deployment successfully rolled out
```

---

# 19. Exit Code Handling

Example

```bash
mvn clean package

if [ $? -eq 0 ]

then

echo "Build Success"

else

echo "Build Failed"

fi
```

---

# 20. Debugging Scripts

Run Script

```bash
bash -x deploy.sh
```

Enable Debug

```bash
set -x
```

Disable

```bash
set +x
```

---

# 21. Cron Jobs

List

```bash
crontab -l
```

Edit

```bash
crontab -e
```

Delete

```bash
crontab -r
```

---

# 22. Cron Format

```
* * * * * command

| | | | |

| | | | +---- Day of Week

| | | +------ Month

| | +-------- Day

| +---------- Hour

+------------ Minute
```

---

# 23. Cron Examples

Every 5 Minutes

```bash
*/5 * * * * /home/devops/check.sh
```

Daily 2 AM

```bash
0 2 * * * /home/devops/backup.sh
```

Every Hour

```bash
0 * * * * /home/devops/health.sh
```

Sunday 1 AM

```bash
0 1 * * 0 cleanup.sh
```

---

# 24. Redirect Cron Output

```bash
0 2 * * * /home/devops/backup.sh >> /var/log/backup.log 2>&1
```

---

# 25. Cron Service

Check

```bash
systemctl status crond
```

Start

```bash
systemctl start crond
```

Enable

```bash
systemctl enable crond
```

---

# 26. Enterprise Best Practices

✔ Use `#!/bin/bash`

✔ Use `set -euo pipefail`

✔ Validate user input

✔ Quote variables (`"$VAR"`)

✔ Use functions

✔ Log important actions

✔ Return meaningful exit codes

✔ Avoid hardcoded values

✔ Redirect logs

✔ Handle failures gracefully

✔ Keep scripts modular

---

# 27. Common Interview Questions

**Q. Why use `set -euo pipefail`?**

To stop execution on failures, catch undefined variables, and ensure pipeline failures are detected.

---

**Q. How do you debug a shell script?**

* `bash -x script.sh`
* `set -x`
* Check logs
* Verify exit codes (`$?`)

---

**Q. What scripts have you written?**

* Deployment automation
* Health check
* Disk monitoring
* Memory monitoring
* CPU monitoring
* Backup automation
* Log cleanup
* Service monitoring
* Process monitoring
* Kubernetes deployment scripts
* Cron-based automation

---

# 28. Real-Time DevOps Scenario

**Scenario:** Jenkins pipeline fails after deployment.

**Troubleshooting Steps:**

1. Check Jenkins console logs.
2. Verify shell script exit code.
3. Check `kubectl rollout status`.
4. Verify pod status (`kubectl get pods`).
5. Check pod logs (`kubectl logs`).
6. Check Kubernetes events (`kubectl describe pod`).
7. Roll back deployment if required.

---

# Interview Summary

After completing Parts 1–3, you should be comfortable with:

* Bash fundamentals
* Variables and operators
* Conditions and loops
* Functions and arrays
* Redirection and pipes
* Text-processing commands
* `set -euo pipefail`
* Logging
* Exit code handling
* Cron jobs
* Enterprise shell scripting
* Monitoring scripts
* Deployment automation
* Debugging
* Production troubleshooting
