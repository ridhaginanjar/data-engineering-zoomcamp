docker run -it 
    -e POSTGRES_USER = "root" 
    -e POSTGRES_PASSWORD = "root" 
    -e POSTGRES_DB = "ny_taxi" 
    -v D:/Github/Zoomcamp/data-engineering-zoomcamp/week-1/docker-SQL/ny-taxi-postgres:/var/lib/postgresql/data 
    -p 5432:5432
    postgres:13

pip install pgcli
#if error because of psycopg or the error message showing " ... IMPORT ERROR: no pq wrapper available ... " then try install this
pip install psycopg_binary

#UPLOAD DATA WITH JUPYTER NOTEBOOK
pip install jupyter 
pip install pandas
pip install pyarrow #because i've to convert from PARQUET to pandas

pip install sqlalchemy #for create engine to connect with postgres

# The Route :
# CREATE DOCKER WITH POSTGRES -> USE PGCLI TO CONNECT LOCAL WITH POSTGRES -> IMPORT PARQUET DATA -> USE NOTEBOOK TO TRANSFORM AND UPLOAD DATA TO POSTGRES