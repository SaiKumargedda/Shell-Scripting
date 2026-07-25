# Shell Scripting Interview Notes (4+ Years DevOps)

## 1. Introduction

* Shell is a command-line interpreter between the user and the Linux kernel.
* Shell Scripting is writing multiple Linux commands in a file to automate repetitive tasks.
* Common shells:

  * sh (Bourne Shell)
  * bash (Bourne Again Shell)
  * ksh
  * csh
  * tcsh
  * zsh
* Bash is the most commonly used shell in DevOps environments.

---

# 2. Shell vs Terminal vs CLI

**Shell**

* Interprets commands.
* Example: bash, sh, zsh.

**Terminal**

* Application used to access the shell.
* Example: GNOME Terminal, PuTTY, Windows Terminal.

**CLI**

* Command Line Interface used to interact with the operating system.

---

# 3. First Shell Script

```bash
#!/bin/bash

echo "Hello World"
```

Give execute permission:

```bash
chmod +x hello.sh
```

Execute:

```bash
./hello.sh
```

---

# 4. Shebang

```bash
#!/bin/bash
```

Specifies that the script should be executed using the Bash interpreter.

---

# 5. Comments

```bash
# Single line comment
```

Used for documentation and readability.

---

# 6. Variables

```bash
NAME="Sai"

echo $NAME
```

Rules:

* No spaces around `=`.
* Variables are case-sensitive.
* Access variables using `$`.

---

# 7. Environment Variables

Common variables:

```bash
echo $HOME
echo $USER
echo $PATH
echo $PWD
echo $HOSTNAME
```

---

# 8. User Input

```bash
read NAME

echo $NAME
```

---

# 9. Command Substitution

Preferred:

```bash
DATE=$(date)
HOST=$(hostname)
```

---

# 10. Special Variables

| Variable | Meaning                         |
| -------- | ------------------------------- |
| $0       | Script name                     |
| $1       | First argument                  |
| $2       | Second argument                 |
| $#       | Number of arguments             |
| $@       | All arguments                   |
| $$       | Current process ID              |
| $!       | Background process ID           |
| $?       | Exit status of previous command |

---

# 11. Exit Codes

| Exit Code | Meaning                              |
| --------- | ------------------------------------ |
| 0         | Success                              |
| 1         | General error                        |
| 2         | Incorrect command usage              |
| 126       | Command found but cannot execute     |
| 127       | Command not found                    |
| 130       | Interrupted using Ctrl+C             |
| 137       | Process killed (SIGKILL / OOMKilled) |
| 143       | Graceful termination (SIGTERM)       |
| 255       | General application/SSH failure      |

Check exit status:

```bash
echo $?
```

---

# 12. Arithmetic Operators

```bash
$((a+b))
$((a-b))
$((a*b))
$((a/b))
$((a%b))
```

---

# 13. Numeric Comparison Operators

```text
-eq
-ne
-gt
-lt
-ge
-le
```

---

# 14. String Operators

```text
=
!=
-z
-n
```

---

# 15. Logical Operators

```bash
&&
||
!
```

---

# 16. File Test Operators

```text
-f
-d
-e
-r
-w
-x
-s
```

---

# 17. Conditional Statements

* if
* if-else
* elif
* nested if
* case

Example:

```bash
if [ $age -gt 18 ]
then
    echo "Adult"
fi
```

---

# 18. Loops

### for

```bash
for i in 1 2 3
do
    echo $i
done
```

### C-style for

```bash
for ((i=1;i<=5;i++))
do
    echo $i
done
```

### while

```bash
while [ $count -le 5 ]
do
    ((count++))
done
```

### until

Runs until the condition becomes true.

---

# 19. break and continue

* break → exits loop.
* continue → skips current iteration.

---

# 20. Bash Syntax

## ( )

Runs commands in a subshell.

Changes do not affect the parent shell.

```bash
(
cd /tmp
ls
)
```

---

## { }

Groups commands in the current shell.

```bash
{
echo "Hello"
echo "World"
}
```

---

## [ ]

Basic test command.

```bash
[ -f file.txt ]
```

---

## [[ ]]

Extended Bash test.

Supports:

* Pattern matching
* && and ||
* Better string handling

---

## (( ))

Arithmetic evaluation.

```bash
((count++))
```

---

## $( )

Command substitution.

```bash
DATE=$(date)
```

---

# 21. Functions

```bash
deploy(){

echo "Deploying"

}

deploy
```

Function with arguments:

