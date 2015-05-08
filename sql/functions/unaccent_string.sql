CREATE OR REPLACE FUNCTION "public"."unaccent_string"(text)
  RETURNS "pg_catalog"."text" AS $BODY$
SELECT translate(
    $1,
    '������aaa������AAA�����eeeee��EEEEE�����iii�����III�����ooo�����OOO����uuuu����UUUU',
    'aaaaaaaaaaaaaaaaaaeeeeeeeeeeeeeeeeeiiiiiiiiiiiiiiiioooooooooooooooouuuuuuuuuuuuuuuu'
);
$BODY$
  LANGUAGE 'sql' IMMUTABLE STRICT COST 100;

ALTER FUNCTION "public"."unaccent_string"(text) OWNER TO "postgres";