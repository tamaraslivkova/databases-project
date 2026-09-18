#this file we are using for writing code for sql
#the logic behind the database, the engine

import os
import mysql.connector
from dotenv import load_dotenv

load_dotenv()

def get_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST", "localhost"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", ""),
        database=os.getenv("DB_NAME", "shelter_db")
    )

def add_shelter(name, address, current_capacity, max_capacity,):
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

def update_shelter_details(shelter_id, name, address, max_capacity, current_capacity):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        """
        UPDATE Animals 
        SET name = %s, address = %s, max_capacity = %s, current_capacity = %s
        WHERE animal_id = %s
        """,
        (shelter_id, name, address, max_capacity, current_capacity)
    )
    conn.commit()
    cur.close()
    conn.close()

def remove_shelter(shelter_id):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("DELETE FROM Shelter WHERE shelter_id = %s", (shelter_id,))
    conn.commit()
    deleted_rows = cur.rowcount
    cur.close()
    conn.close()
    return deleted_rows

def add_animal(shelter_id, name, age, species, breed, sex):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "INSERT INTO Animals (shelter_id, name, age, species, breed, sex) VALUES (%s, %s, %s, %s, %s, %s)",
        (shelter_id, name, age, species, breed, sex)
    )
    conn.commit()
    new_id = cur.lastrowid
    cur.close()
    conn.close()
    return new_id

def get_animal(animal_id):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)
    cur.execute(
        "SELECT * FROM Animals WHERE animal_id = %s", (animal_id,)
    )
    result = cur.fetchone()
    cur.close()
    conn.close()
    return result

def update_animal_details(animal_id, name, age, breed):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        """
        UPDATE Animals 
        SET name = %s, age = %s, breed = %s 
        WHERE animal_id = %s
        """,
        (name, age, breed, animal_id)
    )
    conn.commit()
    cur.close()
    conn.close()


def remove_animal (animal_id):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute(
        "DELETE  FROM Animals WHERE animal_id = %s", (animal_id,)
    )
    conn.commit()
    deleted_rows = cur.rowcount
    cur.close()
    conn.close()
    return deleted_rows

## testing the adding shelter function

new_shelter_id = add_shelter(
    name="Paws & Claws Haven",
    address="River Road 45, Amsterdam",
    max_capacity=150,
    current_capacity=0,
)

print(f"Shelter added successfully with ID: {new_shelter_id}")

## testing the adding animal function
new_animal_id = add_animal(
    shelter_id=1,
    name="Adam",
    age=2,
    species="dog",
    breed="labradoodle",
    sex="Male",
)

print(f"Animal added successfully with ID: {new_animal_id}")


