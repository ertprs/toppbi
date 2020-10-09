/* CREATE FUNCTION change_trigger() RETURNS trigger AS $$
       BEGIN
         IF TG_OP = 'INSERT'
         THEN INSERT INTO logging.t_history (
                tabname, schemaname, operation, new_val
              ) VALUES (
                TG_RELNAME, TG_TABLE_SCHEMA, TG_OP, row_to_json(NEW)
              );
           RETURN NEW;
         ELSIF  TG_OP = 'UPDATE'
         THEN
           INSERT INTO logging.t_history (
             tabname, schemaname, operation, new_val, old_val
           )
           VALUES (TG_RELNAME, TG_TABLE_SCHEMA, TG_OP, row_to_json(NEW), row_to_json(OLD));
           RETURN NEW;
         ELSIF TG_OP = 'DELETE'
         THEN
           INSERT INTO logging.t_history
             (tabname, schemaname, operation, old_val)
             VALUES (
               TG_RELNAME, TG_TABLE_SCHEMA, TG_OP, row_to_json(OLD)
             );
             RETURN OLD;
         END IF;
       END;
$$ LANGUAGE 'plpgsql' SECURITY DEFINER;

CREATE TRIGGER t BEFORE INSERT OR UPDATE OR DELETE ON usuario
        FOR EACH ROW EXECUTE PROCEDURE change_trigger(); */
		
--select *from logging.t_history	

/* INSERT INTO "ocorrencia" (dtinicio, dtnormal, motivo, fkoperadora, fktiporeg) VALUES
    ('2020-09-23 08:45:00','2020-09-23 11:21:00', 'x', 9,4),
    ('2020-09-25 09:24:00','2020-09-25 14:00:00', 'x', 9,4),
    ('2020-10-02 12:33:00','2020-10-02 14:10:00', 'x', 9,2),
    ('2020-10-04 14:15:00','2020-10-04 19:00:00', 'x', 9,3),
    ('2020-10-04 14:15:00','2020-10-04 19:00:00', 'x', 8,3),
    ('2020-09-12 10:30:00','2020-09-25 21:00:00', 'x', 8,2),
    ('2020-09-16 09:21:00','2020-09-16 09:30:00', 'x', 7,3),
    ('2020-09-16 13:42:00','2020-09-19 21:15:00', 'x', 7,2),
    ('2020-09-21 13:18:00','2020-09-25 21:00:00', 'x', 7,2),
    ('2020-09-28 14:39:00','2020-09-28 16:48:00', 'x', 7,3),
    ('2020-09-29 08:24:00','2020-09-29 13:21:00', 'x', 7,3),
    ('2020-09-30 15:33:00','2020-09-30 22:54:00', 'x', 7,2),
    ('2020-10-02 12:33:00','2020-10-02 14:10:00', 'x', 7,2),
    ('2020-10-04 14:15:00','2020-10-04 19:00:00', 'x', 7,3),
    ('2020-09-28 14:45:00','2020-09-29 11:39:00', 'x', 10,3),
    ('2020-09-30 09:30:00','2020-09-30 13:51:00', 'x', 10,2),
    ('2020-09-30 15:32:00','2020-09-30 15:57:00', 'x', 10,4),
    ('2020-09-30 19:00:00','2020-09-30 19:12:00', 'x', 10,3),
    ('2020-10-01 01:30:00','2020-10-01 02:06:00', 'x', 10,3),
    ('2020-10-04 14:15:00','2020-10-04 15:30:00', 'x', 10,3),
    ('2020-10-05 08:24:00','2020-10-05 08:45:00', 'x', 10,4); */