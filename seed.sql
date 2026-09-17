-- mock data

-- shelter
INSERT INTO Shelter (address, current_capacity, max_capacity) VALUES
('Mainstreet 1, Amsterdam', 58, 100),
('Citystreet 3, Rotterdam', 40, 85),
('Farmroad 12, Utrecht',    22, 60),
('Oakavenue 7, Maastricht', 35, 70);

-- staff
INSERT INTO Staff (name, role, shelter_id) VALUES
('Kiki',    'Vet',            1),
('Ariana',  'Assistant Vet',  1),
('Chantal', 'Receptionist',   1),
('Harry',   'Caretaker',      1),
('Zara',    'Vet',            2),
('Benito',  'Animal Groomer', 2),
('Lotte',   'Receptionist',   2),
('Dave',    'Caretaker',      3),
('Fien',    'Vet',            3),
('Robin',   'Manager',        4),
('Mila',    'Caretaker',      4);


-- animals
INSERT INTO Animals (age, species, breed, sex, shelter_id) VALUES
(2,  'dog',    'Border Collie',     'Male',    1),
(1,  'cat',    'Ragdoll',           'Male',    1),
(2,  'bunny',  'Netherland Dwarf',  'Female',  1),
(5,  'cat',    'Persian',           'Female',  1),
(4,  'dog',    'German Shepherd',   'Male',    1),
(7,  'dog',    'Golden Retriever',  'Female',  2),
(9,  'bunny',  'Californian',       'Male',    2),
(10, 'dog',    'Labrador',          'Female',  2),
(3,  'cat',    'Maine Coon',        'Male',    2),
(1,  'dog',    'Beagle',            'Female',  2),
(2,  'goat',   'Pygmy',             'Female',  3),
(3,  'goat',   'Pygmy',             'Male',    3),
(6,  'horse',  'Shetland Pony',     'Female',  3),
(4,  'sheep',  'Suffolk',           'Female',  3),
(5,  'dog',    'Boxer',             'Male',    4),
(2,  'cat',    'Siamese',           'Female',  4),
(6,  'dog',    'Dachshund',         'Male',    4),
(1,  'cat',    'Sphynx',            'Female',  4);


-- intake
INSERT INTO Intake (intake_type, date, animal_id, shelter_id) VALUES
('stray',      '2024-03-03', 1,  1),
('surrender',  '2025-05-27', 2,  1),
('stray',      '2023-10-06', 3,  1),
('surrender',  '2026-02-04', 4,  1),
('stray',      '2024-08-19', 5,  1),
('stray',      '2022-03-05', 6,  2),
('surrender',  '2026-03-06', 7,  2),
('stray',      '2024-01-11', 8,  2),
('surrender',  '2025-07-22', 9,  2),
('stray',      '2026-04-14', 10, 2),
('surrender',  '2025-09-01', 11, 3),
('stray',      '2025-09-01', 12, 3),
('surrender',  '2024-12-12', 13, 3),
('stray',      '2025-05-05', 14, 3),
('surrender',  '2024-06-09', 15, 4),
('stray',      '2025-08-23', 16, 4),
('surrender',  '2026-01-02', 17, 4),
('stray',      '2025-12-25', 18, 4);
