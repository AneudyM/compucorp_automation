#!/bin/sh

passHash=$(sudo openssl passwd -1 admin1234);
echo "CREATE USER drupal@localhost IDENTIFIED BY '$passHash';
      GRANT SELECT, 
	    INSERT, 
	    UPDATE, 
	    DELETE, 
	    CREATE, 
	      DROP, 
	     INDEX, 
	     ALTER, 
      CREATE TEMPORARY TABLES ON drupal.* TO 'drupal'@'localhost' 
      IDENTIFIED BY '$passHash';" > /opt/compucorp/db_scripts/create_drupal_db_user.sql;


