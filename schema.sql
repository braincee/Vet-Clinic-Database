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
