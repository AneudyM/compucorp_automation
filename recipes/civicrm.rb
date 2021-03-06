#
# Cookbook Name:: compucorp
# Recipe:: civicrm
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

    drupal_home = node['compucorp']['drupal_home']
    check_files = node['compucorp']['check_files']
  test_password = node['compucorp']['test_password']
civicrm_package = node['compucorp']['civicrm_package'] 
      user_home = "/home/#{node['compucorp']['user']}"
     db_scripts = node['compucorp']['db_scripts']
       home_dir = node['compucorp']['home_dir']

###########################################
## CREATE CIVICRM DATABASE
###########################################
cookbook_file "#{db_scripts}/create_civicrm_db.sql" do
	source "create_civicrm_db.sql"
	action :create
end

execute 'create_civicrm_db' do
	command "mysql -uroot -p#{test_password} < #{db_scripts}/create_civicrm_db.sql && touch #{check_files}/created_civicrm_db" 
	action :run
	not_if do ::File.exists?("#{check_files}/created_civicrm_db") end
end

###########################################
## CREATE CIVICRM DATABASE USER
###########################################
cookbook_file "#{home_dir}/scripts/create_civicrm_db_user.sh" do
	source "create_civicrm_db_user.sh"
	mode "0755"
end

execute 'create_civicrm_db_user_script' do
		command "sh #{home_dir}/scripts/create_civicrm_db_user.sh"
		action :run
end

execute 'mysql_civicrm_db_user_load' do
	command "mysql -uroot -p#{test_password} < #{db_scripts}/create_civicrm_db_user.sql && touch #{check_files}/created_civicrm_db_user"
	action :run
	not_if do ::File.exists?("#{check_files}/created_civicrm_db_user") end
end

script 'install_civicrm' do
	interpreter "bash"
	cwd drupal_home
	code <<-EOH
		wget -O sites/all/modules/civicrm.tar.gz https://download.civicrm.org/civicrm-4.7.12-drupal.tar.gz
		yes | sudo drush civicrm-install \
					--dbhost=localhost \
					--dbname=civicrm \
					--dbpass=#{test_password} \
					--dbuser=civicrm \
					--destination=sites/all/modules \
					--load_generated_data=0 \
					--ssl=on \
					--tarfile=sites/all/modules/civicrm.tar.gz 
		mysql -uroot -p#{test_password} civicrm -e "GRANT SELECT ON civicrm.* TO 'drupal'@'localhost' IDENTIFIED BY '#{test_password}';"
		sudo chown -R www-data:www-data ./ \
		&& touch #{check_files}/civicrm_installed
	EOH
	not_if do ::File.exists?("#{check_files}/civicrm_installed") end
end
