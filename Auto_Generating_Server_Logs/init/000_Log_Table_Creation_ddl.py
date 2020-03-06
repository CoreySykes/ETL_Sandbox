import csv
import pandas as pd
import pymysql
from sqlalchemy import create_engine
import pymysql.cursors

# Make Connection
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='',
                             db='etl_sandbox',
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)

# Create Database Statement
db_query = "CREATE DATABASE IF NOT EXISTS etl_sandbox"

# Create Table Statement
tbl_query = '''CREATE TABLE IF NOT EXISTS live_log_parsing(
    date VARCHAR(255),
    http_version DECIMAL(3,1),
    ip VARCHAR(255),
    method VARCHAR(255),
    referrer VARCHAR(255),
    request_path VARCHAR(1000),
    response_size INT(10),
    status_code INT(5),
    user_agent VARCHAR(255)
)
'''
try:
    with connection.cursor() as cursor:        
        # Execute the query
        cursor.execute(db_query)
        cursor.execute(tbl_query)
except:
    pass