CREATE OR REPLACE FUNCTION "public"."permission_one_table"(username varchar, privilege varchar, tablename varchar) RETURNS "pg_catalog"."bool" AS $BODY$

BEGIN
	EXECUTE 'GRANT ' || privilege || ' ON public.' || quote_ident(tablename) || ' TO ' || quote_ident(username);
	RETURN TRUE;
END;

$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;