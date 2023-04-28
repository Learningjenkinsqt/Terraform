### Write a Pod Spec for Spring PetClinic Application.

* Let Installing k8s cluster on ubuntu vms

* Create 3 ubuntu EC2 Instences which are accesible to each other with atlest 2 CPUS and 4 GB RAM
    * Install docker on all nodes and Install k8s cluster on ubuntu vms

* Let's write a `YAML` file for Spring PetClinic Application.

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
### Write a Pod Spec for nopCommerce Application.

* Let's write a `YAML` file for nopCommerce Application.

```yaml
---
apiVersion: v1
kind: Pod
metadata:
  name: nopcommerce-pod
spec:
  containers:
    - name: nopcommerce
      image: prakashreddy2525/nopcommerce
      ports:
        - containerPort: 5000
```

### Execute the kubectl commands kubectl get pods and describe pods

```
kubectl apply -f nop.yaml
kubectl apply -f spc.yaml
kubectl get po -o wide
kubectl get po -w
kubectl describe pod nopcommerce-pod
kubectl describe pod spring-petclinic
```

![preview](./Images/image1.png)

![preview](./Images/image2.png)

![preview](./Images/image3.png)

![preview](./Images/image4.png)

![preview](./Images/image5.png)
