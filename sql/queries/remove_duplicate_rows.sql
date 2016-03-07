-- Removes duplicate rows
DELETE FROM <table> a
WHERE a.id <> (SELECT MIN(b.id)
               FROM <table> b
               WHERE a.<field_1> = b.<field_1> [AND a.<field_2> = b.<field_2>]);