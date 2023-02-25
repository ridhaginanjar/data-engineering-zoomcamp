#docker run will create (image) and run (a container) 
docker run -it 
    -e POSTGRES_USER="root" 
    -e POSTGRES_PASSWORD="root" 
    -e POSTGRES_DB="ny_taxi" 
    -v D:/Learning/DEZoomcamp/git/data-engineering-zoomcamp/week-1/docker-SQL/ny-taxi-data:/var/lib/postgresql/data #It Will create volume in D://.../../ny-taxi
    -p 5432:5432
    postgres:13
#USE CMD
docker run -it  -e POSTGRES_USER="root"  -e POSTGRES_PASSWORD="root"  -e POSTGRES_DB="ny_taxi"  -v D:/Learning/DEZoomcamp/git/data-engineering-zoomcamp/week-1/docker-SQL/ny-taxi-data:/var/lib/postgresql/data  -p 5432:5432 postgres:13

pip install pgcli
#if error because of psycopg or the error message showing " ... IMPORT ERROR: no pq wrapper available ... " then try install this
pip install psycopg_binary

#After install PGCLI, connect your local (in production you're the client) to postgre
pgcli -h localhost -p 5432 -u root -d ny_taxi
#h: host, p: port, u: user, d:data -> after enter this command, u have to enter password

#UPLOAD DATA WITH JUPYTER NOTEBOOK
pip install pandas
pip install jupyter
pip install pyarrow #because i've to convert from PARQUET to pandas

pip install sqlalchemy #for create engine to connect with postgres

# The Route :
# CREATE DOCKER WITH POSTGRES -> USE PGCLI TO CONNECT LOCAL WITH POSTGRES -> IMPORT PARQUET DATA -> USE NOTEBOOK TO TRANSFORM AND UPLOAD DATA TO POSTGRES (Or Use Python ingest-data.py)