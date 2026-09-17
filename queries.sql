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
