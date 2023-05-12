### Create 1 master node and 2 worker nodes – run app on node1 and db on node2 by using
A. Node selector
B. Affinity
C. Taints and tolerances

* creating kubeadm cluster with 2 nodes
* added labels for nodes as node1 and node2

![preview](./Images/Task1.png)

* write manifest files for app to select `node1` and db to select `node2`

A. Node selector

* Nop-Deployment
```yaml
### NopCommerce Deployment File with NodeSelector
---
apiVersion: apps/v1
kind: Deployment
metadata: 
  name: nop-deploy
  labels:
    app: nopcommerce
spec: 
  minReadySeconds: 1
  replicas: 2
  selector: 
    matchLabels: 
      app: nopcommerce
  strategy:
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
    type: RollingUpdate  
  template:
    metadata:
      name: nop-pod
      labels:
        app: nopcommerce
    spec:
      nodeSelector:
        nodename: node1
      containers:
        - name: nopcommerce
          image: prakashreddy2525/nopcommerce
          ports:
            - containerPort: 5000
              protocol: TCP
          readinessProbe:
            httpGet:
              path: /
              port: 5000
          livenessProbe:
            tcpSocket:
              port: 5000
```

* mysql-Deployment

```yaml
### Mysql Deployment File with NodeSelector
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deploy
spec:
  minReadySeconds: 3
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
  template:
    metadata:
      name: mysql-pod
      labels:
        app: mysql
    spec:
      nodeSelector:
        nodename: node2
      containers:
        - name: mysql
          image: mysql:8
          ports:
            - containerPort: 3306
          envFrom:
            - configMapRef:
                name: mysql-configmap
                optional: false
### ConfigMap file
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-configmap
data:
  MYSQL_ROOT_PASSWORD: prakashreddy
  MYSQL_DATABASE: employees
  MYSQL_USER: prakashreddy
  MYSQL_PASSWORD: prakashreddy
```

![preview](./Images/Task2.png)

B. Affinity

* NopCommerce

```yaml
### NopCommerce Deployment File with Affinity
---
apiVersion: apps/v1
kind: Deployment
metadata: 
  name: nop-deploy
  labels:
    app: nopcommerce
spec: 
  minReadySeconds: 1
  replicas: 2
  selector: 
    matchLabels: 
      app: nopcommerce
  strategy:
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
    type: RollingUpdate  
  template:
    metadata:
      name: nop-pod
      labels:
        app: nopcommerce
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: nodename
                    operator: In
                    values: 
                      - node1
      containers:
        - name: nopcommerce
          image: prakashreddy2525/nopcommerce
          ports:
            - containerPort: 5000
              protocol: TCP
          readinessProbe:
            httpGet:
              path: /
              port: 5000
          livenessProbe:
            tcpSocket:
              port: 5000
```
* Mysql

```yaml
### Mysql Deployment File with Affinity
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deploy
spec:
  minReadySeconds: 3
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
  template:
    metadata:
      name: mysql-pod
      labels:
        app: mysql
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                  - key: nodename
                    operator: In
                    values: 
                      - node2
      containers:
        - name: mysql
          image: mysql:8
          ports:
            - containerPort: 3306
          envFrom:
            - configMapRef:
                name: mysql-configmap
                optional: false
```

![preview](./Images/Task3.png)

C. Taints and tolerences

  * We Should have to attach taints to nodes
  * kubectl taint nodes <node-name> <key=value:effect>
```
kubectl taint nodes ip-172-31-44-59 app=web:NoSchedule
kubectl taint nodes ip-172-31-44-149 app=db:NoSchedule
```
![preview](./Images/Task4.png)

* Lets create a manifest file by writing tolerences, Here taints are opposite to selectors.
* If tolerence of app=db matches - it will not schedule in this machine

* NopCommerce

```yaml
### NopCommerce Deployment File with Tolerances
---
apiVersion: apps/v1
kind: Deployment
metadata: 
  name: nop-deploy
  labels:
    app: nopcommerce
spec: 
  minReadySeconds: 1
  replicas: 1
  selector: 
    matchLabels: 
      app: nopcommerce
  strategy:
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
    type: RollingUpdate  
  template:
    metadata:
      name: nop-pod
      labels:
        app: nopcommerce
    spec:
      tolerations:
        - key: app
          operator: Equal
          value: db
          effect: NoSchedule
      containers:
        - name: nopcommerce
          image: prakashreddy2525/nopcommerce
          ports:
            - containerPort: 5000
              protocol: TCP
          readinessProbe:
            httpGet:
              path: /
              port: 5000
          livenessProbe:
            tcpSocket:
              port: 5000
```
* Mysql

```yaml
### Mysql Deployment File with Tolerances
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mysql-deploy
spec:
  minReadySeconds: 1
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 50%
      maxUnavailable: 50%
  template:
    metadata:
      name: mysql-pod
      labels:
        app: mysql
    spec:
      tolerations:
        - key: app
          operator: Equal
          value: nop
          effect: NoSchedule
      containers:
        - name: mysql
          image: mysql:8
          ports:
            - containerPort: 3306
          envFrom:
            - configMapRef:
                name: mysql-configmap
                optional: false
```

![preview](./Images/Task5.png)

* Create k8s cluster with version 1.25 and run any deployment(nginx/any) and then upgrade cluster to version 1.27.

