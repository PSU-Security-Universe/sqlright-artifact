drop table if exists t1,t2,t3;
set time_zone="+03:00";
select from_days(to_days("960101")),to_days(960201)-to_days("19960101"),to_days(date_add(curdate(), interval 1 day))-to_days(curdate()),weekday("1997-11-29");
select period_add("9602",-12),period_diff(199505,"9404") ;
select now()-now(),weekday(curdate())-weekday(now()),unix_timestamp()-unix_timestamp(now());
select from_unixtime(unix_timestamp("1994-03-02 10:11:12")),from_unixtime(unix_timestamp("1994-03-02 10:11:12"),"%Y-%m-%d %h:%i:%s"),from_unixtime(unix_timestamp("1994-03-02 10:11:12"))+0;
select sec_to_time(9001),sec_to_time(9001)+0,time_to_sec("15:12:22"), sec_to_time(time_to_sec("0:30:47")/6.21);
select sec_to_time(time_to_sec('-838:59:59'));
select now()-curdate()*1000000-curtime();
select strcmp(current_timestamp(),concat(current_date()," ",current_time()));
select strcmp(localtime(),concat(current_date()," ",current_time()));
select strcmp(localtimestamp(),concat(current_date()," ",current_time()));
select date_format("1997-01-02 03:04:05", "%M %W %D %Y %y %m %d %h %i %s %w");
select date_format("1997-01-02", concat("%M %W %D ","%Y %y %m %d %h %i %s %w"));
select dayofmonth("1997-01-02"),dayofmonth(19970323);
select month("1997-01-02"),year("98-02-03"),dayofyear("1997-12-31");
select month("2001-02-00"),year("2001-00-00");
select DAYOFYEAR("1997-03-03"), WEEK("1998-03-03"), QUARTER(980303);
select HOUR("1997-03-03 23:03:22"), MINUTE("23:03:22"), SECOND(230322);
select week(19980101),week(19970101),week(19980101,1),week(19970101,1);
select week(19981231),week(19971231),week(19981231,1),week(19971231,1);
select week(19950101),week(19950101,1);
select yearweek('1981-12-31',1),yearweek('1982-01-01',1),yearweek('1982-12-31',1),yearweek('1983-01-01',1);
select yearweek('1987-01-01',1),yearweek('1987-01-01');
select week("2000-01-01",0) as '2000', week("2001-01-01",0) as '2001', week("2002-01-01",0) as '2002',week("2003-01-01",0) as '2003', week("2004-01-01",0) as '2004', week("2005-01-01",0) as '2005', week("2006-01-01",0) as '2006';
select week("2000-01-06",0) as '2000', week("2001-01-06",0) as '2001', week("2002-01-06",0) as '2002',week("2003-01-06",0) as '2003', week("2004-01-06",0) as '2004', week("2005-01-06",0) as '2005', week("2006-01-06",0) as '2006';
select week("2000-01-01",1) as '2000', week("2001-01-01",1) as '2001', week("2002-01-01",1) as '2002',week("2003-01-01",1) as '2003', week("2004-01-01",1) as '2004', week("2005-01-01",1) as '2005', week("2006-01-01",1) as '2006';
select week("2000-01-06",1) as '2000', week("2001-01-06",1) as '2001', week("2002-01-06",1) as '2002',week("2003-01-06",1) as '2003', week("2004-01-06",1) as '2004', week("2005-01-06",1) as '2005', week("2006-01-06",1) as '2006';
select yearweek("2000-01-01",0) as '2000', yearweek("2001-01-01",0) as '2001', yearweek("2002-01-01",0) as '2002',yearweek("2003-01-01",0) as '2003', yearweek("2004-01-01",0) as '2004', yearweek("2005-01-01",0) as '2005', yearweek("2006-01-01",0) as '2006';
select yearweek("2000-01-06",0) as '2000', yearweek("2001-01-06",0) as '2001', yearweek("2002-01-06",0) as '2002',yearweek("2003-01-06",0) as '2003', yearweek("2004-01-06",0) as '2004', yearweek("2005-01-06",0) as '2005', yearweek("2006-01-06",0) as '2006';
select yearweek("2000-01-01",1) as '2000', yearweek("2001-01-01",1) as '2001', yearweek("2002-01-01",1) as '2002',yearweek("2003-01-01",1) as '2003', yearweek("2004-01-01",1) as '2004', yearweek("2005-01-01",1) as '2005', yearweek("2006-01-01",1) as '2006';
select yearweek("2000-01-06",1) as '2000', yearweek("2001-01-06",1) as '2001', yearweek("2002-01-06",1) as '2002',yearweek("2003-01-06",1) as '2003', yearweek("2004-01-06",1) as '2004', yearweek("2005-01-06",1) as '2005', yearweek("2006-01-06",1) as '2006';
select week(19981231,2), week(19981231,3), week(20000101,2), week(20000101,3);
select week(20001231,2),week(20001231,3);
select week(19981231,0) as '0', week(19981231,1) as '1', week(19981231,2) as '2', week(19981231,3) as '3', week(19981231,4) as '4', week(19981231,5) as '5', week(19981231,6) as '6', week(19981231,7) as '7';
select week(20000101,0) as '0', week(20000101,1) as '1', week(20000101,2) as '2', week(20000101,3) as '3', week(20000101,4) as '4', week(20000101,5) as '5', week(20000101,6) as '6', week(20000101,7) as '7';
select week(20000106,0) as '0', week(20000106,1) as '1', week(20000106,2) as '2', week(20000106,3) as '3', week(20000106,4) as '4', week(20000106,5) as '5', week(20000106,6) as '6', week(20000106,7) as '7';
select week(20001231,0) as '0', week(20001231,1) as '1', week(20001231,2) as '2', week(20001231,3) as '3', week(20001231,4) as '4', week(20001231,5) as '5', week(20001231,6) as '6', week(20001231,7) as '7';
select week(20010101,0) as '0', week(20010101,1) as '1', week(20010101,2) as '2', week(20010101,3) as '3', week(20010101,4) as '4', week(20010101,5) as '5', week(20010101,6) as '6', week(20010101,7) as '7';
select yearweek(20001231,0), yearweek(20001231,1), yearweek(20001231,2), yearweek(20001231,3), yearweek(20001231,4), yearweek(20001231,5), yearweek(20001231,6), yearweek(20001231,7);
set default_week_format = 6;
select week(20001231), week(20001231,6);
set default_week_format = 0;
set default_week_format = 2;
select week(20001231),week(20001231,2),week(20001231,0);
set default_week_format = 0;
select date_format('1998-12-31','%x-%v'),date_format('1999-01-01','%x-%v');
select date_format('1999-12-31','%x-%v'),date_format('2000-01-01','%x-%v');
select dayname("1962-03-03"),dayname("1962-03-03")+0;
select monthname("1972-03-04"),monthname("1972-03-04")+0;
select time_format(19980131000000,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131010203,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131131415,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select time_format(19980131010015,'%H|%I|%k|%l|%i|%p|%r|%S|%T');
select date_format(concat('19980131',131415),'%H|%I|%k|%l|%i|%p|%r|%S|%T| %M|%W|%D|%Y|%y|%a|%b|%j|%m|%d|%h|%s|%w');
select date_format(19980021000000,'%H|%I|%k|%l|%i|%p|%r|%S|%T| %M|%W|%D|%Y|%y|%a|%b|%j|%m|%d|%h|%s|%w');
select date_add("1997-12-31 23:59:59",INTERVAL 1 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL 1 MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL 1 HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL 1 DAY);
select date_add("1997-12-31 23:59:59",INTERVAL 1 MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL 1 YEAR);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" MINUTE_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" HOUR_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1" DAY_HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1" YEAR_MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL "1:1:1" HOUR_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1:1" DAY_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "1 1:1:1" DAY_SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 HOUR);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 DAY);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 MONTH);
select date_sub("1998-01-01 00:00:00",INTERVAL 1 YEAR);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" MINUTE_SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" HOUR_MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1" DAY_HOUR);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1" YEAR_MONTH);
select date_sub("1998-01-01 00:00:00",INTERVAL "1:1:1" HOUR_SECOND);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1:1" DAY_MINUTE);
select date_sub("1998-01-01 00:00:00",INTERVAL "1 1:1:1" DAY_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL 100000 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL 100000 HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 DAY);
select date_add("1997-12-31 23:59:59",INTERVAL 100000 MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL -100000 YEAR);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:1" MINUTE_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL "-10000:1" HOUR_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:1" DAY_HOUR);
select date_add("1997-12-31 23:59:59",INTERVAL "-100 1" YEAR_MONTH);
select date_add("1997-12-31 23:59:59",INTERVAL "10000:99:99" HOUR_SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL " -10000 99:99" DAY_MINUTE);
select date_add("1997-12-31 23:59:59",INTERVAL "10000 99:99:99" DAY_SECOND);
select "1997-12-31 23:59:59" + INTERVAL 1 SECOND;
select INTERVAL 1 DAY + "1997-12-31";
select "1998-01-01 00:00:00" - INTERVAL 1 SECOND;
select date_sub("1998-01-02",INTERVAL 31 DAY);
select date_add("1997-12-31",INTERVAL 1 SECOND);
select date_add("1997-12-31",INTERVAL 1 DAY);
select date_add(NULL,INTERVAL 100000 SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL NULL SECOND);
select date_add("1997-12-31 23:59:59",INTERVAL NULL MINUTE_SECOND);
select date_add("9999-12-31 23:59:59",INTERVAL 1 SECOND);
select date_sub("0000-00-00 00:00:00",INTERVAL 1 SECOND);
select date_add('1998-01-30',Interval 1 month);
select date_add('1998-01-30',Interval '2:1' year_month);
select date_add('1996-02-29',Interval '1' year);
select extract(YEAR FROM "1999-01-02 10:11:12");
select extract(YEAR_MONTH FROM "1999-01-02");
select extract(DAY FROM "1999-01-02");
select extract(DAY_HOUR FROM "1999-01-02 10:11:12");
select extract(DAY_MINUTE FROM "02 10:11:12");
select extract(DAY_SECOND FROM "225 10:11:12");
select extract(HOUR FROM "1999-01-02 10:11:12");
select extract(HOUR_MINUTE FROM "10:11:12");
select extract(HOUR_SECOND FROM "10:11:12");
select extract(MINUTE FROM "10:11:12");
select extract(MINUTE_SECOND FROM "10:11:12");
select extract(SECOND FROM "1999-01-02 10:11:12");
select extract(MONTH FROM "2001-02-00");