CREATE OR REPLACE FUNCTION "audit"."audit_schema_start"(schema_name varchar) RETURNS "pg_catalog"."void" AS $BODY$
DECLARE
    aux text;
    rec record;

BEGIN
    FOR rec IN SELECT * FROM pg_tables WHERE schemaname = schema_name LOOP
        aux:= schema_name||'.'||quote_ident(rec.tablename);
        EXECUTE 'ALTER TABLE '||aux||' ENABLE trigger audit_trigger_row';
        EXECUTE 'ALTER TABLE '||aux||' ENABLE trigger audit_trigger_stm';
    END LOOP;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;