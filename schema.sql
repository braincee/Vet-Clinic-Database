/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(300) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- creating owners table

CREATE TABLE owners (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(300);
    age INTEGER
);

-- creating species table

CREATE TABLE species(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100)
);

-- removing column species from table animals

ALTER TABLE animals DROP COLUMN species;

-- adding column species_id which is a foreign key referencing species table

ALTER TABLE animals ADD COLUMN species_id FOREIGN KEY REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing owners table

ALTER TABLE animals ADD COLUMN owneer_id BIGINT REFERENCES owners(id);


-- Creating a table named vets

CREATE TABLE vets (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100),
    age INTEGER,
    date_of_graduation DATE
);


