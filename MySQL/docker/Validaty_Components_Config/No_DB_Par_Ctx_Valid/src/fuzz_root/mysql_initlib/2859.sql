SELECT LPAD(NULL, 5, 'x') AS result;
SELECT LPAD(NULL, NULL, 'x') AS result;
SELECT LPAD(NULL, NULL, NULL) AS result;
SELECT LPAD('a', NULL, 'x') AS result;
SELECT LPAD('a', NULL, NULL) AS result;
SELECT LPAD('a', 5, NULL) AS result;
SELECT LPAD(NULL, 5, NULL) AS result;
SELECT LPAD('a', 0, 'x') AS result;
SELECT LPAD('a', 0, '') AS result;
SELECT LPAD('', 0, 'x') AS result;
SELECT LPAD('', 0, '') AS result;
SELECT LPAD('a', -1, 'x');
SELECT LPAD('a', -9223372036854775808, 'x');
SELECT LPAD('a', -9223372036854775809, 'x');
SELECT LPAD('a', 9223372036854775807, 'x');
SELECT LPAD('a', 9223372036854775808, 'x');
SELECT LPAD('a', 18446744073709551615, 'x');
SELECT LPAD('a', 18446744073709551616, 'x');
SELECT LPAD('a', 5, '') AS result;
SELECT LPAD('a', 5, '') AS result;
SELECT LPAD('12345', 5, 'x');
SELECT LPAD('123456787890', 1, 'x');
SELECT LPAD('123456787890', 5, 'x');
SELECT LPAD('123', 5, 'x');
SELECT LPAD('a', 5, 'xy');