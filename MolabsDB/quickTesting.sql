call molabsdb.selectAllUsersForOwner('root' , CAST(SHA2('root', 512) AS BINARY));
call molabsdb.selectAllAdministratorsForOwner('root' , CAST(SHA2('root', 512) AS BINARY));
call molabsdb.selectAllUsersForAdministrator('root' , CAST(SHA2('root', 512) AS BINARY));
call molabsdb.selectUserByUsername('adrian','root' , CAST(SHA2('root', 512) AS BINARY));


/*call molabsdb.updateGraphForUser('ABSvsConce','Jcaca','admin' , CAST(SHA2('admin', 512) AS BINARY));
call molabsdb.selectUserGraphs('admin', 'ABSvsConce','root' , CAST(SHA2('root', 512) AS BINARY));
SELECT * from molabsdb.graphs*/

/*START TRANSACTION;
SELECT * from molabsdb.graphs;
call molabsdb.deleteUserByUsername('josue','root' , CAST(SHA2('root', 512) AS BINARY));
SELECT * from molabsdb.graphs;
SELECT * FROM molabsdb.users
ROLLBACK;*/
	
-- UPDATE USERS
/*START TRANSACTION;

SELECT * FROM molabsdb.users;
CALL molabsdb.updateUser('adrian','userr', CAST(SHA2('user', 512) AS BINARY),  'admin','Userr User', '1111-1112','userr@hotmail.com',
	'adrian' , CAST(SHA2('lopez', 512) AS BINARY));
SELECT * FROM molabsdb.users; 
 
ROLLBACK;*/


SELECT * FROM molabsdb.users


