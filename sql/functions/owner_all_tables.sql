CREATE OR REPLACE FUNCTION "owner_all_tables"(schema_name varchar, cur_owner varchar, new_owner varchar) RETURNS "pg_catalog"."bool" language plpgsql AS $$

DECLARE
    registro  record;
	
BEGIN

	-- Tables
	FOR registro IN 
		SELECT * FROM pg_tables 
		WHERE schemaname = schema_name 
		AND tableowner = cur_owner
		ORDER BY tablename 
	LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.tablename) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;

	-- Views
	FOR registro IN 
		SELECT * FROM pg_views 
		WHERE schemaname = schema_name 
		AND viewowner = cur_owner
	LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.viewname) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;

	-- Sequences
	FOR registro IN 
		SELECT c.relname, u.usename, n.nspname
		FROM pg_class c, pg_user u, pg_namespace n
		WHERE c.relowner = u.usesysid 
			AND n.oid = c.relnamespace
			AND c.relkind = 'S' 
			AND u.usename = cur_owner
			AND n.nspname = schema_name
			AND relnamespace IN (
					SELECT oid
					FROM pg_namespace
					WHERE nspname NOT LIKE 'pg_%'
					AND nspname != 'information_schema'
				)
	LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.relname) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;

  RETURN TRUE;

END;
$$;



CREATE OR REPLACE FUNCTION "owner_all_tables"(schema_name varchar, new_owner varchar) RETURNS "pg_catalog"."bool" LANGUAGE 'plpgsql' AS $$

DECLARE
    registro  record;
	
BEGIN

	FOR registro IN SELECT * FROM pg_tables WHERE schemaname = schema_name ORDER BY tablename LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.tablename) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;
	FOR registro IN SELECT * FROM pg_views WHERE schemaname = schema_name LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.viewname) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;
	FOR registro IN SELECT * FROM pg_class WHERE relkind = 'S' LOOP
		EXECUTE 'ALTER TABLE ' || schema_name || '.' || quote_ident(registro.relname) || ' OWNER TO ' || quote_ident(new_owner);
	END LOOP;
	RETURN TRUE;
	
END;
$$;


