### Create a multi-stage docker file to build
   * nop commerce  
   * spring petclinic
   * student courses register
### Let's create a multi-stage docker file to build nop commerce

* Take an a EC2 Machine and Install Docker by using below commands,
  ```
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  sudo usermod -aG docker ubuntu
  ```
* After successful installation re-login into your machine
* After re-login try to get docker info
```
$ docker -—version
$ docker info
``` 

* create a dockerfile in `vi Dockerfile`

```Dockerfile
### Multi stage Docker file for NopCommerce
FROM ubuntu:22.04 As builder
RUN apt update && apt install unzip -y
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.40.2/nopCommerce_4.40.2_NoSource_linux_x64.zip /nop/nopCommerce_4.40.2_NoSource_linux_x64.zip
RUN cd nop && unzip nopCommerce_4.40.2_NoSource_linux_x64.zip && rm nopCommerce_4.40.2_NoSource_linux_x64.zip

FROM mcr.microsoft.com/dotnet/sdk:7.0
LABEL author="Prakash Reddy" organization="qt" project="learning"
ARG HOME_DIR=/nop-bin
WORKDIR ${HOME_DIR}
COPY --from=builder /nop ${HOME_DIR}
EXPOSE 5000
CMD [ "dotnet", "Nop.Web.dll", "--urls", "http://0.0.0.0:5000" ]
```
![preview](./Images/multi1.png)

* To build the docker image by using command `docker image build -t (imagename) nop .`

* To check the docker image creation by using command `docker image ls`

* To run the docker container by using command `docker container run --name nop -d -p 32000:5000 nop `

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi2.png)

* To check the nopcommerce web page use the `http://<publicip>:5000` and We will get the nopCommerce Page.

![preview](./Images/multi3.png)

### Push these images to Amazon Elastic Container Registry

* Create AWS Configuration, to do this install AWS CLI `sudo apt install awscli`

![preview](./Images/multi4.png)

`aws configure`

* For aws configuration use your 
     * AWS Access Key ID
     * AWS Secret Access Key 
     * Default region name.
  
![preview](./Images/multi5.png)

* Create Amazon Elastic Container Registry.
     * In that you can use Public Repository are else Private Repository

![preview](./Images/multi6.png)
![preview](./Images/multi7.png)
![preview](./Images/multi8.png)
![preview](./Images/multi9.png)

* In that Elastic Container Registry you can Use view Push Commands

```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 221228654437.dkr.ecr.ap-south-1.amazonaws.com
```
![preview](./Images/multi10.png)

```
docker build -t nopcommerse .
docker tag nopcommerse:latest 221228654437.dkr.ecr.ap-south-1.amazonaws.com/nopcommerse:latest
docker push 221228654437.dkr.ecr.ap-south-1.amazonaws.com/nopcommerse:latest
```
![preview](./Images/multi11.png)
![preview](./Images/multi12.png)

* Finally you will create an a Image in Elastic Container Registry.

![preview](./Images/multi13.png)

### Write a docker compose file for Nop Commerce.

```yaml
---
version: "3.9"
services:
  nop:
    build:
      context: .
      dockerfile: Dockerfile
    networks:
      - nop-net
    ports:
      - "32000:5000"
    depends_on:
      - nop-db
      
  nop-db:
    image: mysql:8
    networks:
      - nop-net
    volumes:
      - nop-db:/var/lib/mysql
    environment:
      - MYSQL_ROOT_PASSWORD=prakashprakash
      - MYSQL_USER=nop
      - MYSQL_PASSWORD=prakashprakash
      - MYSQL_DATABASE=nop
volumes:
  nop-db:
networks:
  nop-net:
```
* To run the docker compose command is `docker compose up -d`

![preview](./Images/multi14.png)

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi15.png)

* To check the nopcommerce web page use the `http://<publicip>:32000` (what even you given the opposite port of 32000:5000)

![preview](./Images/multi16.png)

### Let's create a multi-stage docker file to build spring petclinic

* Take an a EC2 Machine and Install Docker by using below commands,

  ```
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  sudo usermod -aG docker ubuntu
  ```
* After successful installation re-login into your machine
* After re-login try to get docker info

```
$ docker -—version
$ docker info
```

```Dockerfile
### Multi stage Docker file for Spring-petclinic
FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/spring-projects/spring-petclinic.git && \
    pwd && ls /spring-petclinic

FROM maven:3-amazoncorretto-17 AS builder
COPY --from=vcs /spring-petclinic /spring-petclinic
RUN ls /spring-petclinic 
RUN cd /spring-petclinic && mvn package

FROM amazoncorretto:17-alpine-jdk
LABEL author="Prakash Reddy" organization="qt" project="learning"
EXPOSE 8080
ARG HOME_DIR=/spc
WORKDIR ${HOME_DIR}
COPY --from=builder /spring-petclinic/target/spring-*.jar ${HOME_DIR}/spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-jar", "spring-petclinic.jar"]
```
* create a dockerfile in `vi Dockerfile`

* To build the docker image by using command `docker image build -t spc .`

![preview](./Images/multi17.png)

* To check the docker image creation by using command `docker image ls`

* To run the docker container by using command `docker container run --name spc -d -p 32000:8080 spc `

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi18.png)

* To check the springpetclinic web page use the `http://<publicip>:32000` (what even you given the opposite port of 32000:8080)

![preview](./Images/multi19.png)

### Push these images to Amazon Elastic Container Registry

