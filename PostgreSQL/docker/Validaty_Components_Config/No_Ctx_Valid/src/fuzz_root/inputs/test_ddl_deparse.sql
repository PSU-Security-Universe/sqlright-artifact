CREATE EXTENSION test_ddl_deparse;
CREATE OR REPLACE FUNCTION test_ddl_deparse()  RETURNS event_trigger LANGUAGE plpgsql ASDECLARE	r record;
	r2 record;
	cmdtype text;
	objtype text;
	tag text;
BEGIN	FOR r IN SELECT * FROM pg_event_trigger_ddl_commands()	LOOP				tag = public.get_command_tag(r.command);
		IF tag <> r.command_tag THEN			RAISE NOTICE 'tag % doesn''t match %', tag, r.command_tag;
		END IF;
				cmdtype = public.get_command_type(r.command);
		IF cmdtype <> 'grant' THEN			RAISE NOTICE 'DDL test: type %, tag %', cmdtype, tag;
		ELSE			RAISE NOTICE 'DDL test: type %, object type %', cmdtype, r.object_type;
		END IF;
				IF cmdtype = 'alter table' THEN			FOR r2 IN SELECT *						FROM unnest(public.get_altertable_subcmdtypes(r.command))			LOOP				RAISE NOTICE '  subcommand: %', r2.unnest;
			END LOOP;
		END IF;
	END LOOP;
END;
;
CREATE EVENT TRIGGER test_ddl_deparseON ddl_command_end EXECUTE PROCEDURE test_ddl_deparse();