```bash
deploy(){

echo $1

}

deploy payment-api
```

---

# 22. Arrays

```bash
servers=("dev" "qa" "prod")

echo ${servers[0]}

echo ${servers[@]}
```

---

# 23. Redirection

Overwrite:

```bash
>
```

Append:

```bash
>>
```

Input:

```bash
<
```

Error:

```bash
2>
```

Stdout + stderr:

```bash
> file.log 2>&1
```

---

# 24. Pipes

```bash
ps -ef | grep nginx
```

---

# 25. Important Linux Utilities

## grep

Search text.

## awk

Column extraction.

## sed

Search and replace.

## cut

Extract fields.

## sort

Sort lines.

## uniq

Remove duplicates.

## xargs

Pass output as arguments.

## find

Search files.

## tee

Display and save output simultaneously.

---

# 26. Enterprise Script Best Practice

Start every production script with:

```bash
#!/bin/bash

set -e
set -u
set -o pipefail
```

Meaning:

* set -e → Exit on first failure.
* set -u → Undefined variables cause failure.
* set -o pipefail → Pipeline fails if any command fails.

---

# 27. Logging Function

```bash
log(){

echo "$(date): $1"

}
```

---

# 28. Enterprise Deployment Script Flow

* Validate input.
* Check required commands.
* Check AKS connectivity.
* Deploy.
* Wait for rollout.
* Log status.
* Exit with proper exit code.

---

# 29. Cron Jobs

View cron jobs:

```bash
crontab -l
```

Create/Edit:

```bash
crontab -e
```

Delete:

```bash
crontab -r
```

Examples:

Every 5 minutes:

```bash
*/5 * * * * /home/devops/script.sh
```

Daily at 2 AM:

```bash
0 2 * * * /home/devops/backup.sh
```

Every Sunday:

```bash
0 1 * * 0 cleanup.sh
```

Redirect logs:

```bash
0 2 * * * backup.sh >> backup.log 2>&1
```

Cron service:

```bash
systemctl status crond
systemctl start crond
systemctl enable crond
```

---

# 30. Common Automation Scripts

* Disk monitoring.
* Memory monitoring.
* CPU monitoring.
* Service monitoring.
* Process monitoring.
* Backup automation.
* Log cleanup.
* User creation.
* Health check.
* Deployment.
* Kubernetes utilities.

---

# 31. AKS Shell Scripts

* Get all pods.
* Restart deployment.
* Scale deployment.
* Verify rollout.
* Check node health.
* Collect pod logs.
* Find failed pods.
* AKS authentication:

```bash
az aks get-credentials
```

* ACR login:

```bash
az acr login
```

---

# 32. Debugging Scripts

Enable debug:

```bash
bash -x script.sh
```

or

```bash
set -x
```

Disable:

```bash
set +x
```

---

# 33. Interview Scenarios

* Deployment failed.
* Jenkins pipeline failed.
* Disk full.
* Service down.
* kubectl works locally but not in Jenkins.
* Cron job not executing.
* OOMKilled container.
* Rolling deployment failure.
* Pod log collection.
* Cluster connectivity failure.

---

# 34. Common Interview Questions

* What is Shell Scripting?
* Why Bash?
* Explain Shebang.
* Explain set -euo pipefail.
* Explain exit codes.
* Difference between [ ], [[ ]], (( )), ( ), { }, $( ).
* Difference between grep, awk and sed.
* Difference between break and continue.
* Difference between exit and return.
* Difference between $* and $@.
* What are Cron jobs?
* How do you debug a script?
* Explain 137 and 143 exit codes.
* Which automation scripts have you written?

---

# 35. Best Practices

* Use #!/bin/bash.
* Start with set -euo pipefail.
* Quote variables ("$VAR").
* Check exit codes.
* Validate input.
* Use functions.
* Use logging.
* Avoid hardcoded values.
* Use meaningful variable names.
* Keep scripts modular.
* Handle errors gracefully.
* Redirect logs for troubleshooting.

---

# 36. Final Interview Summary

For a 4+ years DevOps Engineer, you should be comfortable explaining and writing shell scripts for:

* Linux automation
* Jenkins pipeline integration
* AKS operational tasks
* Deployment automation
* Monitoring scripts
* Backup scripts
* Cleanup scripts
* Troubleshooting scripts
* Cron-based scheduling
* Enterprise scripting best practices
* Debugging and error handling

This level of knowledge is sufficient for most DevOps interviews covering Bash/Shell Scripting.
