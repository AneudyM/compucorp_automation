#!/bin/sh

passHash=$(sudo openssl passwd -1 admin1234);
echo "CREATE USER 'civicrm'@'localhost' IDENTIFIED BY '$passHash';
      GRANT SELECT,
            INSERT,
            UPDATE, 
            DELETE,
			CREATE,
			  DROP,
			 INDEX,
			 ALTER,
      CREATE TEMPORARY TABLES ON civicrm.* TO 'civicrm'@'localhost'
      IDENTIFIED BY '$passHash';
      FLUSH PRIVILEGES;" > /opt/compucorp/db_scripts/create_civicrm_db_user.sql;
    
