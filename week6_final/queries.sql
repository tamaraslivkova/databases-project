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

-- @block
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

-- @block
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

-- @block
-- author: tamaraslivkova
-- question: How many animals of each species are taken in per month?
-- relevance: This can show peaks in intakes per species, so shelters can prepare (capacity, staff, adoption)
SELECT
    DATE_FORMAT(Intake.intake_date, '%Y-%m') AS intake_month,
    Animals.species,
    COUNT(*) AS total_intakes
FROM Intake
JOIN Animals ON Animals.animal_id = Intake.animal_id
GROUP BY intake_month, Animals.species
ORDER BY intake_month DESC, total_intakes DESC;

-- @block
-- author: tamaraslivkova
-- question: Which animals were taken in recently?
-- relevance: This helps identify sudden increases in intakes
SELECT
    Animals.name AS animal_name,
    Animals.species,
    Intake.intake_date
FROM Animals
JOIN Intake ON Animals.animal_id = Intake.animal_id
ORDER BY Intake.intake_date DESC;


--@block
--author: miki248
--question: Which dog breeds have at least 10 animals in the shelter database?
--relevance: This query supports shelter capacity planning and animal welfare management by
--identifying popular dog breeds entering the facility.

SELECT
    breed AS `Primary Breed`,
    COUNT(*) AS total_count
FROM Animals
WHERE species = 'Dog'
GROUP BY breed
HAVING total_count >= 10
ORDER BY total_count DESC;


-- @block
-- author: miki248
-- question: What is the gender distribution per species?
-- relevance: It's important for spay/neuter planning
SELECT
    LOWER(TRIM(species)) AS species_type,
    COUNT(*) AS total_count,
    SUM(CASE WHEN sex = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN sex = 'Female' THEN 1 ELSE 0 END) AS female_count,
    SUM(CASE WHEN sex = 'Unknown' OR sex IS NULL THEN 1 ELSE 0 END) AS unknown_count
FROM Animals
GROUP BY LOWER(TRIM(species))
ORDER BY total_count DESC;