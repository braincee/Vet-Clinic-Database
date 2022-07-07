/* Populate database with sample data. */

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg
    ) 
VALUES (
    'Agumon', 
    '2020-02-03', 
    0, 
    True, 
    10.23
    );

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg
    ) 
VALUES (
    'Gabumon', 
    '2018-11-15', 
    2, 
    True, 
    8
    );

INSERT INTO animals (
    name, 
    date_of_birth, 
    escape_attempts, 
    neutered, 
    weight_kg
    ) 
VALUES (
    'Pikachu',
    '2021-01-07',
    1,
    False,
    15.04
    );

INSERT INTO animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
    ) 
VALUES (
    'Devimon',
    '2017-05-12',
    5,
    True,
    11
);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', '2020-02-08', 0, False, -11),
        ('Plantmon', '2021-11-15', 2, True, -5.7),
        ('Squirtle', '1993-04-02', 3, False, -12.13),
        ('Angemon', '2005-06-12', 1, True, -45),
        ('Boarmon', '2005-06-07', 7, True, 20.4),
        ('Blossom', '1998-10-13', 3, True, 17),
        ('Ditto', '2022-05-14', 4, True, 22);


-- inserting data into owners table

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- inserting data into species table 

INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');

-- Modifying inserted animals so it includes the species_id:
-- if the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';

-- all other animals are Pokemon

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):

-- Sam Smith owns Agumon

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';

-- Jennifer Orwell owns Gabumon and Pikachu

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';

-- Bob owns Devimon and Plantmon

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, Blossom

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

-- insert data into vets table

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher', 45, '2000-04-23'),
        ('Maisy Smith', 26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'),
        ('Jack Harkness', 38, '2008-06-08');

-- insert data into specializations table

INSERT INTO specializations (vets_name, species_name) 
VALUES ('William Tatcher','Pokemon'),
       ('Stephanie Mendez','Digimon,Pokemon'),
       ('Jack Harkness','Digimon');

-- insert data into visits table

INSERT INTO visits (animal_names, vets_name, date_of_visit) 
VALUES ('Agumon','William Tatcher','2020-05-25'),
       ('Agumon','Stephanie Mendez','2020-07-22'),
       ('Gabumon','Jack Harkness','2021-02-02'),
       ('Pikachu','Maisy Smith','2020-01-05'),
       ('Pikachu','Maisy Smith','2020-03-08'),
       ('Pikachu','Maisy Smith','2020-05-14'),
       ('Devimon','Stephanie Mendez','2021-05-04'),
       ('Charmander','Jack Harkness','2021-02-24'),
       ('Plantmon','Maisy Smith','2019-12-21'),
       ('Plantmon','William Tatcher','2020-04-10'),
       ('Squirtle','Stephanie Mendez','2020-09-29'),
       ('Angemon','Jack Harkness','2020-10-03'),
       ('Angemon','Jack Harkness','2020-11-04'),
       ('Boarmon','Maisy Smith','2019-01-24'),
       ('Boarmon','Maisy Smith','2019-05-15'),
       ('Boarmon','Maisy Smith','2020-02-27'),
       ('Boarmon','Maisy Smith','2019-01-24'),
       ('Boarmon','Maisy Smith','2020-08-03'),
       ('Blossom','Stephanie Mendaz','2020-05-24'),
       ('Blossom','Willia, Tatcher','2021-01-11');
