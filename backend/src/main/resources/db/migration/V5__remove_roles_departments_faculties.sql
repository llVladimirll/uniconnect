-- Drop foreign key constraints in users table
ALTER TABLE users
    DROP CONSTRAINT IF EXISTS users_department_id_fkey,
    DROP CONSTRAINT IF EXISTS users_faculty_id_fkey,
    DROP CONSTRAINT IF EXISTS users_role_id_fkey;

-- Drop the foreign key columns in users table
ALTER TABLE users
    DROP COLUMN IF EXISTS department_id,
    DROP COLUMN IF EXISTS faculty_id,
    DROP COLUMN IF EXISTS role_id;

-- Drop the lookup tables
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS faculties;
DROP TABLE IF EXISTS roles;