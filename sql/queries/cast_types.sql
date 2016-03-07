-- Cast varchar to int
ALTER TABLE table_name
  ALTER COLUMN column_name TYPE integer USING column_name::int4;