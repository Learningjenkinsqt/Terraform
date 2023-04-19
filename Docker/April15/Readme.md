### create an alpine container in interactive mode and install python.

* Let's create an alpine container in interactive mode, 
    * Take a EC2 Machine
    * Install Docker by using below commands,

  `curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  sudo usermod -aG docker ubuntu`

* Let's install python
   `docker container run -it alpine:latest`

![preview](./Images/Docker1.png)

### create an ubuntu container with sleep 1d and then login using exec. Install python

* Let's create an ubuntu container with sleep 1d & then login using exec. Install python
    * Take a EC2 Machine
    * Install Docker
    * Run the below command

`docker container run -it --name ubuntu ubuntu: latest sleep 1d`

* After that exit into the machine and re login.
* And execute `docker container run exec –it ubuntu bin/bash`
* Now we are inside the container, run the below commands 
 `apt update && apt install python3 && Python3 –version`

![preview](./Images/Docker2.png)

* Finally we installed python

### create an postgres container with user panoramic and password as trekking. Try login in show the database.

* Let's create an postgres container with user panoramic and password as trekking.
    * Take a EC2 Machine
    * Install Docker
    * Run the below commands

`docker container run -d -P --name pasqldb -e POSTGRES_USER=panoramic -e POSTGRES_PASSWORD=trekking -e POSTGRES_DB=psqldata postgres`

`docker container ls`

`docker exec -it pasqldb /bin/bash`

![preview](./Images/Docker3.png)

`psql -U panoramic -W trekking -d psqldata`

![preview](./Images/Docker4.png)

`use employees;

CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

Insert into Persons Values (1,'Reddy','Prakash', 'Kurnool', 'AndhraPradesh');

select * from Persons;`
![preview](./Images/Docker5.png)