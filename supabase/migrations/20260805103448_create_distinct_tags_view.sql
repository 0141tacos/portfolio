CREATE VIEW distinct_tags AS
SELECT DISTINCT
  tag
FROM
  blogs;

CREATE VIEW distinct_sub_tags AS
SELECT DISTINCT
  sub_tag
FROM
  blogs;
