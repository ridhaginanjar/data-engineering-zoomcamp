# Introduction to Docker and SQL
In first week, we will get introduction to Docker and SQL

Install Docker : [DockerInstall](https://docs.docker.com/get-docker/)

# Step 1: Docker
Project File :
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

## [Dockerfile](Dockerfile)
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

## [pipeline.py](pipeline.py)
This file will contain the program. So, basically this file just will show text "your job is running successfully {day}"
> {day} is variable from system.
So, if you want to run DOCKER make sure you specify the date
```
docker run -it image:version 2023-02-01
```

# Step 2: SQL
After we already know about docker, now we will get introduce to SQL.

We use **PostgreSQL** as Database 

Project File :
- [ingest-ny-taxi-data-to-postgress.sh](ingest-ny-taxi-data-to-postgress.sh)
- [upload-data-to-postgres-image.ipynb](upload-data-to-postgres-image.ipynb)
- [ingest-data.py](ingest-data.py)
- [yellow_tripdata_2021-01.parquet](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page)
- [note.txt](note.txt)

## ingest-ny-taxi-data-to-postgress.sh
This is just for the explaination, see more detail in [project file](ingest-ny-taxi-data-to-postgress.sh)

1. Create docker :
```
docker run --it 
```
To **create and run** docker.
> -e: environment such as Username, Password, DB Name. etc

> -v: volume disk, localpath:/var/lib/postgresql/data
> (/var/.. is volume path in docker)

> -p: port, hostPort:containerPort.
> port is used for expose and publish container ports to allow
> communication between the container and the host (local computer)

> postgres:13
> We running the image and container using image from postgres version 13

2. pgcli :
After we create DB we have to communicate with the Database from the host right ? Before we know about pgadmin, we can use pgcli (Postgre Command Line) that allow us to communicate between postgre docker container with our host (local computer)

```
pip install pgcli
pip install psycopg_binary
```

> psycopg_binary is the dependencies if we have some trouble when installing.

## Jupyter Notebook :
```
pip install jupyter
```
In the code above, we will install jupyter in our project. 

We can execute the databse and doing progamming through jupyter notebook. See more detail on the file project.

The library that i used :
- pandas
- pyarrow
- sqlalchemy

> pyarrow is for parquet data, so I can use to transform to pandas

> sqlalchemy is for connect to DB

## ingest-data.py :
Another method that we use if we don't want to use jupyter notebook, we can use python file.

Here's something I just found out from this file :
```
import argparse
```

Using argparse, user have to input "some argument" to execute file.
In this case is username, password, host, port, db, table_name

```
if __name__ == "__main__" :
```

In Python, The code above is a conditional statement that is used to check whether a module is being run as the main program or being imported as a module into another program.

When Python runs a module, it sets the special variable __name__ to the name of the module. If a module is being run as the main program, its __name__ is set to the string "__main__". If a module is being imported as a module into another program, its __name__ is set to the name of the module.

So, it's means that if we run the file:
```
python ingest-data.py
```
It will trigger the name "ingest-data" as main program, and the function that we used in the file will automatically executed. It's because in "if statement" we write this code

```
main(args)
```

## yellow_tripdata_2021-01.parquet :
We use data from January 2021.

# Step 3: Intro to PGAdmin and Network
In this step we will cover this topic :
Create docker network -> PGAdmin using Docker -> Connect existing container to the network ->
Rename existing container

Lastly, I also learn about delete all unused resources.

Project File :
- [pgadmin-network.sh](pgadmin-network.sh)
- [images](images)

## Network
Docker network is a way for Docker containers to communicate with each other over a virtual network.

When you create a Docker container, it is isolated from the host machine and other containers by default. However, you can create a Docker network to connect multiple containers and allow them to communicate with each other over a virtual network.

When you create a Docker network, Docker creates a virtual network interface on the host machine and assigns an IP address range to the network.

There are several types of Docker networks available, such as bridge networks, overlay networks, and MACVLAN networks. Each type of network has its own set of characteristics and use cases. BUT in this case, we will bridge network.

```
docker network create <NetworkName>
```
The code above is used for create network

```
docker network connect <NetworkName> <ContainerName>
```
The code above is used for connect container with the network

```
docker run -it --network="Network Name" --name ContainerName images:version
```

OR you can initiate network name when you want to create images/container

## Docker PGAdmin
In this step, we will use PGAdmin using Docker Images. Here is default command how to create and run image/container

```
docker run -it -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
-e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 --network=pg-network \
--name pg-admin dpage/pgadmin4
```

> --network: ,Input your exisiting "bridge" network here

> --name ,Set your container name here

> dpage/pgadmin4, pgadmin images

After you create and run PGAdmin Container, you can access PGAdmin through :

```
localhost:8080
```

Here is the step to connect to your PostgreSQL using PGAdmin

1. Login
![Login](images/Localhost%20-%20Docker%20PGAdmin.PNG)

Login using PGADMIN_DEFAULT_EMAIL and your PGADMIN_DEFAULT_PASSWORD

2. Create Server
![Create Server](images/PGadmin%20Dashboard.PNG)
Click: Register -> Server

3. Input your DB Environment
![General](images/General%20-%20Register%20Server.PNG)
Fill form: Input your Server Name

![Connection](images/Connection%20-%20Register%20Server.PNG)
Fill form : Hostname -> name of your postgre container, username -> fill with your db postgresql username (-e username), password -> fill with your db postgresql password (-e password).

Click : Save


## Docker Prune
Docker prune is a command that allows you to remove unused Docker resources from your system.

```
docker <resources> prune
```
> Resources: volume, images, container, network, system

```
docker system prune
```
The code above is to delete all unused resources automatically.
By default, It will included images, container, network.

> -a --volumes, is used for delete all resources include volumes, etc.

