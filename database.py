#this file we are using for writing code for sql
#the logic behind the database, the engine

import os
import mysql.connector
from dotenv import load_dotenv

# Load variables from the local .env file
load_dotenv()

# Connect using environment variables with fallback defaults
conn = mysql.connector.connect(
    host=os.getenv("DB_HOST", "localhost"),
    user=os.getenv("DB_USER", "root"),
    password=os.getenv("DB_PASSWORD", ""),
    database=os.getenv("DB_NAME", "shelter_db")
)

cursor = conn.cursor()

