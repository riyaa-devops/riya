FROM eclipse-temurin:17-jdk-jammy
WORKDIR /javaprg
COPY Main.java .
RUN javac Main.java
CMD ["java", "Main.java"]




## Step 14 — Start Minikube
```bash
minikube start
```
## Step 15 — Point Docker to Minikube's environment
```bash
eval $(minikube docker-env)
```
## Step 16 — Build the Docker image
```bash
docker build -t java-maven-app:latest .
```
## Step 17 — Create the deployment
```bash
kubectl create deployment java-maven-deployment --image=java-maven-app:latest --
replicas=3
```
## Step 18 — Expose the deployment
```bash
kubectl expose deployment java-maven-deployment --type=NodePort --port=5000
```
## Step 19 — Check pods
```bash
kubectl get pods
```
**If pods show `Completed` or `Running`** → skip to Step 21

**If pods show `ImagePullBackOff`** → run this one-line fix:
```bash
kubectl patch deployment java-maven-deployment -p '{"spec":{"template":{"spec":
{"containers":[{"name":"java-maven-app","imagePullPolicy":"IfNotPresent"}]}}}}'
```
Then:
```bash
kubectl rollout restart deployment java-maven-deployment
kubectl get pods
```
## Step 20 — Clean up any leftover broken pods (if needed)
```bash
kubectl delete pod <pod-name-with-error>
```
## Step 21 — Check logs (proof of execution)
```bash
kubectl logs <pod-name>
```
Expected output:
```
Hello from Maven CI/CD Pipeline
```
## Step 22 — Full overview for demonstration
```bash
kubectl get deployments
kubectl get pods
kubectl get services

Memorize Step 19's patch command as your backup — type it confidently if needed,
it's a normal kubectl operation. Good luck in the exam!



--------------
Here is the correct Kubernetes deployment sequence. The main correction is that kubectl

create deployment does not support the - replicas=3 flag.

STEP 14-START MINIKUBE

minikube start

STEP 15- USE MINIKUBE'S DOCKER DAEMON

eval $(minikube docker-env)

STEP 16

- BUILD THE DOCKER IMAGE

docker build -t java-maven-app: latest.

STEP 17 - CREATE THE DEPLOYMENT

kubectl create deployment java-maven-deployment --image=java-maven- app:latest

STEP 18- SCALE THE DEPLOYMENT TO 3 REPLICAS

kubectl scale deployment java-maven-deployment --replicas=3

STEP 19- EXPOSE THE DEPLOYMENT

kubectl expose deployment java-maven-deployment --type=NodePort -- port=5000

STEP 20- CHECK THE DEPLOYMENT, PODS, AND SERVICE

kubectl get deployments

kubectl get pods

kubectl get services

IF PODS SHOW IMAGEPULLBACKOFF

Run:

kubectl patch deployment java-maven-deployment -p '{"spec": {"template": {"spec":{"containers": [{"name": "java-maven- app", "imagePullPolicy": "IfNotPresent"}]}}}}

Then restart the deployment:

kubectl rollout restart deployment java-maven-deployment

Check the pods again:
kubectl get pods

STEP 21 - CHECK THE APPLICATION LOGS First, get the pod name:

kubectl get pods

Then:

kubectl logs <pod-name>

Expected output:

Hello from Maven CI/CD Pipeline

STEP 22-ACCESS THE APPLICATION (OPTIONAL)

STEP 23

minikube service java-maven-deployment

-FINAL VERIFICATION

kubectl get deployments

kubectl get pods

kubectl get services

For your CIE/lab exam, these corrected steps are the ones you should use. The only mistake in your original sequence was using - replicas=3 with kubectl create deployment; the replica count must be set separately using kubectl scale or by applying a YAML manifest.
