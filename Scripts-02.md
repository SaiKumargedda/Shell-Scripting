# Shell Scripting README – Part 2

## (Functions, Arrays, Redirection, Pipes & Text Processing Commands)

---

# 1. Difference Between (), {}, [], [[]], (()), $()

## ( )

Runs commands in a **subshell**.

Changes made inside do not affect the parent shell.

Example

```bash
pwd

(
cd /tmp
pwd
)

pwd
```

Output

```text
/home/sai

/tmp

/home/sai
```

**Interview Point:** Used when you want temporary environment changes.

---

## { }

Runs commands in the **current shell**.

Changes remain after execution.

Example

```bash
pwd

{
cd /tmp
pwd
}

pwd
```

Output

```text
/home/sai

/tmp

/tmp
```

---

## [ ]

Traditional test command.

Example

```bash
FILE="/etc/passwd"

if [ -f "$FILE" ]
then
echo "Exists"
fi
```

Output

```text
Exists
```

---

## [[ ]]

Advanced Bash test.

Supports:

* Pattern Matching
* &&
* ||
* Safer string comparison

Example

```bash
NAME="Sai"

if [[ "$NAME" == S* ]]
then
echo "Matched"
fi
```

Output

```text
Matched
```

---

## (( ))

Arithmetic Evaluation

Example

```bash
count=5

((count++))

echo $count
```

Output

```text
6
```

Another example

```bash
echo $((10+20))
```

Output

```text
30
```

---

## $( )

Command substitution

Example

```bash
HOST=$(hostname)

echo $HOST
```

Output

```text
aks-node-01
```

---

# Summary

```text
()      -> Subshell

{}      -> Current Shell

[]      -> Test

[[]]    -> Advanced Test

(())    -> Arithmetic

$()     -> Command Substitution
```

---

# 2. Functions

Basic Function

```bash
hello(){

echo "Hello DevOps"

}

hello
```

Output

```text
Hello DevOps
```

---

Function With Parameter

```bash
deploy(){

echo "Deploying $1"

}

deploy payment-api
```

Output

```text
Deploying payment-api
```

---

Multiple Parameters

```bash
deploy(){

echo "Application : $1"

echo "Environment : $2"

}

deploy payment-api prod
```

Output

```text
Application : payment-api

Environment : prod
```

---

Return Example

```bash
check(){

return 0

}

check

echo $?
```

Output

```text
0
```

---

# 3. Arrays

Create Array

```bash
servers=("dev" "qa" "uat" "prod")
```

Access First Element

```bash
echo ${servers[0]}
```

Output

```text
dev
```

All Elements

```bash
echo ${servers[@]}
```

Output

```text
dev qa uat prod
```

Length

```bash
echo ${#servers[@]}
```

Output

```text
4
```

Loop Through Array

```bash
for server in "${servers[@]}"

do

echo $server

done
```

Output

```text
dev

qa

uat

prod
```

---

# 4. Input & Output Redirection

Overwrite

```bash
echo "Hello" > file.txt
```

Contents

```text
Hello
```

---

Append

```bash
echo "World" >> file.txt
```

Contents

```text
Hello

World
```

---

Input Redirection

```bash
wc -l < file.txt
```

Output

```text
2
```

---

Standard Error

```bash
ls abc 2>error.log
```

Output

```text
No terminal output

Error stored in error.log
```

---

Both Output and Error

```bash
command >output.log 2>&1
```

Everything goes into output.log.

---

Discard Output

```bash
command >/dev/null 2>&1
```

Used in automation scripts.

---

# 5. Pipes

Pipe passes output from one command as input to another.

Example

```bash
ps -ef | grep nginx
```

Output

```text
root 1234 nginx
```

---

Another Example

```bash
kubectl get pods | grep Running
```

Output

```text
payment-api Running
```

---

# 6. grep

Search text.

Create file

```bash
cat app.log
```

```text
INFO Started

ERROR DB Down

INFO Restarted
```

Search

```bash
grep ERROR app.log
```

