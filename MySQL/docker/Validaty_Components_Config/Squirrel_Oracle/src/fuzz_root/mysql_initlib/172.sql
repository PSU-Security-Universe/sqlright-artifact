SELECT @@global.validate_password_check_user_name;
SET @@session.validate_password_check_user_name= ON;
SET validate_password_check_user_name= ON;
SET @@global.validate_password_policy=LOW;
SET @@global.validate_password_mixed_case_count=0;
SET @@global.validate_password_number_count=0;
SET @@global.validate_password_special_char_count=0;
SET @@global.validate_password_length=0;
SET @@global.validate_password_check_user_name= ON;
SELECT VALIDATE_PASSWORD_STRENGTH('toor') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('Root') <> 0;
SELECT VALIDATE_PASSWORD_STRENGTH('Toor') <> 0;
SELECT VALIDATE_PASSWORD_STRENGTH('fooHoHo%1') <> 0;
SELECT VALIDATE_PASSWORD_STRENGTH('base_user') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('resu_esab') = 0;
SELECT USER(),CURRENT_USER();
SELECT VALIDATE_PASSWORD_STRENGTH('login_user') = 0;
SELECT VALIDATE_PASSWORD_STRENGTH('resu_nigol') = 0;
SET @@global.validate_password_policy=default;
SET @@global.validate_password_length=default;
SET @@global.validate_password_mixed_case_count=default;
SET @@global.validate_password_number_count=default;
SET @@global.validate_password_special_char_count=default;
SET @@global.validate_password_check_user_name= default;