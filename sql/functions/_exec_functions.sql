-- User functions
SELECT owner_all_tables('<schema>', '<owner>');
SELECT permission_all_tables('mapserver', 'select');
SELECT permission_schema_tables('derill', 'all', 'SCHEMA_NAME');

-- System functions
SELECT version();
SELECT PostGIS_full_version();