Output

```text
ERROR DB Down
```

Ignore Case

```bash
grep -i error app.log
```

Recursive

```bash
grep -r ERROR logs/
```

Line Numbers

```bash
grep -n ERROR app.log
```

Output

```text
2: ERROR DB Down
```

---

# 7. awk

Print Columns

```bash
df -h
```

Example Output

```text
Filesystem Size Used Avail Use%

/dev/sda1 50G 30G 20G 60%
```

Command

```bash
df -h | awk 'NR==2 {print $5}'
```

Output

```text
60%
```

Pods

```bash
kubectl get pods
```

Command

```bash
kubectl get pods | awk '{print $1}'
```

Output

```text
payment-api
```

---

# 8. sed

Replace Text

```bash
echo "Dev" | sed 's/Dev/Prod/'
```

Output

```text
Prod
```

Replace All

```bash
echo "aa aa aa" | sed 's/aa/bb/g'
```

Output

```text
bb bb bb
```

Replace Inside File

```bash
sed -i 's/dev/prod/g' config.txt
```

---

# 9. cut

Create File

```text
Sai:DevOps:Bangalore
```

Command

```bash
cut -d ":" -f1 employee.txt
```

Output

```text
Sai
```

Second Field

```bash
cut -d ":" -f2 employee.txt
```

Output

```text
DevOps
```

---

# 10. sort

Numbers

```bash
cat numbers.txt
```

```text
5

3

8

1
```

Command

```bash
sort -n numbers.txt
```

Output

```text
1

3

5

8
```

Reverse

```bash
sort -nr numbers.txt
```

Output

```text
8

5

3

1
```

---

# 11. uniq

Input

```text
apple

apple

banana

banana

orange
```

Command

```bash
uniq fruits.txt
```

Output

```text
apple

banana

orange
```

Count

```bash
uniq -c fruits.txt
```

Output

```text
2 apple

2 banana

1 orange
```

---

# 12. xargs

Input

```text
file1

file2

file3
```

Command

```bash
cat files.txt | xargs rm
```

Equivalent

```bash
rm file1 file2 file3
```

---

# 13. find

Find File

```bash
find /var/log -name "*.log"
```

Output

```text
/var/log/messages.log
```

Delete Old Logs

```bash
find /var/log -name "*.log" -mtime +30 -delete
```

Find Large Files

```bash
find / -size +500M
```

---

# 14. tee

Display and Save Output

```bash
echo "Deployment Success" | tee deploy.log
```

Terminal Output

```text
Deployment Success
```

deploy.log

```text
Deployment Success
```

Append

```bash
echo "Completed" | tee -a deploy.log
```

---

# 15. Real-Time DevOps Examples

Disk Usage

```bash
df -h
```

Memory

```bash
free -m
```

CPU

```bash
top -bn1
```

Running Processes

```bash
ps -ef
```

Search Process

```bash
ps -ef | grep java
```

Check Service

```bash
systemctl status nginx
```

Restart Service

```bash
systemctl restart nginx
```

View Logs

```bash
tail -100 app.log
```

Follow Logs

```bash
tail -f app.log
```

Current Directory

```bash
pwd
```

List Files

```bash
ls -ltr
```

Create Directory

```bash
mkdir test
```

Delete Directory

```bash
rm -rf test
```

Copy File

```bash
cp source.txt destination.txt
```

Move File

```bash
mv old.txt new.txt
```

Display File

```bash
cat file.txt
```

Search History

```bash
history
```

Current User

```bash
whoami
```

Hostname

```bash
hostname
```

Current Date

```bash
date
```

---

# Interview Summary

✔ (), {}, [], [[]], (()), $()

✔ Functions

✔ Parameters

✔ Return

✔ Arrays

✔ Input/Output Redirection

✔ Standard Error

✔ Pipes

✔ grep

✔ awk

✔ sed

✔ cut

✔ sort

✔ uniq

✔ xargs

✔ find

✔ tee

✔ Real-time Linux commands used by DevOps Engineers
