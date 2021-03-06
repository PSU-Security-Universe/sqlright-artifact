SELECT statement_digest( 'SELECT 1' ) = statement_digest( 'SELECT 1 FROM DUAL' );
SELECT enabled INTO @original_setting FROM performance_schema.setup_consumers WHERE NAME = 'statements_digest';
UPDATE performance_schema.setup_consumers SET enabled = 'NO' WHERE NAME = 'statements_digest';
SET @the_digest = statement_digest( "SELECT statement_digest( 'SELECT 1' ) IS NULL" );
UPDATE performance_schema.setup_consumers SET enabled = 'YES' WHERE NAME = 'statements_digest';
SET @ps_protocol = 0;
SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL;
SELECT digest_text, IF( @the_digest = digest, 'YES', 'NO' ) AS digest_is_correct FROM performance_schema.events_statements_history WHERE sql_text = convert( "SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL" USING utf8 ) UNION SELECT statement_digest_text( "SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL" ), 'YES' FROM (SELECT 1) a1 JOIN (SELECT @ps_protocol) a2;
UPDATE performance_schema.setup_consumers SET enabled = @original_setting WHERE NAME = 'statements_digest';
SELECT enabled INTO @original_setting FROM performance_schema.setup_consumers WHERE NAME = 'statements_digest';
UPDATE performance_schema.setup_consumers SET enabled = 'NO' WHERE NAME = 'statements_digest';
SET @the_digest = statement_digest_text( "SELECT statement_digest( 'SELECT 1' ) IS NULL" );
UPDATE performance_schema.setup_consumers SET enabled = 'YES' WHERE NAME = 'statements_digest';
SET @ps_protocol = 0;
SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL;
SELECT digest_text, IF( @the_digest = digest_text, 'YES', 'NO' ) AS digest_is_correct FROM performance_schema.events_statements_history WHERE sql_text = convert( "SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL" USING utf8 ) UNION SELECT statement_digest_text( "SELECT statement_digest( 'SELECT 1 FROM DUAL' ) IS NULL" ), 'YES' FROM (SELECT 1) a1 JOIN (SELECT @ps_protocol) a2;
UPDATE performance_schema.setup_consumers SET enabled = @original_setting WHERE NAME = 'statements_digest';
CREATE TABLE t1 AS SELECT statement_digest_text( 'select 1, 2, 3' ) AS digest;
SHOW CREATE TABLE t1;
DROP TABLE t1;
SELECT statement_digest_text( 'SELECT 1' );
