#!/usr/bin/env python
# coding: utf-8
import os
import argparse

import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine

def main(params) :
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    table_name = params.table_name
    db = params.db
    url = params.url

    if url.endwith("csv.gz"):
        csv_name = "yellow_tripdata_2021_Jan.csv.gz"
    else :
        csv_name = "yellow_tripdata_2021_Jan.csv"
        
    os.system(f"wget {url} -O {csv_name}")
    ny_taxi_df = pd.read_csv(csv_name, iterator=True)

    engine = create_engine(f"postgresql://{user}:{password}@{host}:{port}/{db}")

    print(pd.io.sql.get_schema(ny_taxi_df, name='ny_taxi', con=engine))

    #Just post table without data
    ny_taxi_df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    #Push with data
    ny_taxi_df.to_sql(name=table_name, con=engine, if_exists='replace',chunksize=1000000)
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV to postgres')

    parser.add_argument('--user', required=True, help='user name for postgres')
    parser.add_argument('--password', required=True, help='password for postgres')
    parser.add_argument('--host', required=True, help='host for postgres')
    parser.add_argument('--port', required=True, help='port for postgres')
    parser.add_argument('--db', required=True, help='database name for postgres')
    parser.add_argument('--table_name', required=True, help='name of the table where we will write the results to')
    parser.add_argument('--url', required=True, help='url of the csv file')

    args = parser.parse_args()

    main(args)