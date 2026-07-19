CREATE EXTENSION if NOT EXISTS moddatetime schema extensions;

CREATE TABLE careers (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  company_name varchar(255) NOT NULL,
  period_from date NOT NULL,
  period_to date,
  position varchar(255) NOT NULL,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE skills (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  skill_name varchar(255) NOT NULL,
  description text,
  skill_level varchar(50) NOT NULL,
  is_active boolean NOT NULL DEFAULT TRUE,
  category varchar(50) NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE certifications (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  certification_name varchar(255) NOT NULL,
  description text,
  acquired_date date,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE hobbies (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  hobby_name varchar(255) NOT NULL,
  description text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TABLE blogs (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title varchar(255) NOT NULL,
  content text,
  tag varchar(255),
  sub_tag varchar(255),
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE TRIGGER handle_updated_at before
UPDATE ON careers FOR each ROW
EXECUTE procedure extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at before
UPDATE ON skills FOR each ROW
EXECUTE procedure extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at before
UPDATE ON certifications FOR each ROW
EXECUTE procedure extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at before
UPDATE ON hobbies FOR each ROW
EXECUTE procedure extensions.moddatetime (updated_at);

CREATE TRIGGER handle_updated_at before
UPDATE ON blogs FOR each ROW
EXECUTE procedure extensions.moddatetime (updated_at);
