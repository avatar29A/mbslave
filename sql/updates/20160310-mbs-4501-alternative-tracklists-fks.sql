\set ON_ERROR_STOP 1
BEGIN;

ALTER TABLE alternative_medium
   ADD CONSTRAINT alternative_medium_fk_medium
   FOREIGN KEY (medium)
   REFERENCES medium(id);

ALTER TABLE alternative_medium
   ADD CONSTRAINT alternative_medium_fk_alternative_release
   FOREIGN KEY (alternative_release)
   REFERENCES alternative_release(id);

ALTER TABLE alternative_medium_track
   ADD CONSTRAINT alternative_medium_track_fk_alternative_medium
   FOREIGN KEY (alternative_medium)
   REFERENCES alternative_medium(id);

ALTER TABLE alternative_medium_track
   ADD CONSTRAINT alternative_medium_track_fk_track
   FOREIGN KEY (track)
   REFERENCES track(id);

ALTER TABLE alternative_medium_track
   ADD CONSTRAINT alternative_medium_track_fk_alternative_track
   FOREIGN KEY (alternative_track)
   REFERENCES alternative_track(id);

ALTER TABLE alternative_release
   ADD CONSTRAINT alternative_release_fk_release
   FOREIGN KEY (release)
   REFERENCES release(id);

ALTER TABLE alternative_release
   ADD CONSTRAINT alternative_release_fk_artist_credit
   FOREIGN KEY (artist_credit)
   REFERENCES artist_credit(id);

ALTER TABLE alternative_release
   ADD CONSTRAINT alternative_release_fk_type
   FOREIGN KEY (type)
   REFERENCES alternative_release_type(id);

ALTER TABLE alternative_release
   ADD CONSTRAINT alternative_release_fk_language
   FOREIGN KEY (language)
   REFERENCES language(id);

ALTER TABLE alternative_release
   ADD CONSTRAINT alternative_release_fk_script
   FOREIGN KEY (script)
   REFERENCES script(id);

ALTER TABLE alternative_release_type
   ADD CONSTRAINT alternative_release_type_fk_parent
   FOREIGN KEY (parent)
   REFERENCES alternative_release_type(id);

ALTER TABLE alternative_track
   ADD CONSTRAINT alternative_track_fk_artist_credit
   FOREIGN KEY (artist_credit)
   REFERENCES artist_credit(id);

CREATE TRIGGER a_ins_alternative_release AFTER INSERT ON alternative_release
    FOR EACH ROW EXECUTE PROCEDURE a_ins_alternative_release_or_track();

CREATE TRIGGER a_ins_alternative_track AFTER INSERT ON alternative_track
    FOR EACH ROW EXECUTE PROCEDURE a_ins_alternative_release_or_track();

CREATE TRIGGER a_upd_alternative_release AFTER UPDATE ON alternative_release
    FOR EACH ROW EXECUTE PROCEDURE a_upd_alternative_release_or_track();

CREATE TRIGGER a_upd_alternative_track AFTER UPDATE ON alternative_track
    FOR EACH ROW EXECUTE PROCEDURE a_upd_alternative_release_or_track();

CREATE TRIGGER a_del_alternative_release AFTER DELETE ON alternative_release
    FOR EACH ROW EXECUTE PROCEDURE a_del_alternative_release_or_track();

CREATE TRIGGER a_del_alternative_track AFTER DELETE ON alternative_track
    FOR EACH ROW EXECUTE PROCEDURE a_del_alternative_release_or_track();

CREATE TRIGGER a_ins_alternative_medium_track AFTER INSERT ON alternative_medium_track
    FOR EACH ROW EXECUTE PROCEDURE a_ins_alternative_medium_track();

CREATE TRIGGER a_upd_alternative_medium_track AFTER UPDATE ON alternative_medium_track
    FOR EACH ROW EXECUTE PROCEDURE a_upd_alternative_medium_track();

CREATE TRIGGER a_del_alternative_medium_track AFTER DELETE ON alternative_medium_track
    FOR EACH ROW EXECUTE PROCEDURE a_del_alternative_medium_track();

COMMIT;
