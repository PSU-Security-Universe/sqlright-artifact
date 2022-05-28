set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t1 ( event_date date DEFAULT '0000-00-00' NOT NULL, type int(11) DEFAULT '0' NOT NULL, event_id int(11) DEFAULT '0' NOT NULL, PRIMARY KEY (event_date,type,event_id) );
ANALYZE TABLE t1;
check table t1;
repair table t1;
INSERT INTO t1 VALUES (1,0,0), (3,1,1), (4,1,1), (8,2,2), (9,2,2), (17,3,2), (22,4,2), (24,4,2), (28,5,2), (29,5,2), (30,5,2), (31,6,2), (32,6,2), (33,6,2), (203,7,2), (202,7,2), (20,3,2), (157,0,0), (193,5,2), (40,7,2), (2,1,1), (15,2,2), (6,1,1), (34,6,2), (35,6,2), (16,3,2), (7,1,1), (36,7,2), (18,3,2), (26,5,2), (27,5,2), (183,4,2), (38,7,2), (25,5,2), (37,7,2), (21,4,2), (19,3,2), (5,1,1), (179,5,2);
create table t1( Satellite		varchar(25)	not null, SensorMode		varchar(25)	not null, FullImageCornersUpperLeftLongitude	double	not null, FullImageCornersUpperRightLongitude	double	not null, FullImageCornersUpperRightLatitude	double	not null, FullImageCornersLowerRightLatitude	double	not null, index two (Satellite, SensorMode, FullImageCornersUpperLeftLongitude, FullImageCornersUpperRightLongitude, FullImageCornersUpperRightLatitude, FullImageCornersLowerRightLatitude));
insert into t1 values("OV-3","PAN1",91,-92,40,50);
update t1 set y=x;
analyze table t1;
delete from t2;
