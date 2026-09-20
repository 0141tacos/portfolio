CREATE OR REPLACE VIEW distinct_tags
WITH
  (security_invoker = TRUE) AS
SELECT DISTINCT
  tag
FROM
  blogs
WHERE
  tag IS NOT NULL
  AND tag <> '';

CREATE OR REPLACE VIEW distinct_sub_tags
WITH
  (security_invoker = TRUE) AS
SELECT DISTINCT
  sub_tag
FROM
  blogs
WHERE
  sub_tag IS NOT NULL
  AND sub_tag <> '';
