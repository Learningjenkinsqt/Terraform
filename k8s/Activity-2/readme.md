### Explain Kubernetes architecture
[Refer Here](https://safiakhatoon.hashnode.dev/kubernetes-architecture-and-components-kubernetes-installation-and-configuration) for the Kubernetes architecture

### Setup k8s on single node using minikube, kind and Run the Spring Pet Clinic

* Installing kubectl and minikube on Ubuntu
    * Install kubectl by using below commands
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version
```
![preview](./Images/k8s1.png)

* This downloads the latest stable release of kubectl for Linux amd64 architecture, installs it, and verifies the installation.

* Install minikube
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=docker
```
![preview](./Images/k8s2.png)

* This downloads the latest release of minikube for Linux amd64 architecture, installs it, and starts a single-node Kubernetes cluster using the Docker driver.

* Let's create a pod configuration file: vi spc.yml

* This opens a new file in the vi text editor.

* Paste the following YAML code into the file and save it

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: spring-petclinic
spec:
  containers:
    - name: spring-petclinic
      image: prakashreddy2525/spc
      ports:
        - containerPort: 8080
```
* This defines a Kubernetes pod called 'spring-petclinic' that runs a container using the prakashreddy2525/spc image and exposes port 8080.

* Let's create pod
```
kubectl create -f spc.yml
kubectl get pods
kubectl get pods -o wide
```
![preview](./Images/k8s3.png)

* This creates the 'spring-petclinic' pod using the configuration in the spc.yml file, lists the running pods, and shows additional details about the 'spring-petclinic' pod.

* Verify the pod is running
```
minikube ssh
curl http://<cluster-ip>:8080
```
![preview](./Images/k8s4.png)
![preview](./Images/k8s5.png)
![preview](./Images/k8s6.png)

* This logs into the minikube VM, where the Kubernetes cluster is running, and uses curl to access the spring-petclinic web server running in the 'spring-petclinic' pod via the cluster IP address.

* Delete the pod `kubectl delete pod spring-petclinic`

* This deletes the 'spring-petclinic' pod from the Kubernetes cluster.

### Setup k8s on single node using kind and Run the Spring Pet Clinic.

* Let's Install Kind, we need Docker, GO and Kubectl.

* Install docker using below steps,
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker ubuntu
```
* After successful installation re-login into your machine
* After re-login try to get docker info `$ docker info`

![preview](./Images/k8s7.png)

* Install GO
```
wget https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile
```
![preview](./Images/k8s8.png)

* Install kubectl by usind command `sudo snap install kubectl --classic`

* Install Kind
```
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.18.0/kind-$(uname)-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```
![preview](./Images/k8s9.png)

* Let's create the cluster in Kind
```
kind create cluster
kind get clusters && kubectl cluster-info --context kind-kind
```
![preview](./Images/k8s10.png)

* Let's create
```
kubectl apply -f spc.yaml
kubectl get po
kubectl get po -o wide
kubectl get po -w
```
![preview](./Images/k8s11.png)