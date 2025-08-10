-- add new tables
CREATE TABLE departments (
                             id SERIAL PRIMARY KEY,
                             name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE faculties (
                           id SERIAL PRIMARY KEY,
                           name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE roles (
                       id SERIAL PRIMARY KEY,
                       name VARCHAR(100) UNIQUE NOT NULL
);

-- alter users table to use foreign keys
ALTER TABLE users
    DROP COLUMN department,
    DROP COLUMN faculty,
    DROP COLUMN role,
    ADD COLUMN department_id INT REFERENCES departments(id),
    ADD COLUMN faculty_id INT REFERENCES faculties(id),
    ADD COLUMN role_id INT REFERENCES roles(id);