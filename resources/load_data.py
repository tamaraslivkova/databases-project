import pandas as pd
import mysql.connector

# connection to MySQL database
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="01022006",
    database="shelter"   
)
cursor = db.cursor()

APPEND = False

if not APPEND:
    cursor.execute("DELETE FROM Shelter")
    cursor.execute("DELETE FROM Animals")
    cursor.execute("DELETE FROM Intake")

# LOAD SHELTERS FROM petfinder_shelters.csv
shelters_df = pd.read_csv('resources/petfinder_shelters.csv')

shelter_id_map = {} 

for _, row in shelters_df.iterrows():
    orig_id = str(row['id'])
    name = str(row['name'])
    
    # Combine address1 and state/city if available, or use address1
    address1 = str(row['address1']) if pd.notna(row['address1']) else None
    city = str(row['city']) if pd.notna(row['city']) else ''
    state = str(row['state']) if pd.notna(row['state']) else ''
    
    full_address = f"{address1}, {city}, {state}".strip(", ") if address1 else None
    if full_address == "":
        full_address = None

    sql = """
        INSERT INTO Shelter (name, address, current_capacity, max_capacity) 
        VALUES (%s, %s, NULL, NULL);
    """
    cursor.execute(sql, (name, full_address))
    db.commit()
    
    # Capture the generated auto_increment shelter_id
    new_shelter_id = cursor.lastrowid
    shelter_id_map[orig_id] = new_shelter_id


# Fetch a fallback shelter ID in case we need to map animal records
cursor.execute("SELECT MIN(shelter_id) FROM Shelter;")
fallback_shelter_id = cursor.fetchone()[0]


# LOAD ANIMALS & INTAKES FROM Austin_Animal_Center_Outcomes_20261001.csv
austin_df = pd.read_csv('resources/Austin_Animal_Center_Outcomes_20261001.csv')

# Drop duplicate Animal IDs to maintain primary key uniqueness in the Animals table
austin_unique_animals = austin_df.drop_duplicates(subset=['Animal ID']).copy()

animals_inserted = 0
intakes_inserted = 0

for _, row in austin_unique_animals.iterrows():
    animal_id = int(row['Animal ID'])
    
    # Handle name (map NaN to None / NULL)
    name = str(row['Name']) if pd.notna(row['Name']) else None
    if name == 'nan' or name == '':
        name = None
        
    species = str(row['Type']) if pd.notna(row['Type']) else 'Unknown'
    breed = str(row['Primary Breed']) if pd.notna(row['Primary Breed']) else 'Unknown'
    
    # Map sex values to ENUM('Male', 'Female', 'Unknown')
    sex_raw = str(row['Sex']) if pd.notna(row['Sex']) else 'Unknown'
    if 'Male' in sex_raw:
        sex = 'Male'
    elif 'Female' in sex_raw:
        sex = 'Female'
    else:
        sex = 'Unknown'
        
    # Assign to a shelter (distributing them across our loaded Petfinder shelters cyclically)
    assigned_shelter_id = list(shelter_id_map.values())[animals_inserted % len(shelter_id_map)] if shelter_id_map else fallback_shelter_id

    # Insert Animal Record
    animal_sql = """
        INSERT INTO Animals (animal_id, shelter_id, name, species, breed, sex) 
        VALUES (%s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE name=VALUES(name), breed=VALUES(breed);
    """
    cursor.execute(animal_sql, (animal_id, assigned_shelter_id, name, species, breed, sex))
    animals_inserted += 1

db.commit()


# Now insert every intake record corresponding to these animals
for _, row in austin_df.iterrows():
    animal_id = int(row['Animal ID'])
    
    # Parse intake date string into a standard date format (YYYY-MM-DD)
    intake_date_raw = str(row['Intake Date'])
    try:
        intake_date = pd.to_datetime(intake_date_raw).strftime('%Y-%m-%d')
    except Exception:
        intake_date = '2026-01-01' # Fallback date if parsing fails

    # Get the assigned shelter_id for this animal
    cursor.execute("SELECT shelter_id FROM Animals WHERE animal_id = %s;", (animal_id,))
    res = cursor.fetchone()
    animal_shelter_id = res[0] if res else fallback_shelter_id

    intake_sql = """
        INSERT INTO Intake (animal_id, shelter_id, intake_date) 
        VALUES (%s, %s, %s);
    """
    cursor.execute(intake_sql, (animal_id, animal_shelter_id, intake_date))
    intakes_inserted += 1

db.commit()
cursor.close()
db.close()