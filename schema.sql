--this is where the tables are created
--The blueprint of the database
--we need to check if the table is correct

CREATE TABLE Shelter (
    shelter_id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT NOT NULL,
    capacity INTEGER CHECK (capacity >= 0),
    current_capacity INTEGER NOT NULL DEFAULT 0 CHECK (current_capacity >= 0),
    max_capacity INTEGER NOT NULL CHECK (max_capacity >= current_capacity)
);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    role TEXT NOT NULL,
    shelter_id INTEGER NOT NULL,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
CREATE TABLE Animals (
    animal_id INTEGER PRIMARY KEY AUTOINCREMENT,
    age INTEGER CHECK (age >= 0),
    species TEXT NOT NULL,
    breed TEXT,
    sex TEXT CHECK (sex IN ('Male', 'Female', 'Unknown')),
    shelter_id INTEGER NOT NULL,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
CREATE TABLE Intake (
    intake_id INTEGER PRIMARY KEY AUTOINCREMENT,
    intake_type TEXT, --'Stray', 'Transfer'
    date TEXT NOT NULL DEFAULT (DATE('now')), --YYYY-MM-DD
    animal_id INTEGER NOT NULL,
    shelter_id INTEGER NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
