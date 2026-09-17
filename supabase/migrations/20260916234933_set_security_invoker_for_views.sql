ALTER VIEW distinct_tags
SET
  (security_invoker = TRUE);

ALTER VIEW distinct_sub_tags
SET
  (security_invoker = TRUE);
