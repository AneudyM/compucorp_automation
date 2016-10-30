#!/bin/sh

# Create DB user using password hash
echo "CREATE USER 'civicrm'@'localhost' IDENTIFIED BY 'admin1234';
      GRANT SELECT, 
			INSERT, 
			UPDATE, 
			DELETE, 
			CREATE, 
			  DROP, 
			 INDEX, 
			 ALTER, 
	   CREATE TEMPORARY TABLES, 
	   LOCK TABLES, 
	       TRIGGER, 
	   CREATE ROUTINE, 
	   ALTER ROUTINE ON civicrm.* TO 'civicrm'@'localhost' 
	   IDENTIFIED BY 'admin1234';" > /opt/compucorp/db_scripts/create_civicrm_db_user.sql;
    
