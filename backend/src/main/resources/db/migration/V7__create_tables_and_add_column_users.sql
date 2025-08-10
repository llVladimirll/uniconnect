CREATE TABLE departments (
                             id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                             name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE faculties (
                           id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                           name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE roles (
                       id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       name VARCHAR(100) UNIQUE NOT NULL
);

ALTER TABLE users
    ADD COLUMN department_id UUID REFERENCES departments(id),
    ADD COLUMN faculty_id UUID REFERENCES faculties(id),
    ADD COLUMN role_id UUID REFERENCES roles(id);
