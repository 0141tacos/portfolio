CREATE TABLE IF NOT EXISTS careers (
  id SERIAL PRIMARY KEY,
  company_name varchar(255) NOT NULL,
  period_from date NOT NULL,
  period_to date,
  position varchar(255) NOT NULL,
  description text,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS skills (
  id SERIAL PRIMARY KEY,
  skill_name varchar(255) NOT NULL,
  description text,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS certifications (
  id SERIAL PRIMARY KEY,
  certification_name varchar(255) NOT NULL,
  description text,
  acquired_date date,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS hobbies (
  id SERIAL PRIMARY KEY,
  hobby_name varchar(255) NOT NULL,
  description text,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE OR REPLACE FUNCTION update_updated_at_column () returns trigger AS $$
begin
  new.updated_at = current_timestamp;
  return new;
end;
$$ language plpgsql;

CREATE TRIGGER set_updated_at_careers before
UPDATE ON careers FOR each ROW
EXECUTE FUNCTION update_updated_at_column ();

CREATE TRIGGER set_updated_at_skills before
UPDATE ON skills FOR each ROW
EXECUTE FUNCTION update_updated_at_column ();

CREATE TRIGGER set_updated_at_certifications before
UPDATE ON certifications FOR each ROW
EXECUTE FUNCTION update_updated_at_column ();

CREATE TRIGGER set_updated_at_hobbies before
UPDATE ON hobbies FOR each ROW
EXECUTE FUNCTION update_updated_at_column ();