* Create AWS Configuration, to do this install AWS CLI `sudo apt install awscli`

* `aws configure`

* For aws configuration use your 
     * AWS Access Key ID
     * AWS Secret Access Key 
     * Default region name.

* Create Amazon Elastic Container Registry.
     * In that you can use Public Repository are else Private Repository

![preview](./Images/multi20.png)
![preview](./Images/multi21.png)
![preview](./Images/multi22.png)
![preview](./Images/multi23.png)

* In that Elastic Container Registry you can Use view Push Commands

```
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 221228654437.dkr.ecr.ap-south-1.amazonaws.com

docker build -t springpetclinic .

docker tag springpetclinic:latest 221228654437.dkr.ecr.ap-south-1.amazonaws.com/springpetclinic:latest

docker push 221228654437.dkr.ecr.ap-south-1.amazonaws.com/springpetclinic:latest
```

![preview](./Images/multi24.png)

* Finally you will create an a Image in Elastic Container Registry.

![preview](./Images/multi25.png)

### Write a docker compose file for Springpetclinic.

```yaml
---
version: "3.9"
services:
  spc:
    build:
      context: .
      dockerfile: Dockerfile
    networks:
      - spc-net
    ports:
      - "32000:8080"
    depends_on:
      - spc-db

  spc-db:
    image: mysql:8
    networks:
      - spc-net
    volumes:
      - spc-db:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: prakashreddy
      MYSQL_DATABASE: spc
      MYSQL_USER: spc
      MYSQL_PASSWORD: prakashreddy
volumes:
  spc-db:
networks:
  spc-net:
```
* Create a Dockerfile for Springpetclic application and insert that into `vi Dockerfile`

* And then write a docker-compose `YAML` file for Springpetclic application and insert that into `vi Docker-compose.yaml`

* To run the docker compose command is `docker compose up -d`

![preview](./Images/multi26.png)

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi27.png)

* To check the springpetclinic web page use the `http://<publicip>:32000` (what even you given the opposite port of 32000:8080)

![preview](./Images/multi28.png)

### Let's create a multi-stage docker file to build student courses register

* Take an a EC2 Machine and Install Docker by using below commands,

  ```
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  sudo usermod -aG docker ubuntu
  ```
* After successful installation re-login into your machine
* After re-login try to get docker info

```
$ docker -—version
$ docker info
```

```Dockerfile
### Multi stage Docker file for StudentCoursesRestAPI
FROM alpine/git AS vcs
RUN cd / && git clone https://github.com/DevProjectsForDevOps/StudentCoursesRestAPI.git && \
    pwd && ls /StudentCoursesRestAPI

FROM python:3.8.3-alpine As Builder
LABEL author="Prakash Reddy" organization="qt" project="learning"
COPY --from=vcs /StudentCoursesRestAPI /StudentCoursesRestAPI
ARG DIRECTORY=StudentCourses
RUN cd / StudentCoursesRestAPI cp requirements.txt /StudentCourses
ADD . ${DIRECTORY}
EXPOSE 8080
WORKDIR StudentCoursesRestAPI
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "app.py"]
```
* create a dockerfile in `vi Dockerfile`

* To build the docker image by using command `docker image build -t StudentCoursesRestAPI .`

![preview](./Images/multi29.png)

* To check the docker image creation by using command `docker image ls`

* To run the docker container by using command `docker container run --name StudentCoursesRestAPI -d -p 32000:8080 StudentCoursesRestAPI:1.0 `

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi30.png)

* To check the StudentCoursesRestAPI web page use the `http://<publicip>:30000` (what even you given the opposite port of 30000:8080)

![preview](./Images/multi31.png)

### Push these images to Amazon Elastic Container Registry

* Create AWS Configuration, to do this install AWS CLI `sudo apt install awscli`

* `aws configure`

* For aws configuration use your 
     * AWS Access Key ID
     * AWS Secret Access Key 
     * Default region name.

* Create Amazon Elastic Container Registry.
     * In that you can use Public Repository are else Private Repository
  
![preview](./Images/multi35.png)

![preview](./Images/multi36.png)

* In that Elastic Container Registry you can Use view Push Commands.
```
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/n0j7b7l2
docker build -t studentcourcereastapi .
docker tag studentcourcereastapi:latest public.ecr.aws/n0j7b7l2/studentcourcereastapi:latest
docker push public.ecr.aws/n0j7b7l2/studentcourcereastapi:latest
```

![preview](./Images/multi37.png)

![preview](./Images/multi38.png)

![preview](./Images/multi39.png)

![preview](./Images/multi40.png)

![preview](./Images/multi42.png)

* Finally you will create an a Image in Elastic Container Registry.

![preview](./Images/multi41.png)

### Write a docker compose file for StudentCoursesRestAPI.

```yaml
---
version: "3.9"
services:
  pip:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "30000:8080"
```

* Create a Dockerfile for StudentCoursesRestAPI application and insert that into `vi Dockerfile`

* And then write a docker-compose `YAML` file for StudentCoursesRestAPI application and insert that into `vi Docker-compose.yaml`

* To run the docker compose command is `docker compose up -d`

![preview](./Images/multi32.png)

* To check the docker container creation by using command `docker container ls`

![preview](./Images/multi33.png)

* To check the StudentCoursesRestAPI web page use the `http://<publicip>:30000` (what even you given the opposite port of 30000:8080)

![preview](./Images/multi34.png)

