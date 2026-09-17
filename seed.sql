-- mock data

-- shelter
INSERT INTO Shelter (name, address, current_capacity, max_capacity) VALUES
('Happy Tails', 'Mainstreet 1', 60, 100),
('City Paws', 'Citystreet 3', 85, 200);
('Second Chance Farm', 'Farmroad 12, Utrecht', 22, 60),
('Furever Home', 'Oakavenue 7, Maastricht', 35, 70);

-- staff
INSERT INTO Staff (shelter_id, first_name, last_name, role) VALUES
(1, 'Kiki', 'Bakker', 'Vet'),
(1, 'Lara', 'Jansen', 'Vet'),
(2, 'Zara', 'de Vries', 'Vet'),
(1, 'Chantal', 'Visser', 'Receptionist'),
(1, 'Ariana', 'Smit', 'Assistant Vet'),
(1, 'Harry', 'Mulder', 'Caretaker'),
(2, 'Benito', 'de Boer', 'Animal Groomer'),
(2, 'Lotte', 'Dekker', 'Receptionist'),
(3, 'Dave', 'Peeters', 'Caretaker'),
(3, 'Fien', 'Willems', 'Vet'),
(4, 'Robin', 'Hendriks', 'Manager'),
(4, 'Mila', 'Verhoeven', 'Caretaker');

-- animals
INSERT INTO Animals (shelter_id, name, age, species, breed, sex) VALUES
(1, 'Max',    2,  'dog',   'Border Collie', 'Male'),
(1, 'Gerard', 1,  'cat',   'Ragdoll', 'Male'),
(2, 'Luna',   7,  'dog',   'Golden Retriever', 'Female'),
(1, 'Harold', 9,  'bunny', 'Californian', 'Male'),
(1, 'Simba',  2,  'bunny', 'Netherland Dwarf', 'Female'),
(1, 'Kitty',  5,  'cat',   'Persian', 'Female'),
(2, 'Stella', 10, 'dog',   'Labrador', 'Female'),
(2, 'Whiskers', 3, 'cat',   'Maine Coon', 'Male'),
(2, 'Daisy',    1, 'dog',   'Beagle', 'Female'),
(3, 'Bramble',  2, 'goat',  'Pygmy', 'Female'),
(3, 'Clover',   3, 'goat',  'Pygmy', 'Male'),
(3, 'Hazel',    6, 'horse', 'Shetland Pony', 'Female'),
(3, 'Nutmeg',   4, 'sheep', 'Suffolk', 'Female'),
(4, 'Rocky',    5, 'dog',   'Boxer', 'Male'),
(4, 'Ivy',      2, 'cat',   'Siamese', 'Female'),
(4, 'Oscar',    6, 'dog',   'Dachshund', 'Male'),
(4, 'Ruby',     1, 'cat',   'Sphynx', 'Female');

-- intake
INSERT INTO Intake (animal_id, shelter_id, intake_date) VALUES
(1, 1, '2024-03-03'),
(2, 1, '2025-05-27'),
(3, 2, '2022-03-05'),
(4, 1, '2023-10-06'),
(5, 1, '2023-10-06'),
(6, 1, '2026-02-04'),
(7, 2, '2024-01-11'),
(8,  2, '2025-07-22'),
(9,  2, '2026-04-14'),
(10, 3, '2025-09-01'),
(11, 3, '2025-09-02'),
(12, 3, '2024-12-12'),
(13, 3, '2025-05-05'),
(14, 4, '2024-06-09'),
(15, 4, '2025-08-23'),
(16, 4, '2026-01-02'),
(17, 4, '2025-12-25');
