--this is where the tables are created
--The blueprint of the database
--we need to check if the table is correct

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Intake;
DROP TABLE IF EXISTS Animals;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Shelter;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Shelter (
    shelter_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL,
    capacity INT CHECK (capacity >= 0),
    current_capacity INT NOT NULL DEFAULT 0 CHECK (current_capacity >= 0),
    max_capacity INT NOT NULL CHECK (max_capacity >= current_capacity)
) ENGINE=InnoDB;

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    role VARCHAR(100) NOT NULL,
    shelter_id INT NOT NULL,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT CHECK (age >= 0),
    species VARCHAR(100) NOT NULL,
    breed VARCHAR(100),
    sex ENUM('Male', 'Female', 'Unknown'),
    shelter_id INT NOT NULL,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Intake (
    intake_id INT AUTO_INCREMENT PRIMARY KEY,
    intake_type VARCHAR(100),
    date DATE NOT NULL DEFAULT (CURRENT_DATE),
    animal_id INT NOT NULL,
    shelter_id INT NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;