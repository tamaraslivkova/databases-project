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

-- author: Alysha-sa
-- question: Which animals have been in a shelter for over 5 months?
-- relevance: One of the articles, Raudies et al. (2021), found that dogs staying in a shelter for longer than 5 months can develop stress and behavioural problems. This lowers their chance for adoption so these animals need to be prioritized in adoption
-- note: This query uses a reference date of 2026-10-07, so 5 months earlier
SELECT
    Animals.name,
    Animals.species,
    Shelter.name AS shelter_name,
    Intake.intake_date
FROM Intake
JOIN Animals ON Animals.animal_id = Intake.animal_id
JOIN Shelter ON Shelter.shelter_id = Intake.shelter_id
WHERE Intake.intake_date < '2026-05-07'
ORDER BY Intake.intake_date ASC;

-- author: Alysha-sa
-- question: Which shelters are close to full capacity?
-- relevance: When shelters are overcrowded proper care for each animal cannot be guaranteed
SELECT
    shelter_id,
    name,
    current_capacity,
    max_capacity,
    ROUND(current_capacity / max_capacity * 100, 1) AS occupancy_pct
FROM Shelter
WHERE max_capacity > 0
ORDER BY occupancy_pct DESC;