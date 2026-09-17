-- basic queries
-- adding data
INSERT INTO Animals (shelter_id, name, age, species, breed, sex)
VALUES (1,'Max',2,'dog','border collie','male');

-- viewing data
SELECT * FROM Animals WHERE shelter_id = 1;

-- updating data
UPDATE Animals
SET age = 3
WHERE name = 'Max';

-- removing data
DELETE FROM Animals
WHERE name = 'Max';

-- advanced queries
-- finding the workload (number of staff and animals) per shelter
SELECT 
    Shelter.name,
    COUNT(DISTINCT Staff.staff_id) AS total_staff,
    COUNT(DISTINCT Animals.animal_id) AS total_animals
FROM Shelter
LEFT JOIN Staff ON Shelter.shelter_id = Staff.shelter_id
LEFT JOIN Animals ON Shelter.shelter_id = Animals.shelter_id
GROUP BY Shelter.name;

-- finding recent animal intakes and with their shelters
SELECT
    Animals.name AS animal_name,
    Animals.species,
    Shelter.name AS shelter_name,
    Intake.intake_date
FROM Animals
JOIN Shelter ON Animals.shelter_id = Shelter.shelter_id
JOIN Intake ON Animals.animal_id = Intake.animal_id
ORDER BY Intake.intake_date DESC;