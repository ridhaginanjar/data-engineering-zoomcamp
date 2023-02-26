# Network
docker network create pg-network

# Pgadmin container
docker run -it -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
-e PGADMIN_DEFAULT_PASSWORD="root" -p 8080:80 --network=pg-network \
--name pg-admin dpage/pgadmin4

# Connect existing container with network
docker network connect <NetworkName> <ContainerName>

# Rename existing container for making easy to connect between pgadmin and database
docker rename <oldNameContainer> <newContainerName>

#postgres
docker run -it  -e POSTGRES_USER="root"  -e POSTGRES_PASSWORD="root" -e POSTGRES_DB="ny_taxi"  \
-v D:/Learning/DEZoomcamp/git/data-engineering-zoomcamp/week-1/docker-SQL/ny-taxi-data:/var/lib/postgresql/data \  
-p 5432:5432 --network="pg-network" --name pg-database postgres:13

# Docker info
docker system df

# Delete all unused resources
docker system prune -a --volumes # Delete all unused include volumes
docker system prune #Exclude volumes
docker <resources> prune