# Shell Scripting README – Part 1

## (Fundamentals, Variables, Operators, Conditions & Loops)

---

# 1. What is Shell?

A Shell is a command-line interpreter that acts as an interface between the user and the Linux Kernel.

Flow:

```
User
 ↓
Shell
 ↓
Kernel
 ↓
Hardware
```

Examples of shells:

* sh
* bash
* ksh
* csh
* tcsh
* zsh

Bash (Bourne Again Shell) is the most commonly used shell in DevOps.

---

# 2. What is Shell Scripting?

Shell scripting is writing Linux commands into a file so they can be executed automatically.

Instead of running:

```bash
git pull

mvn clean package

docker build -t app:1.0 .

docker push app:1.0
```

Create one script:

```bash
#!/bin/bash

git pull

mvn clean package

docker build -t app:1.0 .

docker push app:1.0
```

Execute:

```bash
chmod +x deploy.sh

./deploy.sh
```

---

# 3. Shebang

```
#!/bin/bash
```

Specifies the Bash interpreter.

Without shebang the OS may use another shell.

---

# 4. Comments

```bash
# Single line comment
```

Used for documentation.

---

# 5. Variables

Create variable

```bash
NAME="Sai"
```

Print variable

```bash
echo $NAME
```

Output

```
Sai
```

Rules

✓ No spaces around =

Correct

```bash
NAME="DevOps"
```

Wrong

```bash
NAME = DevOps
```

Variables are case-sensitive.

---

# 6. Environment Variables

Home directory

```bash
echo $HOME
```

Output

```
/home/sai
```

Logged in user

```bash
echo $USER
```

Output

```
sai
```

Present Working Directory

```bash
echo $PWD
```

Output

```
/home/sai
```

Hostname

```bash
echo $HOSTNAME
```

Output

```
aks-agent-01
```

PATH

```bash
echo $PATH
```

Output

```
/usr/local/bin:/usr/bin:/bin:...
```

---

# 7. Read User Input

```bash
echo "Enter your name"

read NAME

echo $NAME
```

Output

```
Enter your name

Sai

Sai
```

---

# 8. Command Substitution

Old style

```bash
DATE=`date`
```

Preferred

```bash
DATE=$(date)

echo $DATE
```

Output

```
Thu Jul 23 10:30:15 IST 2026
```

Hostname

```bash
HOST=$(hostname)

echo $HOST
```

Output

```
aks-node-01
```

---

# 9. Special Variables

Script

```bash
#!/bin/bash

echo $0
echo $1
echo $2
echo $#
echo $@
echo $$
echo $!
```

Execute

```bash
./test.sh dev qa
```

Output

```
./test.sh

dev

qa

2

dev qa

24567
```

Meaning

```
$0 -> Script Name

$1 -> First Argument

$2 -> Second Argument

$# -> Number of Arguments

$@ -> All Arguments

$$ -> Current Process ID

$! -> Background Process ID

$? -> Exit Code
```

---

# 10. Exit Codes

Check exit status

```bash
echo $?
```

Success

```
0
```

Common Exit Codes

```
0     Success

1     General Error

2     Incorrect Usage

126   Permission Denied

127   Command Not Found

130   Ctrl + C

137   SIGKILL / OOMKilled

143   SIGTERM

255   General Failure
```

Example

```bash
mkdir test

echo $?
```

Output

```
0
```

Example

```bash
dockerr ps

echo $?
```

Output

```
127
```

---

# 11. Arithmetic Operators

Addition

```bash
echo $((20+10))
```

Output

```
30
```

Subtraction

```bash
echo $((20-10))
```

Output

```
10
```

Multiplication

```bash
echo $((20*10))
```

Output

```
200
```

Division

```bash
echo $((20/10))
```

Output

```
2
```

Modulus

```bash
echo $((20%3))
```

Output

```
2
```

---

# 12. Numeric Comparison Operators

```
-eq

-ne

-gt

-lt

-ge

-le
```

Example

```bash
age=25

if [ $age -gt 18 ]
then
echo Adult
fi
```

Output

```
Adult
```

---

# 13. String Operators

Equal

```bash
if [ "$name" = "Sai" ]
```

Not Equal

```bash
if [ "$name" != "Sai" ]
```

Empty String

```bash
-z
```

Not Empty

```bash
-n
```

---

# 14. Logical Operators

AND

```bash
&&
```

OR

```bash
||
```

NOT

```bash
!
```

Example

```bash
if [ $a -gt 10 ] && [ $b -lt 20 ]
then
echo TRUE
fi
```

Output

```
TRUE
```

---

# 15. File Test Operators

```
-f

-d

-e

-r

-w

-x

-s
```

Example

```bash
if [ -f /etc/passwd ]
then
echo File Exists
fi
```

Output

```
File Exists
```

---

# 16. if Statement

```bash
age=25

if [ $age -ge 18 ]
then
echo Eligible
fi
```

Output

```
Eligible
```

---

# 17. if else

```bash
age=16

if [ $age -ge 18 ]
then
echo Eligible

else

echo Not Eligible

fi
```

Output

```
Not Eligible
```

---

# 18. elif

```bash
marks=75

if [ $marks -ge 90 ]
then

echo Grade A

elif [ $marks -ge 75 ]
then

echo Grade B

else

echo Grade C

fi
```

Output

```
Grade B
```

---

# 19. Nested if

```bash
USER="admin"

PASSWORD="DevOps123"

if [ "$USER" = "admin" ]
then

if [ "$PASSWORD" = "DevOps123" ]
then

echo Login Success

else

echo Wrong Password

fi

fi
```

Output

```
Login Success
```

---

# 20. case Statement

```bash
read ENV

case $ENV in

dev)

echo Deploy Dev
;;

qa)

echo Deploy QA
;;

prod)

echo Deploy PROD
;;

*)

echo Invalid
;;

esac
```

Input

```
prod
```

Output

```
Deploy PROD
```

---

# 21. for Loop

```bash
for i in 1 2 3 4 5

do

echo $i

done
```

Output

```
1

2

3

4

5
```

---

# 22. C Style For Loop

```bash
for ((i=1;i<=5;i++))

do

echo $i

done
```

Output

```
1

2

3

4

5
```

---

# 23. while Loop

```bash
count=1

while [ $count -le 5 ]

do

echo $count

((count++))

done
```

Output

```
1

2

3

4

5
```

---

# 24. until Loop

```bash
count=1

until [ $count -gt 5 ]

do

echo $count

((count++))

done
```

Output

```
1

2

3

4

5
```

---

# 25. break

```bash
for i in {1..5}

do

if [ $i -eq 3 ]

then

break

fi

echo $i

done
```

Output

```
1

2
```

---

# 26. continue

```bash
for i in {1..5}

do

if [ $i -eq 3 ]

then

continue

fi

echo $i

done
```

Output

```
1

2

4

5
```

---

# Interview Summary

✔ Shell Basics

✔ Variables

✔ Environment Variables

✔ User Input

✔ Command Substitution

✔ Special Variables

✔ Exit Codes

✔ Arithmetic Operators

✔ Numeric Operators

✔ String Operators

✔ Logical Operators

✔ File Operators

✔ if / else / elif

✔ Nested if

✔ case

✔ for

✔ while

✔ until

✔ break

✔ continue
