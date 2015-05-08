CREATE OR REPLACE FUNCTION "carto"."reset_sequence" (tablename text) RETURNS "pg_catalog"."void" AS 
$body$  
  DECLARE 
  BEGIN 
  EXECUTE 'SELECT setval( ''' 
  || tablename  
  || '_id_seq'', ' 
  || '(SELECT id + 1 FROM carto."' 
  || tablename  
  || '" ORDER BY id DESC LIMIT 1), false)';  
  END;  
$body$  
LANGUAGE 'plpgsql';
ALTER FUNCTION "public"."reset_sequence"(tablename text) OWNER TO "calaf";


--select sequence_name, reset_sequence(split_part(sequence_name, '_id_seq',1)) from information_schema.sequences where sequence_schema='public';


CREATE OR REPLACE FUNCTION "public"."reset_sequence"(tablename text)
  RETURNS "pg_catalog"."void" AS $BODY$  
  DECLARE 
	registro record;
  BEGIN 
	FOR registro IN SELECT * FROM pg_tables WHERE schemaname='public' LOOP
        --EXECUTE 'ALTER TABLE public.' || quote_ident(registro.tablename) || ' OWNER TO ' || quote_ident(propietari);
		EXECUTE 'SELECT setval( ''' || registro.tablename || '_seq'', ' 
			|| '(SELECT id + 1 FROM "' || registro.tablename  
			|| '" ORDER BY id DESC LIMIT 1), false)';  
	END LOOP;
  END;  
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;