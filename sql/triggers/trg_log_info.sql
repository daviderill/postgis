CREATE OR REPLACE FUNCTION "carto"."trg_log_info"()
  RETURNS "pg_catalog"."trigger" AS $BODY$BEGIN

      IF TG_OP = 'INSERT' THEN

        INSERT INTO carto.log_info ("table", "id", "obs", "date_act") VALUES(TG_ARGV[0], NEW.id, 'insert', CURRENT_TIMESTAMP);

        RETURN NEW;

      ELSIF TG_OP = 'UPDATE' THEN

        INSERT INTO carto.log_info ("table", "id", "obs", "date_act") VALUES(TG_ARGV[0], OLD.id, 'update', CURRENT_TIMESTAMP);

       RETURN NEW;

      ELSIF TG_OP = 'DELETE' THEN

        INSERT INTO carto.log_info ("table", "id", "obs", "date_act") VALUES(TG_ARGV[0], OLD.id, 'delete', CURRENT_TIMESTAMP);

       RETURN NULL;

      END IF;

      RETURN NEW;

END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100;