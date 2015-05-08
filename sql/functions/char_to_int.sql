CREATE OR REPLACE FUNCTION "public"."char_to_int"(chartoconvert varchar) RETURNS "pg_catalog"."int4" AS $BODY$
	
	SELECT CASE WHEN trim($1) SIMILAR TO '[0-9]+' 
        THEN CAST(trim($1) AS integer) 
    ELSE NULL END;

$BODY$
  LANGUAGE 'sql' IMMUTABLE STRICT  COST 100;