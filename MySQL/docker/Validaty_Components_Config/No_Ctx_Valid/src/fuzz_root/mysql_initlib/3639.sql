SELECT JSON_TYPE('["Mercury", "Venus", "Earth", "Mars" ]');
SELECT JSON_TYPE('[ ["Afghanistan", "Bangladesh", "Cambodia"], ["Albania", "Belgium", "Cyprus"], ["Argentina", "Bolivia", "Colombia"], ["Angola", "Burundi", "Cameroon"] ]');
SELECT JSON_TYPE('["Afghanistan", "Bangladesh", "Cambodia"]');
SELECT JSON_TYPE('["Albania", "Belgium", "Cyprus"]');
SELECT JSON_TYPE('["Argentina", "Bolivia", "Colombia"]');
SELECT JSON_TYPE('["Angola", "Burundi", "Cameroon"]');
SELECT JSON_TYPE('{ "name": "Madagascar", "capital": "Antananarivo" }');
SELECT JSON_TYPE('{ "name": "Iceland", "capital": "Reykjavik" }');
SELECT JSON_TYPE('[ { "author": "Kerstin Ekman", "title": "Grand final i skojarbranschen"   }, { "author": "Bjarne Stroustrup", "title": "The C++ Programming Language"   }, { "author": "Pelle Holmberg and Hans Marklund", "title": "Nya svampboken"   } ]');
SELECT JSON_TYPE('{"title": "Grand final i skojarbranschen", "author": "Kerstin Ekman"}');
SELECT JSON_TYPE('{"title": "The C++ Programming Language", "author": "Bjarne Stroustrup"}');
SELECT JSON_TYPE('{"title": "Nya svampboken", "author": "Pelle Holmberg and Hans Marklund"}');
SELECT JSON_TYPE('[ { "name": "Apple", "fruit_color": "red", "flower_color": "white"   }, { "name": "Tussilago", "flower_color": "yellow"   }, { "name": "Chanterelle", "fruit_color": "yellow"   } ]');
SELECT JSON_TYPE('{"name": "Apple", "fruit_color": "red", "flower_color": "white"}');
SELECT JSON_TYPE('{"name": "Tussilago", "flower_color": "yellow"}');
SELECT JSON_TYPE('{"name": "Chanterelle", "fruit_color": "yellow"}');
SELECT JSON_TYPE('[ { "species": "ant", "color": "brown", "legs": 6 }, { "species": "bear", "color": "black" }, { "species": "cat", "color": "orange" } ]');
SELECT JSON_TYPE('{"legs": 6, "color": "brown", "species": "ant"}');
SELECT JSON_TYPE('{"color": "black", "species": "bear"}');
SELECT JSON_TYPE('{"color": "orange", "species": "cat"}');
SELECT JSON_TYPE('{ "first": "Ain\'t Talkin\'", "second": "Don\'t Think Twice, It\'s All Right", "third": "It Ain\'t Me, Babe", "fourth": "Rollin\' and Tumblin\'", "fifth": "Where are you?" }');
SELECT JSON_TYPE('["artichoke", "broccoli", "cauliflower", "durian"]');
SELECT JSON_TYPE('["artichoke", "broccoli", "cauliflower", "durian"]');
SELECT JSON_TYPE('["artichoke", "broccoli", "cauliflower", "durian"]');
