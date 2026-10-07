SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Intake;
DROP TABLE IF EXISTS Animals;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Shelter;

SET FOREIGN_KEY_CHECKS = 1;

-- updates for real-world data: a lot of NOT NULL contraints were deleted in this schema, because not everything is
-- populated because not everything is in the csv files
-- name length for the shelters had to be increased from 100 to 150 characters
-- staff table is not populated because there aren't any open source data available

CREATE TABLE Shelter (
    shelter_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    current_capacity INT DEFAULT 0 CHECK (current_capacity >= 0),
    max_capacity INT,
    CHECK (max_capacity >= current_capacity)
);

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    shelter_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(100) NOT NULL,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
); 


CREATE TABLE Animals (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    shelter_id INT,
    name VARCHAR(50),
    age INT CHECK (age >= 0),
    species VARCHAR(100) NOT NULL,
    breed VARCHAR(100),
    sex ENUM('Male', 'Female', 'Unknown'),
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Intake (
    intake_id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    shelter_id INT,
    intake_date DATE NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES Animals(animal_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (shelter_id) REFERENCES Shelter(shelter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);