### Tell us about yourself?
* My Name is Prakash Reddy, I am having 3 Years of experience as a DevOps Engineer.
* For the last 3 years I have been working in accenture Company as a DevOps Engineer. 
* In that position, I have worked on various tools like Git,GitHub, build tools like Maven, 
   Sonarqube as a source code management tool, Jenkins is my CI server, Ansible, 
   Docker for Containerisation Deployment,K8 is the monitoring tool.

### Explain Docker Images
* A Docker image is a file used to execute code in a Docker container. 
* Docker images act as a set of instructions to build a Docker container, like a template. 
* Docker images also act as the starting point when using Docker. 
* An image is comparable to a snapshot in virtual machine (VM) environments.

### What are different ways of building docker images?
* Creating a Docker Image for your Application
    * Write a Dockerfile for your application.
    * Build the image with docker build command.
    * Host your Docker image on a registry.
    * Pull and run the image on the target machine.

### What is Dockerfile?
* A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. 
* This page describes the commands you can use in a Dockerfile.

### How is container different than VM?
* A container is a software code package containing an application's code, its libraries, and other dependencies. Containerization makes your applications portable so that the same code can run on any device. 
* A virtual machine is a digital copy of a physical machine.

### Can you tell something about namespaces and how they are used in Docker?
* Docker uses namespaces of various kinds to provide the isolation that containers need in order to remain portable and refrain from affecting the remainder of the host system.

* Docker uses a technology called namespaces to provide the isolated workspace called the container. 
* When you run a container, Docker creates a set of namespaces for that container. 
* These namespaces provide a layer of isolation.

### What is difference between ADD and COPY Instruction?
* The ADD directive can accept a remote URL for its source argument.
* The COPY directive on the other hand can only accept local files.

### Can you explain the concept of Layers in Docker Image
* Layers are what make up an image. 
* Each layer is a “diff” that contains the changes made to the image since the last one was added. 
* When building an image, the platform creates a new layer for each instruction in the file.

### What is the purpose of EXPOSE and VOLUME instruction in Dockerfile
* The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime.
* The VOLUME instruction is to provide a way to manage data in Docker containers and make it easier to deploy and run applications in a containerized environment.

### What is your workflow for CI/CD with Docker Containers and where do you store images?
* To implement CI/CD with Docker containers,
    * Write and test your code on a local machine or in a development environment.
    * Create a Docker image of your application.
    * Push the Docker image to a container registry such as Docker Hub, Amazon Elastic Container Registry (ECR), or Google Container Registry (GCR).
    * Set up a CI/CD pipeline that automatically builds and deploys your Docker containers when changes are made to the codebase.
    * Monitor the performance of your application in production and make necessary changes to improve it.