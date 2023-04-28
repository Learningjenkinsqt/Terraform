Kubernetes
-----------

* Kubernetes also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications. 

* K8s described as `Production grade container management` 

Kubernetes Architecture
------------------------
### Pod

* A group of one or more containers.The smallest unit of k8s.The container has no ip address Pod has an IP address.
* If the pod fails, then that pod will not be created again, another new pod will be created and its IP will be different.

### kubelet 

* Kublet is a small, lightweight Kubernetes node agent that runs on each node in a Kubernetes cluster.
* It's responsible for managing the nodes and communicating with the Kubernetes master. 
* It's also responsible for making sure that the containers running on the nodes are healthy and running correctly.
### Kube-proxy

* Kube-proxy is a network proxy service for Kubernetes that is responsible for routing traffic to different services within the cluster.
* It is responsible for forwarding traffic from one service to another, allowing for communication between different components of the Kubernetes cluster.
### Service

* In Kubernetes, a service is an object that abstracts the underlying infrastructure and provides a unified access point for the applications that are running on the cluster. 
* Services allow the applications to communicate with each other and are used to provide load balancing and service discovery.

### cluster

* In Kubernetes, a cluster is a set of nodes (physical or virtual machines) that are connected and managed by the Kubernetes software.

### Container Engine(Docker, Rocket, ContainerD)

* A container engine is a software system that enables applications and services to be packaged and run in an isolated environment.
* Docker, Rocket, and Container are all examples of container engines that are used to run applications in containers.

### API Server (Application Programeble Interface)

* The API Server is the entry point of K8S Services. 
* The Kubernetes API server receives the REST commands which are sent by the user. 
* After receiving them, it validates the REST requests, processes them, and then executes them. After the execution of REST commands, the resulting state of a cluster is saved in 'etcd' as a distributed key-value store. 
* This API server is meant to scale automatically as per load.

### ETCD

etcd is a `consistent and highly-available key value store` used as Kubernetes’ backing store for all cluster data. If your Kubernetes cluster uses etcd as its backing store, make sure you have a back up plan for those data. You can find in-depth information about etcd in the official documentation.

### Controller Manager

* The Kubernetes Controller Manager (also called kube-controller-manager) is a daemon that acts as a `continuous control loop` in a Kubernetes cluster. 
* The controller monitors the current state of the cluster via calls made to the API Server and changes the `current state to match the desired state` described in the cluster’s declarative configuration.

### Scheduler

* The scheduler in a master node schedules the tasks for the worker nodes. 
* And, for every worker node, it is used to store the resource usage information.

### What is kubectl stand for?

* Kubectl stands for `Kubernetes Command-line interface`. It is a command-line tool for the Kubernetes platform to perform API calls.
* Kubectl is the main interface that allows users to create (and manage) individual objects or groups of objects inside a Kubernetes cluster.

Kubernetes resources are defined by a `manifest` file written in `YAML`. When the manifest is deployed, an object is created `that aims to reach the desired state within the cluster`. From that point, the appropriate controller watches the object and `updates the cluster’s existing state to match the desired state`.

### Installing k8s cluster on ubuntu vms

* Create 3 ubuntu EC2 Instences which are accesible to each other with atlest 2 CPUS and 4 GB RAM
    * Install docker on all nodes by using below steps,
    ```
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker ubuntu
    ```
    * After successful installation re-login into your machine
    * After re-login try to get docker info `$ docker info`
    * Install CRI-Dockerd [Refer Here](https://github.com/Mirantis/cri-dockerd)
    * Run the below commands as root user in all the nodes
```
# Run these commands as root
###Install GO###
wget https://storage.googleapis.com/golang/getgo/installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile

git clone https://github.com/Mirantis/cri-dockerd.git
cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket
```
* Installing kubadm, kubectl, kubelet [Refer Here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)

* Run the below commands as root user in all the nodes

```
cd ~
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```
* Now create a cluster from a master node, use the command `kubeadm init --pod-network-cidr "10.244.0.0/16" --cri-socket "unix:///var/run/cri-dockerd.sock"`

* To start using your cluster, you need to run the following as a regular user (ubuntu user).
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
* Setup kubeconfig, install flannel use the command `kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml`
  
* Now you need to run the following command in nodes, it will shows on master node. 
```
kubeadm join 172.31.42.215:6443 --token sioopd.b6i7smx6ydof6ezn \
--cri-socket "unix:///var/run/cri-dockerd.sock" \
--discovery-token-ca-cert-hash sha256:3859371f0a4da46619c7775d93855ccf415b277c2ad8e73046ebc4c20f6ef5a5
```

* Now from manager execute `kubectl get nodes`

![preview](./Images/k8s1.png)

Exercises
----------
### Write a manifest file to create nginx.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: task1
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
```
![preview](./Images/k8s2.png)
### Write a manifest file to create nginx and alpine with sleep 1d.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: task2
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
    - name: alpine
      image: alpine
      args:
        - sleep
        - 1d
```
![preview](./Images/k8s3.png)
### Write a manifest file to create nginx, alpine with sleep 1d and alpine with 10s.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: exerc3
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
    - name: alpine1
      image: alpine
      args:
        - sleep
        - 1d
    - name: alpine2
      image: alpine
      args:
        - sleep
        - 10s
```
![preview](./Images/k8s4.png)
### Write a manifest file to create nginx and httpd with 80 port exposed.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: exerc4
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
    - name: httpd
      image: httpd
      ports:
        - containerPort: 80
```
![preview](./Images/k8s5.png)
