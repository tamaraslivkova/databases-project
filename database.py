#this file we are using for writing code for sql
#the logic behind the database, the engine

import os
import mysql.connector
from dotenv import load_dotenv

# Load variables from the local .env file
load_dotenv()

def get_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", ""),
        database=os.getenv("DB_NAME", "shelter_db")
    )

def add_shelter(name, address, max_capacity, current_capacity=0):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO Shelter (name, address, current_capacity, max_capacity) VALUES (%s, %s, %s, %s)",
        (name, address, current_capacity, max_capacity)
    )
    conn.commit()
    new_id = cur.lastrowid
    cur.close()
    conn.close()
    return new_id

def get_shelter(shelter_id):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute("SELECT * FROM Shelter WHERE shelter_id = %s", (shelter_id,))
    result = cur.fetchone()
    cur.close()
    conn.close()
    return result



