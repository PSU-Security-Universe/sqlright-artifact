set optimizer_switch='index_condition_pushdown=on,mrr=on,mrr_cost_based=off';
drop table if exists t1,t2,t3,t4,t11;
CREATE TABLE t1 ( Period smallint(4) unsigned zerofill DEFAULT '0000' NOT NULL, Varor_period smallint(4) unsigned DEFAULT '0' NOT NULL );
INSERT INTO t1 VALUES (9410,9412);
