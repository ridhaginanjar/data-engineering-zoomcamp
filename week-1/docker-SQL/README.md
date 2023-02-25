# Introduction to Docker and SQL
In first week, we will get introduction to Docker and SQL
Install Docker : [DockerInstall](https://docs.docker.com/get-docker/)

# Step 1 : Docker
- Project File :
    - [Dockerfile](Dockerfile)
    - [pipeline.py](pipeline.py)
> Docker allows you to put everything an application needs inside a container
> sort of a box that contains everything: OS, system-level libraries, python, etc

> An image = set of instructions that were executed + state. All saved in “image”

Why should data engineers care about containerization and docker ?
- Setting up things locally for experiments
- Integrations tests, CI/CD
- Batch Jobs (AWS batch, Kubernets jobs, etc)
- Spark
- Serverless (AWS lambda)
- Containers everywhere

- [Dockerfile](Dockerfile)
    First, we want make a simple pipeline in python
    ```
    FROM python:3.9
    ```
    Using this syntax, we will build pipeline based on image python version: 3.9 in container registry

    ```
    RUN pip install pandas
    ```
    After getting image, the container will RUN this pip to install pandas

    ```
    WORKDIR /app
    COPY pipeline.py pipeline.py
    ```
    After all set, we will set our work directory in /app and copy pipeline.py in local to docker container as pipeline.py

    ```
    ENTRYPOINT [ "python", "pipeline.py" ]
    ```
    We will automatically running "python pipeline.py" when we run the container/image.
    > Normally, after we create (run) docker we will jump to "bash".
    > So, we should to run "python pipeline.py" manually 
- [pipeline.py](pipeline.py)
    This file will contain the program. So, basically this file just will show text "your job is running successfully {day}"
    > {day} is variable from system.
    So, if you want to run DOCKER make sure you specify the date
    ```
    docker run -it image:version 2023-02-01
    ```