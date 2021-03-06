CREATE TABLE DATE_TBL (f1 date);
INSERT INTO DATE_TBL VALUES ('1957-04-09');
INSERT INTO DATE_TBL VALUES ('1957-06-13');
INSERT INTO DATE_TBL VALUES ('1996-02-28');
INSERT INTO DATE_TBL VALUES ('1996-02-29');
INSERT INTO DATE_TBL VALUES ('1996-03-01');
INSERT INTO DATE_TBL VALUES ('1996-03-02');
INSERT INTO DATE_TBL VALUES ('1997-02-28');
INSERT INTO DATE_TBL VALUES ('1997-02-29');
INSERT INTO DATE_TBL VALUES ('1997-03-01');
INSERT INTO DATE_TBL VALUES ('1997-03-02');
INSERT INTO DATE_TBL VALUES ('2000-04-01');
INSERT INTO DATE_TBL VALUES ('2000-04-02');
INSERT INTO DATE_TBL VALUES ('2000-04-03');
INSERT INTO DATE_TBL VALUES ('2038-04-08');
INSERT INTO DATE_TBL VALUES ('2039-04-09');
INSERT INTO DATE_TBL VALUES ('2040-04-10');
SELECT f1 AS "Fifteen" FROM DATE_TBL;
SELECT f1 AS "Nine" FROM DATE_TBL WHERE f1 < '2000-01-01';
SELECT f1 AS "Three" FROM DATE_TBL  WHERE f1 BETWEEN '2000-01-01' AND '2001-01-01';
SET datestyle TO iso;
  SET datestyle TO ymd;
  SET datestyle TO ymd;
SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';
SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';
SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';
SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';
SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';
SET datestyle TO dmy;
SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';
SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';
SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';
SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';
SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';
SET datestyle TO mdy;
SELECT date 'January 8, 1999';
SELECT date '1999-01-08';
SELECT date '1999-01-18';
SELECT date '1/8/1999';
SELECT date '1/18/1999';
SELECT date '18/1/1999';
SELECT date '01/02/03';
SELECT date '19990108';
SELECT date '990108';
SELECT date '1999.008';
SELECT date 'J2451187';
SELECT date 'January 8, 99 BC';
SELECT date '99-Jan-08';
SELECT date '1999-Jan-08';
SELECT date '08-Jan-99';
SELECT date '08-Jan-1999';
SELECT date 'Jan-08-99';
SELECT date 'Jan-08-1999';
SELECT date '99-08-Jan';
SELECT date '1999-08-Jan';
SELECT date '99 Jan 08';
SELECT date '1999 Jan 08';
SELECT date '08 Jan 99';
SELECT date '08 Jan 1999';
SELECT date 'Jan 08 99';
SELECT date 'Jan 08 1999';
SELECT date '99 08 Jan';
SELECT date '1999 08 Jan';
SELECT date '99-01-08';
SELECT date '1999-01-08';
SELECT date '08-01-99';
SELECT date '08-01-1999';
SELECT date '01-08-99';
SELECT date '01-08-1999';
SELECT date '99-08-01';
SELECT date '1999-08-01';
SELECT date '99 01 08';
SELECT date '1999 01 08';
SELECT date '08 01 99';
SELECT date '08 01 1999';
SELECT date '01 08 99';
SELECT date '01 08 1999';
SELECT date '99 08 01';
SELECT date '1999 08 01';
SELECT date '4714-11-24 BC';
SELECT date '4714-11-23 BC';
  SELECT date '5874897-12-31';
  SELECT date '5874897-12-31';
SELECT date '5874898-01-01';
  RESET datestyle;
  RESET datestyle;
SELECT f1 - date '2000-01-01' AS "Days From 2K" FROM DATE_TBL;
SELECT f1 - date 'epoch' AS "Days From Epoch" FROM DATE_TBL;
SELECT date 'yesterday' - date 'today' AS "One day";
SELECT date 'today' - date 'tomorrow' AS "One day";
SELECT date 'yesterday' - date 'tomorrow' AS "Two days";
SELECT date 'tomorrow' - date 'today' AS "One day";
SELECT date 'today' - date 'yesterday' AS "One day";
SELECT date 'tomorrow' - date 'yesterday' AS "Two days";
select 'infinity'::date > 'today'::date as t;
select '-infinity'::date < 'today'::date as t;
select isfinite('infinity'::date), isfinite('-infinity'::date), isfinite('today'::date);
select make_date(-44, 3, 15);
select make_time(8, 20, 0.0);
select make_date(2013, 2, 30);
select make_date(2013, 13, 1);
select make_date(2013, 11, -1);
select make_time(10, 55, 100.1);
select make_time(24, 0, 2.1);
