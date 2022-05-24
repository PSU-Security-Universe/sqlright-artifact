CREATE TEMP TABLE articles (    id int CONSTRAINT articles_pkey PRIMARY KEY,    keywords text,    title text UNIQUE NOT NULL,    body text UNIQUE,    created date);
CREATE TEMP TABLE articles_in_category (    article_id int,    category_id int,    changed date,    PRIMARY KEY (article_id, category_id));
SELECT id, keywords, title, body, createdFROM articlesGROUP BY id;
SELECT id, keywords, title, body, createdFROM articlesGROUP BY title;
SELECT id, keywords, title, body, createdFROM articlesGROUP BY body;
SELECT id, keywords, title, body, createdFROM articlesGROUP BY keywords;
SELECT a.id, a.keywords, a.title, a.body, a.createdFROM articles AS a, articles_in_category AS aicWHERE a.id = aic.article_id AND aic.category_id in (14,62,70,53,138)GROUP BY a.id;
SELECT a.id, a.keywords, a.title, a.body, a.createdFROM articles AS a, articles_in_category AS aicWHERE a.id = aic.article_id AND aic.category_id in (14,62,70,53,138)GROUP BY aic.article_id, aic.category_id;
SELECT a.id, a.keywords, a.title, a.body, a.createdFROM articles AS a JOIN articles_in_category AS aic ON a.id = aic.article_idWHERE aic.category_id in (14,62,70,53,138)GROUP BY a.id;
SELECT a.id, a.keywords, a.title, a.body, a.createdFROM articles AS a JOIN articles_in_category AS aic ON a.id = aic.article_idWHERE aic.category_id in (14,62,70,53,138)GROUP BY aic.article_id, aic.category_id;
SELECT aic.changedFROM articles AS a JOIN articles_in_category AS aic ON a.id = aic.article_idWHERE aic.category_id in (14,62,70,53,138)GROUP BY aic.category_id, aic.article_id;
SELECT aic.changedFROM articles AS a JOIN articles_in_category AS aic ON a.id = aic.article_idWHERE aic.category_id in (14,62,70,53,138)GROUP BY aic.article_id;
CREATE TEMP TABLE products (product_id int, name text, price numeric);
CREATE TEMP TABLE sales (product_id int, units int);
SELECT product_id, p.name, (sum(s.units) * p.price) AS sales    FROM products p LEFT JOIN sales s USING (product_id)    GROUP BY product_id, p.name, p.price;
SELECT product_id, p.name, (sum(s.units) * p.price) AS sales    FROM products p LEFT JOIN sales s USING (product_id)    GROUP BY product_id;
ALTER TABLE products ADD PRIMARY KEY (product_id);
SELECT product_id, p.name, (sum(s.units) * p.price) AS sales    FROM products p LEFT JOIN sales s USING (product_id)    GROUP BY product_id;
CREATE TEMP TABLE node (    nid SERIAL,    vid integer NOT NULL default '0',    type varchar(32) NOT NULL default '',    title varchar(128) NOT NULL default '',    uid integer NOT NULL default '0',    status integer NOT NULL default '1',    created integer NOT NULL default '0',        PRIMARY KEY (nid, vid));
CREATE TEMP TABLE users (    uid integer NOT NULL default '0',    name varchar(60) NOT NULL default '',    pass varchar(32) NOT NULL default '',        PRIMARY KEY (uid),    UNIQUE (name));
SELECT u.uid, u.name FROM node nINNER JOIN users u ON u.uid = n.uidWHERE n.type = 'blog' AND n.status = 1GROUP BY u.uid, u.name;
SELECT u.uid, u.name FROM node nINNER JOIN users u ON u.uid = n.uidWHERE n.type = 'blog' AND n.status = 1GROUP BY u.uid;
CREATE TEMP VIEW fdv1 ASSELECT id, keywords, title, body, createdFROM articlesGROUP BY body;
CREATE TEMP VIEW fdv1 ASSELECT id, keywords, title, body, createdFROM articlesGROUP BY id;
ALTER TABLE articles DROP CONSTRAINT articles_pkey RESTRICT;
DROP VIEW fdv1;
CREATE TEMP VIEW fdv2 ASSELECT a.id, a.keywords, a.title, aic.category_id, aic.changedFROM articles AS a JOIN articles_in_category AS aic ON a.id = aic.article_idWHERE aic.category_id in (14,62,70,53,138)GROUP BY a.id, aic.category_id, aic.article_id;
ALTER TABLE articles DROP CONSTRAINT articles_pkey RESTRICT;
 ALTER TABLE articles_in_category DROP CONSTRAINT articles_in_category_pkey RESTRICT;
 DROP VIEW fdv2;
 DROP VIEW fdv2;
CREATE TEMP VIEW fdv3 ASSELECT id, keywords, title, body, createdFROM articlesGROUP BY idUNIONSELECT id, keywords, title, body, createdFROM articlesGROUP BY id;
ALTER TABLE articles DROP CONSTRAINT articles_pkey RESTRICT;
 DROP VIEW fdv3;
 DROP VIEW fdv3;
CREATE TEMP VIEW fdv4 ASSELECT * FROM articles WHERE title IN (SELECT title FROM articles GROUP BY id);
ALTER TABLE articles DROP CONSTRAINT articles_pkey RESTRICT;
 DROP VIEW fdv4;
 DROP VIEW fdv4;
PREPARE foo AS  SELECT id, keywords, title, body, created  FROM articles  GROUP BY id;
EXECUTE foo;
ALTER TABLE articles DROP CONSTRAINT articles_pkey RESTRICT;
