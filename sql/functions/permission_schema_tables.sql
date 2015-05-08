CREATE OR REPLACE FUNCTION "SCHEMA_NAME"."permission_schema_tables"(username varchar, privilege varchar, schema_name varchar) RETURNS "pg_catalog"."bool" AS $BODY$
DECLARE
    registro  record;
	
BEGIN
  FOR registro IN SELECT * FROM pg_tables WHERE schemaname = schema_name LOOP
      EXECUTE 'GRANT ' || privilege || ' ON ' || schema_name || '.' || quote_ident(registro.tablename) || ' TO ' || quote_ident(username);
  END LOOP;
  FOR registro IN SELECT * FROM pg_views WHERE schemaname = schema_name LOOP
      EXECUTE 'GRANT ' || privilege || ' ON ' || schema_name || '.' || quote_ident(registro.viewname) || ' TO ' || quote_ident(username);
  END LOOP;
  FOR registro IN SELECT * FROM pg_class WHERE relkind = 'S' LOOP
      EXECUTE 'GRANT ' || privilege || ' ON ' || schema_name || '.' || quote_ident(registro.relname) || ' TO ' || quote_ident(username);
  END LOOP;
  RETURN TRUE;
  
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;