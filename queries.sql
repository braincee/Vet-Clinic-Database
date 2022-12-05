/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < '3';

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = True;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--Begin animal transaction

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;

-- another animal transaction

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;


-- delete transaction

BEGIN;
DELETE FROM animals;
ROLLBACK;

-- another delete transaction

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SAVEPOINT_1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT_1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


-- queries to answer following questions

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg) AS maximum_weight, MIN(weight_kg) AS minimum_weight FROM animals GROUP BY species;
SELECT species, ROUND(AVG(escape_attempts), 2) AS average_escape_attempts FROM animals WHERE date_of_birth >= 
'1990-01-01' AND date_of_birth < '2000-12-31' GROUP BY species;

-- write queries (using JOIN) to answer the follwing questions:

-- what animals belong to Melody Pond ?

SELECT full_name AS OWNER, name AS ANIMALS_NAMES FROM owners O JOIN animals A ON O.id = A.owner_id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon(their type is Pokemon)

SELECT A.name AS ANIMAL_NAMES, S.name AS SPECIES_TYPE FROM species S JOIN animals A ON S.id = A.species_id WHERE S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal

SELECT O.full_name AS OWNER, A.name AS ANIMAL_NAMES FROM owners O LEFT JOIN animals A ON O.id = A.owner_id;

-- How many animals are there per species ?

SELECT S.name AS SPECIES_TYPE, COUNT(A.name) AS NUMBER_PER_SPECIES FROM species S JOIN animals A ON S.id = A.species_id GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell

SELECT O.full_name AS OWNER, A.name AS ANIMAL_NAMES, S.name AS SPECIES_TYPE FROM owners O JOIN animals A ON O.id = A.owner_id 
JOIN species S ON S.id = A.species_id WHERE O.full_name = 'Jennifer Orwell' AND S.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape

SELECT owners.full_name AS OWNER, animals.name AS ANIMAL_NAMES, animals.escape_attempts AS ESCAPE_ATTEMPTS FROM animals
JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals ?

SELECT O.full_name AS OWNER, COUNT(a.name) AS TOTAL_ANIMALS FROM owners AS O LEFT JOIN animals AS A
ON A.owner_id = O.id GROUP BY O.full_name ORDER BY COUNT(A.name) DESC LIMIT 1;

-- Write queries to answer the following:

-- Who was the last animal seen by William Tatcher ?

SELECT vets.name AS vets_name, animals.name AS animal_name, visits.date_of_visit AS date_of_visit FROM vets
INNER JOIN visits ON vets.id = visits.vet_id INNER JOIN animals ON animals.id = visits.animal_id WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see ?

SELECT vets.name AS vets_name, COUNT(visits.animal_id) AS seen_animals FROM vets INNER JOIN visits 
ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;

-- List all vets and their spcialties, including vets with no specialties.

SELECT vets.name AS vets_name, species.name AS specialties FROM vets LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT vets.name AS vets_name, animals.name AS animal_name, visits.date_of_visit AS date_of_visit FROM vets
INNER JOIN visits ON vets.id = visits.vet_id INNER JOIN animals ON visits.animal_id = animals.id WHERE 
vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name AS animal_name, COUNT(animals.id) AS most_visits FROM visits
INNER JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY COUNT(animals.id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT vets.name AS vets_name, visits.date_of_visit AS date_of_visit FROM vets
INNER JOIN visits ON vets.id = visits.vet_id WHERE vets.name = 'Maisy Smith' ORDER BY visits.date_of_visit
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT animals.name AS animal_name, animals.date_of_birth AS date_of_birth, animals.escape_attempts AS escape_attempts, 
animals.neutered AS neutered, animals.weight_kg AS weight_kg, species.name AS species_type, vets.name AS vets_name, 
vets.age AS vets_age, vets.date_of_graduation AS date_of_graduation, visits.date_of_visit AS date_of_visit FROM visits 
INNER JOIN animals ON visits.animal_id = animals.id INNER JOIN species ON animals.species_id = species.id
INNER JOIN vets ON visits.vet_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT vets.name AS vets_name, COUNT(visits.animal_id) AS number_of_visits, COUNT(specializations.species_id) AS species_specialities FROM visits JOIN animals ON animals.id = visits.animal_id FULL JOIN specializations 
ON visits.vet_id = specializations.vet_id JOIN vets ON visits.vet_id = vets.id GROUP BY visits.animal_id, visits.vet_id, animals.name,
specializations.species_id, vets.name ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT vets.name AS vets_name, species.name AS species_type, COUNT(visits.animal_id) AS number_of_visits FROM visits
INNER JOIN vets ON visits.vet_id = vets.id INNER JOIN animals ON visits.animal_id = animals.id INNER JOIN species ON 
animals.species_id = species.id WHERE vets.name = 'Maisy Smith' GROUP BY vets.name, animals.species_id, species.name 
ORDER BY animals.species_id DESC LIMIT 1;

