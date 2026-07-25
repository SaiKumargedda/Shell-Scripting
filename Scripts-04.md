# Shell Scripting README – Part 4

## (Azure AKS, Jenkins Integration, Real-Time DevOps Scripts & Interview Scenarios)

---

# 1. AKS Authentication Script

Used to download cluster credentials and update kubeconfig.

```bash
#!/bin/bash

RESOURCE_GROUP="rg-dev"
AKS_CLUSTER="aks-dev"

az aks get-credentials \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_CLUSTER \
  --overwrite-existing

kubectl get nodes
```

Expected Output

```text
Merged "aks-dev" as current context

NAME                STATUS   ROLES   AGE
aks-nodepool1-01    Ready    agent   20d
aks-nodepool1-02    Ready    agent   20d
```

---

# 2. Verify AKS Connectivity

```bash
#!/bin/bash

if kubectl cluster-info >/dev/null 2>&1
then
    echo "AKS Cluster Reachable"
else
    echo "Unable to Connect"
fi
```

Output

```text
AKS Cluster Reachable
```

---

# 3. List All Pods

```bash
kubectl get pods -A
```

Output

```text
kube-system     coredns-xxxx         Running
dev             payment-api-xxx      Running
prod            order-api-xxx        Running
```

---

# 4. Restart Deployment

```bash
APP="payment-api"
NAMESPACE="dev"

kubectl rollout restart deployment/$APP -n $NAMESPACE

kubectl rollout status deployment/$APP -n $NAMESPACE
```

Output

```text
deployment restarted

deployment successfully rolled out
```

---

# 5. Scale Deployment

```bash
kubectl scale deployment payment-api \
--replicas=5 \
-n dev
```

Verify

```bash
kubectl get deployment payment-api -n dev
```

Output

```text
READY 5/5
```

---

# 6. Verify Rollout

```bash
kubectl rollout status deployment/payment-api -n dev
```

Output

```text
deployment successfully rolled out
```

---

# 7. Find Failed Pods

```bash
kubectl get pods -A | grep -v Running
```

Example Output

```text
payment-api-xyz CrashLoopBackOff
```

---

# 8. Describe Failed Pods

```bash
for pod in $(kubectl get pods -n dev --no-headers | awk '$3!="Running"{print $1}')
do
    echo "=========="
    echo $pod
    kubectl describe pod $pod -n dev
done
```

---

# 9. Collect Logs From All Pods

```bash
mkdir logs

for pod in $(kubectl get pods -n dev --no-headers | awk '{print $1}')
do
    kubectl logs $pod -n dev > logs/$pod.log
done
```

Result

```text
logs/

payment-api.log

order-api.log

inventory-api.log
```

---

# 10. Check Node Health

```bash
kubectl get nodes

kubectl top nodes
```

Output

```text
NAME          CPU   MEMORY

aks-node01    22%   58%

aks-node02    18%   44%
```

---

# 11. Check Pod Resource Usage

```bash
kubectl top pods -n dev
```

Output

```text
payment-api   60m   240Mi

order-api     45m   180Mi
```

---

# 12. Azure Container Registry Login

```bash
ACR_NAME=myacr

az acr login --name $ACR_NAME
```

Output

```text
Login Succeeded
```

---

# 13. Verify Kubernetes Context

```bash
kubectl config current-context
```

Output

```text
aks-dev
```

---

# 14. Jenkins Deployment Script

```bash
#!/bin/bash

git pull

mvn clean package

docker build -t payment-api:1.0 .

docker push myacr.azurecr.io/payment-api:1.0

kubectl apply -f deployment.yaml

kubectl rollout status deployment/payment-api
```

---

# 15. Jenkins Health Verification

```bash
kubectl get pods

kubectl get svc

kubectl get ingress
```

Pipeline should fail if any verification step fails.

---

# 16. Jenkins Cleanup Script

```bash
docker image prune -f

docker container prune -f

docker volume prune -f
```

---

# 17. Azure Login Script (Service Principal)

```bash
az login \
--service-principal \
-u <APP_ID> \
-p <PASSWORD> \
--tenant <TENANT_ID>
```

Commonly executed by CI/CD pipelines before Azure CLI operations.

---

# 18. Enterprise Deployment Flow

