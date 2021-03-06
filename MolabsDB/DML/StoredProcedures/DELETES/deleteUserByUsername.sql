DELIMITER $$
DROP PROCEDURE IF EXISTS molabsdb.deleteUserByUsername;$$
CREATE PROCEDURE molabsdb.deleteUserByUsername(pUserNameToDelete VARCHAR(45), pUserName VARCHAR(45), pPassword VARBINARY(512))
BEGIN

	-- retruns all public information of ALL users.
    -- deletes an user (and its graphs). Only if pUserName created that pUserNameToDelete
    SET @type = (SELECT type
					FROM molabsdb.users
						WHERE userName = pUserName AND password = (CAST(SHA2(pPassword, 512) AS BINARY)));

	IF (@type = 'user' OR @type IS NULL) THEN -- only owner and admin can perform this action
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Validación de usuario incorrecta.';
	END IF;
    
    START TRANSACTION;
    
		SET @idUserToDelete = (SELECT idUser FROM molabsdb.users WHERE userName = pUserNameToDelete AND createdBy = pUserName);
        
        IF (@idUserToDelete IS NULL) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Usuario ingresado inexistente o no se tienen permisos para borrar.';
		END IF;
        
        SET SQL_SAFE_UPDATES = 0;
        
        DELETE FROM molabsdb.graphs -- deletes graphs of user to be deleted
			WHERE idUser = @idUserToDelete;
            
		DELETE g FROM molabsdb.graphs g INNER JOIN molabsdb.users us ON g.idUser = us.idUser-- deletes graphs of users created by that administrator
			JOIN molabsdb.users u ON us.createdBy = u.userName
				WHERE u.createdBy = pUserNameToDelete; -- deletes in case an owner is deleted, and must delete graphs for users of administratros created by that owner

        DELETE g FROM molabsdb.graphs g INNER JOIN molabsdb.users u ON g.idUser = u.idUser-- deletes graphs of users created by that administrator
			WHERE u.createdBy = pUserNameToDelete;
		
        DELETE us FROM molabsdb.users u-- deletes users created administrators created by owner to be deleted
			JOIN molabsdb.users us ON us.createdBy = u.userName
				WHERE u.createdBy = pUserNameToDelete;

        DELETE FROM molabsdb.users -- deletes users created by that administrator
			WHERE createdBy = pUserNameToDelete;
            
		DELETE FROM molabsdb.users -- delete user
			WHERE idUser = @idUserToDelete;
            
		SET SQL_SAFE_UPDATES = 1;
    
    COMMIT;
		
    
END$$

DELIMITER ;