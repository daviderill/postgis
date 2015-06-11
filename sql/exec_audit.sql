-- To audit all the tables of the schema, execute:
-- SELECT audit.audit_schema('<schemaname>');

-- To audit just one table, execute:
-- SELECT audit.audit_table('<schemaname>.<tablename>');

-- Audit all the tables of the specified schema:
SELECT audit.audit_schema('_PARAM.SCHEMA.NAME_');
