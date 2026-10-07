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



--author: miki248
SELECT `Primary Breed`, COUNT(*) AS total_count
FROM animals
WHERE Type = 'Dog'
GROUP BY `Primary Breed`
HAVING COUNT(*) >= 10
ORDER BY total_count DESC;


--author: miki248
SELECT
    Type AS species,
    COUNT(*) AS total_outcomes,
    COUNT(CASE WHEN `Outcome Status` = 'Adopted' THEN 1 END) AS adopted_count,
    ROUND(100.0 * COUNT(CASE WHEN `Outcome Status` = 'Adopted' THEN 1 END) / COUNT(*), 2) AS adoption_rate_pct,
    COUNT(CASE WHEN `Outcome Status` = 'Euthanasia' THEN 1 END) AS euthanasia_count,
    ROUND(100.0 * COUNT(CASE WHEN `Outcome Status` = 'Euthanasia' THEN 1 END) / COUNT(*), 2) AS euthanasia_rate_pct
FROM Outcomes
WHERE DATE_FORMAT(`Outcome Date`, '%Y-%m') = DATE_FORMAT(CURRENT_DATE, '%Y-%m')
GROUP BY Type
ORDER BY total_outcomes DESC;