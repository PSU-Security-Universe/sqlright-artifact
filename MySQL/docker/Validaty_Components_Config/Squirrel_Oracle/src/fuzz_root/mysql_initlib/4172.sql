set optimizer_switch='semijoin=on,materialization=on,firstmatch=on,loosescan=on,index_condition_pushdown=on,mrr=on,mrr_cost_based=off';
drop table if exists t1,t2,t3,t4,t11;
drop table if exists t1_1,t1_2,t9_1,t9_2,t1aa,t2aa;
drop view if exists v1;
CREATE TABLE t1 ( Period smallint(4) unsigned zerofill DEFAULT '0000' NOT NULL, Varor_period smallint(4) unsigned DEFAULT '0' NOT NULL );
INSERT INTO t1 VALUES (9410,9412);
select period from t1;
select * from t1;
select t1.* from t1;
CREATE TABLE t2 ( auto int not null auto_increment, fld1 int(6) unsigned zerofill DEFAULT '000000' NOT NULL, companynr tinyint(2) unsigned zerofill DEFAULT '00' NOT NULL, fld3 char(30) DEFAULT '' NOT NULL, fld4 char(35) DEFAULT '' NOT NULL, fld5 char(35) DEFAULT '' NOT NULL, fld6 char(4) DEFAULT '' NOT NULL, UNIQUE fld1 (fld1), KEY fld3 (fld3), PRIMARY KEY (auto) ) charset utf8mb4;
INSERT INTO t2 VALUES (1,000001,00,'Omaha','teethe','neat','');
INSERT INTO t2 VALUES (2,011401,37,'breaking','dreaded','Steinberg','W');
INSERT INTO t2 VALUES (3,011402,37,'Romans','scholastics','jarring','');
INSERT INTO t2 VALUES (4,011403,37,'intercepted','audiology','tinily','');
INSERT INTO t2 VALUES (5,011501,37,'bewilderingly','wallet','balled','');
INSERT INTO t2 VALUES (6,011701,37,'astound','parters','persist','W');
INSERT INTO t2 VALUES (7,011702,37,'admonishing','eschew','attainments','');
INSERT INTO t2 VALUES (8,011703,37,'sumac','quitter','fanatic','');
INSERT INTO t2 VALUES (9,012001,37,'flanking','neat','measures','FAS');
INSERT INTO t2 VALUES (10,012003,37,'combed','Steinberg','rightfulness','');
INSERT INTO t2 VALUES (11,012004,37,'subjective','jarring','capably','');
INSERT INTO t2 VALUES (12,012005,37,'scatterbrain','tinily','impulsive','');
INSERT INTO t2 VALUES (13,012301,37,'Eulerian','balled','starlet','');
INSERT INTO t2 VALUES (14,012302,36,'dubbed','persist','terminators','');
INSERT INTO t2 VALUES (15,012303,37,'Kane','attainments','untying','');
INSERT INTO t2 VALUES (16,012304,37,'overlay','fanatic','announces','FAS');
INSERT INTO t2 VALUES (17,012305,37,'perturb','measures','featherweight','FAS');
INSERT INTO t2 VALUES (18,012306,37,'goblins','rightfulness','pessimist','FAS');
INSERT INTO t2 VALUES (19,012501,37,'annihilates','capably','daughter','');
INSERT INTO t2 VALUES (20,012602,37,'Wotan','impulsive','decliner','FAS');
INSERT INTO t2 VALUES (21,012603,37,'snatching','starlet','lawgiver','');
INSERT INTO t2 VALUES (22,012604,37,'concludes','terminators','stated','');
INSERT INTO t2 VALUES (23,012605,37,'laterally','untying','readable','');
INSERT INTO t2 VALUES (24,012606,37,'yelped','announces','attrition','');
INSERT INTO t2 VALUES (25,012701,37,'grazing','featherweight','cascade','FAS');
INSERT INTO t2 VALUES (26,012702,37,'Baird','pessimist','motors','FAS');
INSERT INTO t2 VALUES (27,012703,37,'celery','daughter','interrogate','');
INSERT INTO t2 VALUES (28,012704,37,'misunderstander','decliner','pests','W');
INSERT INTO t2 VALUES (29,013601,37,'handgun','lawgiver','stairway','');
INSERT INTO t2 VALUES (30,013602,37,'foldout','stated','dopers','FAS');
INSERT INTO t2 VALUES (31,013603,37,'mystic','readable','testicle','W');
INSERT INTO t2 VALUES (32,013604,37,'succumbed','attrition','Parsifal','W');
INSERT INTO t2 VALUES (33,013605,37,'Nabisco','cascade','leavings','');
INSERT INTO t2 VALUES (34,013606,37,'fingerings','motors','postulation','W');
INSERT INTO t2 VALUES (35,013607,37,'aging','interrogate','squeaking','');
INSERT INTO t2 VALUES (36,013608,37,'afield','pests','contrasted','');
INSERT INTO t2 VALUES (37,013609,37,'ammonium','stairway','leftover','');
INSERT INTO t2 VALUES (38,013610,37,'boat','dopers','whiteners','');
INSERT INTO t2 VALUES (39,013801,37,'intelligibility','testicle','erases','W');
INSERT INTO t2 VALUES (40,013802,37,'Augustine','Parsifal','Punjab','W');
INSERT INTO t2 VALUES (41,013803,37,'teethe','leavings','Merritt','');
INSERT INTO t2 VALUES (42,013804,37,'dreaded','postulation','Quixotism','');
INSERT INTO t2 VALUES (43,013901,37,'scholastics','squeaking','sweetish','FAS');
INSERT INTO t2 VALUES (44,016001,37,'audiology','contrasted','dogging','FAS');
INSERT INTO t2 VALUES (45,016201,37,'wallet','leftover','scornfully','FAS');
INSERT INTO t2 VALUES (46,016202,37,'parters','whiteners','bellow','');
INSERT INTO t2 VALUES (47,016301,37,'eschew','erases','bills','');
INSERT INTO t2 VALUES (48,016302,37,'quitter','Punjab','cupboard','FAS');
INSERT INTO t2 VALUES (49,016303,37,'neat','Merritt','sureties','FAS');
INSERT INTO t2 VALUES (50,016304,37,'Steinberg','Quixotism','puddings','');
INSERT INTO t2 VALUES (51,018001,37,'jarring','sweetish','tapestry','');
INSERT INTO t2 VALUES (52,018002,37,'tinily','dogging','fetters','');
INSERT INTO t2 VALUES (53,018003,37,'balled','scornfully','bivalves','');
INSERT INTO t2 VALUES (54,018004,37,'persist','bellow','incurring','');
INSERT INTO t2 VALUES (55,018005,37,'attainments','bills','Adolph','');
INSERT INTO t2 VALUES (56,018007,37,'fanatic','cupboard','pithed','');
INSERT INTO t2 VALUES (57,018008,37,'measures','sureties','emergency','');
INSERT INTO t2 VALUES (58,018009,37,'rightfulness','puddings','Miles','');
INSERT INTO t2 VALUES (59,018010,37,'capably','tapestry','trimmings','');
INSERT INTO t2 VALUES (60,018012,37,'impulsive','fetters','tragedies','W');
INSERT INTO t2 VALUES (61,018013,37,'starlet','bivalves','skulking','W');
INSERT INTO t2 VALUES (62,018014,37,'terminators','incurring','flint','');
INSERT INTO t2 VALUES (63,018015,37,'untying','Adolph','flopping','W');
INSERT INTO t2 VALUES (64,018016,37,'announces','pithed','relaxing','FAS');
INSERT INTO t2 VALUES (65,018017,37,'featherweight','emergency','offload','FAS');
INSERT INTO t2 VALUES (66,018018,37,'pessimist','Miles','suites','W');
INSERT INTO t2 VALUES (67,018019,37,'daughter','trimmings','lists','FAS');
INSERT INTO t2 VALUES (68,018020,37,'decliner','tragedies','animized','FAS');
INSERT INTO t2 VALUES (69,018021,37,'lawgiver','skulking','multilayer','W');
INSERT INTO t2 VALUES (70,018022,37,'stated','flint','standardizes','FAS');
INSERT INTO t2 VALUES (71,018023,37,'readable','flopping','Judas','');
INSERT INTO t2 VALUES (72,018024,37,'attrition','relaxing','vacuuming','W');
INSERT INTO t2 VALUES (73,018025,37,'cascade','offload','dentally','W');
INSERT INTO t2 VALUES (74,018026,37,'motors','suites','humanness','W');
INSERT INTO t2 VALUES (75,018027,37,'interrogate','lists','inch','W');
INSERT INTO t2 VALUES (76,018028,37,'pests','animized','Weissmuller','W');
INSERT INTO t2 VALUES (77,018029,37,'stairway','multilayer','irresponsibly','W');
INSERT INTO t2 VALUES (78,018030,37,'dopers','standardizes','luckily','FAS');
INSERT INTO t2 VALUES (79,018032,37,'testicle','Judas','culled','W');
INSERT INTO t2 VALUES (80,018033,37,'Parsifal','vacuuming','medical','FAS');
INSERT INTO t2 VALUES (81,018034,37,'leavings','dentally','bloodbath','FAS');
INSERT INTO t2 VALUES (82,018035,37,'postulation','humanness','subschema','W');
INSERT INTO t2 VALUES (83,018036,37,'squeaking','inch','animals','W');
INSERT INTO t2 VALUES (84,018037,37,'contrasted','Weissmuller','Micronesia','');
INSERT INTO t2 VALUES (85,018038,37,'leftover','irresponsibly','repetitions','');
INSERT INTO t2 VALUES (86,018039,37,'whiteners','luckily','Antares','');
INSERT INTO t2 VALUES (87,018040,37,'erases','culled','ventilate','W');
INSERT INTO t2 VALUES (88,018041,37,'Punjab','medical','pityingly','');
INSERT INTO t2 VALUES (89,018042,37,'Merritt','bloodbath','interdependent','');
INSERT INTO t2 VALUES (90,018043,37,'Quixotism','subschema','Graves','FAS');
INSERT INTO t2 VALUES (91,018044,37,'sweetish','animals','neonatal','');
INSERT INTO t2 VALUES (92,018045,37,'dogging','Micronesia','scribbled','FAS');
INSERT INTO t2 VALUES (93,018046,37,'scornfully','repetitions','chafe','W');
INSERT INTO t2 VALUES (94,018048,37,'bellow','Antares','honoring','');
INSERT INTO t2 VALUES (95,018049,37,'bills','ventilate','realtor','');
INSERT INTO t2 VALUES (96,018050,37,'cupboard','pityingly','elite','');
INSERT INTO t2 VALUES (97,018051,37,'sureties','interdependent','funereal','');
INSERT INTO t2 VALUES (98,018052,37,'puddings','Graves','abrogating','');
INSERT INTO t2 VALUES (99,018053,50,'tapestry','neonatal','sorters','');
INSERT INTO t2 VALUES (100,018054,37,'fetters','scribbled','Conley','');
INSERT INTO t2 VALUES (101,018055,37,'bivalves','chafe','lectured','');
INSERT INTO t2 VALUES (102,018056,37,'incurring','honoring','Abraham','');
INSERT INTO t2 VALUES (103,018057,37,'Adolph','realtor','Hawaii','W');
INSERT INTO t2 VALUES (104,018058,37,'pithed','elite','cage','');
INSERT INTO t2 VALUES (105,018059,36,'emergency','funereal','hushes','');
INSERT INTO t2 VALUES (106,018060,37,'Miles','abrogating','Simla','');
INSERT INTO t2 VALUES (107,018061,37,'trimmings','sorters','reporters','');
INSERT INTO t2 VALUES (108,018101,37,'tragedies','Conley','Dutchman','FAS');
INSERT INTO t2 VALUES (109,018102,37,'skulking','lectured','descendants','FAS');
INSERT INTO t2 VALUES (110,018103,37,'flint','Abraham','groupings','FAS');
INSERT INTO t2 VALUES (111,018104,37,'flopping','Hawaii','dissociate','');
INSERT INTO t2 VALUES (112,018201,37,'relaxing','cage','coexist','W');
