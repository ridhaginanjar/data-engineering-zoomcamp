#!/usr/bin/env python
# coding: utf-8
#Di atas adalah informasi interpreter dan encoding

import argparse
from matplotlib.pyplot import table
import psycopg2

import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine


def main(params) :
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name

    ny_taxi = pq.read_table("yellow_tripdata_2021-01.parquet")
    ny_taxi_data = ny_taxi.to_pandas()

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    #Push Table
    ny_taxi_data.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    #Push Table with Data
    ny_taxi_data.to_sql(name=table_name,con=engine, if_exists='replace',chunksize=1000000)


if __name__ == "__main__" :
    """
    Kondisi yang mengizinkan file akan dijalankan secara standalone (Shell: python ingets-data.py) dengan memasukan beberapa "syarat".
    Run in Shell : python ingest-data.py --user="root" --password="root" --host="localhost" --port=5432 --db="ny_taxi" --table_name="yellow_taxi_data" 
    """
    parser = argparse.ArgumentParser(description="Ingest Parquet data to Postgres (Docker)")
    
    parser.add_argument("--user", required=True, help="user name for postgres")
    parser.add_argument("--password", required=True, help="user password for postgres")
    parser.add_argument("--host", required=True, help="host for postgres")
    parser.add_argument("--port", required=True, help="port for postgres")
    parser.add_argument("--db", required=True, help="database name for postgres")
    parser.add_argument("--table_name", required=True, help="name the table where we will write the result to")

    args = parser.parse_args()

    main(args)