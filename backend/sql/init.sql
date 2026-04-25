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
  id serial PRIMARY KEY,
  skill_name varchar(255) NOT NULL,
  description text,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS certifications (
  id serial PRIMARY KEY,
  certification_name varchar(255) NOT NULL,
  description text,
  acquired_date date,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS hobbies (
  id serial PRIMARY KEY,
  hobby_name varchar(255) NOT NULL,
  description text,
  created_at timestamp DEFAULT current_timestamp,
  updated_at timestamp DEFAULT current_timestamp
);
