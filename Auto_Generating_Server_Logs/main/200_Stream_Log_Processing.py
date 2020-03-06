import os
import re
import csv
import pandas as pd
from sqlalchemy import create_engine
import json

# Regex for the parsing of the log by creating group classes
LOG_REGEX = '(?P<ip>[(\d\.)]+) - - \[(?P<date>.*?) -(.*?)\] "(?P<method>\w+) (?P<request_path>.*?) HTTP/(?P<http_version>.*?)" (?P<status_code>\d+) (?P<response_size>\d+) "(?P<referrer>.*?)" "(?P<user_agent>.*?)"'
compiled = re.compile(LOG_REGEX)
out = []

# Open Connection to DB
engine = create_engine('mysql+mysqlconnector://root@localhost/etl_sandbox')

# Keep the log open and for each line that comes through, let's do something
with open('output.log') as f:
    while True:
        line = f.readline()
        if line:
            # Generate the regex'd log into a dictionary
            match = compiled.match(line)
            data = match.groupdict()
            
            # Generate Query & Insert to Database
            df = pd.DataFrame([data])
            try:
                df.to_sql(
                "live_log_parsing",
                con=engine,
                if_exists="append",
                index=False
                )
            except:
                print("Failure in the pipe. Please check logs")

        