-- careers
ALTER TABLE careers enable ROW level security;

CREATE POLICY "public can read careers" ON careers FOR
SELECT
  TO anon,
  authenticated USING (TRUE);

CREATE POLICY "authenticated can write careers" ON careers FOR ALL TO authenticated USING (auth.uid () IS NOT NULL)
WITH
  CHECK (auth.uid () IS NOT NULL);

-- skills
ALTER TABLE skills enable ROW level security;

CREATE POLICY "public can read skills" ON skills FOR
SELECT
  TO anon,
  authenticated USING (TRUE);

CREATE POLICY "authenticated can write skills" ON skills FOR ALL TO authenticated USING (auth.uid () IS NOT NULL)
WITH
  CHECK (auth.uid () IS NOT NULL);

-- certifications
ALTER TABLE certifications enable ROW level security;

CREATE POLICY "public can read certifications" ON certifications FOR
SELECT
  TO anon,
  authenticated USING (TRUE);

CREATE POLICY "authenticated can write certifications" ON certifications FOR ALL TO authenticated USING (auth.uid () IS NOT NULL)
WITH
  CHECK (auth.uid () IS NOT NULL);

-- hobbies
ALTER TABLE hobbies enable ROW level security;

CREATE POLICY "public can read hobbies" ON hobbies FOR
SELECT
  TO anon,
  authenticated USING (TRUE);

CREATE POLICY "authenticated can write hobbies" ON hobbies FOR ALL TO authenticated USING (auth.uid () IS NOT NULL)
WITH
  CHECK (auth.uid () IS NOT NULL);

-- blogs
ALTER TABLE blogs enable ROW level security;

CREATE POLICY "public can read blogs" ON blogs FOR
SELECT
  TO anon,
  authenticated USING (TRUE);

CREATE POLICY "authenticated can write blogs" ON blogs FOR ALL TO authenticated USING (auth.uid () IS NOT NULL)
WITH
  CHECK (auth.uid () IS NOT NULL);
