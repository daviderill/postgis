CREATE OR REPLACE FUNCTION "public"."permission_all_tables"(username varchar, privilege varchar) RETURNS "pg_catalog"."bool" AS $BODY$
DECLARE
    registro  record;
	
BEGIN

	FOR registro IN SELECT * FROM pg_tables WHERE schemaname='public' LOOP
        EXECUTE 'GRANT ' || privilege || ' ON public.' || quote_ident(registro.tablename) || ' TO ' || quote_ident(username);
	END LOOP;
	FOR registro IN SELECT * FROM pg_views WHERE schemaname='public' LOOP
        EXECUTE 'GRANT ' || privilege || ' ON public.' || quote_ident(registro.viewname) || ' TO ' || quote_ident(username);
	END LOOP;
	RETURN TRUE;
  
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;