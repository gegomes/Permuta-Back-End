
DROP PROCEDURE IF EXISTS PROCEDURE_CHECK_PERMISSION_USER_LOGADO;

DELIMITER //
	CREATE PROCEDURE PROCEDURE_CHECK_PERMISSION_USER_LOGADO(IN INPUT_USER_ID INT)
		BEGIN
		    SELECT U.id, PS.name,PS.slug FROM users AS U	INNER JOIN permissions_users AS P ON P.user_id = U.id	INNER JOIN permissions AS PS	ON PS.id = P.permission_id	WHERE U.id = INPUT_USER_ID;
		END //
DELIMITER ;



CALL PROCEDURE_CHECK_PERMISSION_USER_LOGADO(1)