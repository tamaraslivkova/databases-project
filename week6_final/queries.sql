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
-- question: Which shelters have no vets currently employed?
-- relevance: If animals are ill when they arrive shelters without any vets cannot treat them
SELECT
    s.shelter_id,
    s.name
FROM Shelter s
WHERE NOT EXISTS (
    SELECT 1
    FROM Staff st
    WHERE st.shelter_id = s.shelter_id
      AND st.role = 'Vet'
)
ORDER BY s.shelter_id;

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