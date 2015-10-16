-- Removes duplicate rows
DELETE FROM <table> USING <table> AS aux
WHERE <table>.<field> = aux.<field> AND <table>.id < aux.id;