```text
Developer Push

↓

Jenkins / Azure DevOps

↓

Git Pull

↓

Maven Build

↓

Unit Tests

↓

SonarQube

↓

Veracode

↓

Docker Build

↓

Prisma Scan

↓

Push Image to ACR

↓

kubectl apply

↓

Rollout Verification

↓

Health Check

↓

Deployment Success
```

---

# 19. Real-Time DevOps Automation Scripts

Scripts commonly written by DevOps engineers:

* Health Check Script
* Deployment Script
* Rollback Script
* Disk Monitoring
* Memory Monitoring
* CPU Monitoring
* Backup Script
* Log Cleanup Script
* User Creation Script
* Service Restart Script
* AKS Authentication Script
* Rollout Verification Script
* Pod Log Collection Script
* Failed Pod Detection Script
* Container Health Check Script
* Cron Automation Scripts

---

# 20. Interview Scenarios

### Scenario 1

Pipeline succeeded but application isn't working.

Steps

1. Check rollout status.
2. Check pods.
3. Check logs.
4. Check events.
5. Verify image version.
6. Verify service.
7. Verify ingress.
8. Verify application health endpoint.

---

### Scenario 2

Pods are Pending.

Possible reasons

* No resources available.
* Node selector mismatch.
* Taints/Tolerations.
* PVC not bound.
* Image pull issue.

Commands

```bash
kubectl describe pod
```

---

### Scenario 3

CrashLoopBackOff

Commands

```bash
kubectl logs pod-name

kubectl describe pod pod-name
```

---

### Scenario 4

ImagePullBackOff

Checks

* Image exists in ACR.
* Image tag is correct.
* ImagePullSecret configured.
* ACR permissions.
* Managed Identity or Service Principal access.

---

### Scenario 5

OOMKilled

Checks

```bash
kubectl describe pod
```

Verify

* Memory requests
* Memory limits
* Application memory usage

---

### Scenario 6

Jenkins Script Fails

Verify

* Execute permission (`chmod +x`)
* Environment variables
* Credentials
* PATH
* Exit code (`$?`)
* Console logs

---

### Scenario 7

Cron Job Not Executing

Checks

* `crontab -l`
* `systemctl status crond`
* Script permissions
* Absolute paths
* Output redirected to log file

---

# 21. Frequently Asked Interview Questions

**Q. What shell scripts have you written?**

Answer

* Deployment automation
* AKS operational scripts
* Rollout verification
* Pod log collection
* Cluster health checks
* Disk monitoring
* Memory monitoring
* CPU monitoring
* Backup automation
* Log cleanup
* Service monitoring
* Jenkins helper scripts
* Cron-based maintenance scripts

---

**Q. How do shell scripts help in DevOps?**

Answer

They automate repetitive operational tasks, reduce manual effort, improve consistency, minimize human error, and are commonly integrated into Jenkins and Azure DevOps pipelines for deployments, monitoring, and infrastructure management.

---

# Final Shell Scripting Summary

You have now covered:

✅ Shell Basics

✅ Variables

✅ Environment Variables

✅ Special Variables

✅ Exit Codes

✅ Arithmetic, String & Logical Operators

✅ File Test Operators

✅ if, else, elif, nested if

✅ case Statement

✅ for, while, until Loops

✅ break & continue

✅ Functions

✅ Arrays

✅ (), {}, [], [[ ]], (()), $()

✅ Input/Output Redirection

✅ Pipes

✅ grep

✅ awk

✅ sed

✅ cut

✅ sort

✅ uniq

✅ xargs

✅ find

✅ tee

✅ `set -euo pipefail`

✅ Logging

✅ Enterprise Deployment Scripts

✅ Health Check Scripts

✅ Disk, CPU & Memory Monitoring

✅ Backup Scripts

✅ Log Cleanup Scripts

✅ Cron Jobs

✅ Debugging (`bash -x`, `set -x`)

✅ AKS Shell Scripts

✅ Azure CLI Automation

✅ Jenkins Integration

✅ Production Troubleshooting

✅ Real-Time Interview Scenarios

This completes the Shell Scripting interview preparation for a **4+ years DevOps Engineer**. The next topic, **Linux**, will build on these scripting concepts by covering Linux administration, processes, permissions, networking, storage, services, and production troubleshooting.
