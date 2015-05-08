CREATE ROLE user_besos LOGIN
  ENCRYPTED PASSWORD 'md593befd36b98b7b1cdcc7bf975cb8cddd'
  NOSUPERUSER NOINHERIT CREATEDB NOCREATEROLE;
COMMENT ON ROLE user_besos IS 'Usuari per al projecte de Drenatges Urbans del Riu Besòs';


CREATE ROLE mapserver LOGIN
  ENCRYPTED PASSWORD 'md5aadb200d62bb68b5132ab495f32cd315'
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

  
CREATE TABLE new_schema.mytable AS SELECT * FROM old_schema.mytable
to transfer the data and to recreate all associated constraints, indexes, sequences etc. manually.

create the table in the new schema with the existing definition and use
INSERT INTO new_schema.mytable SELECT * FROM old_schema.mytable;
to populate the table.