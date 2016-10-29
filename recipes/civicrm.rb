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

# Upload civicrm db creation script
cookbook_file "#{db_scripts}/create_civicrm_db.sql" do
	source "create_civicrm_db.sql"
	action :create
end

execute 'create_civicrm_db' do
	command "mysql -uroot -p#{test_password} < #{db_scripts}/create_civicrm_db.sql && touch #{check_files}/created_civicrm_db" 
	action :run
	not_if do ::File.exists?("#{check_files}/created_civicrm_db") end
	
end

# Upload civicrm db user sql generator script
cookbook_file "#{db_scripts}/create_civicrm_db_user.sql" do
	source "create_civicrm_db_user.sql"
	mode "0755"
end

execute 'create_civicrm_db_user' do
	command "mysql -uroot -p#{test_password} < #{db_scripts}/create_civicrm_db_user.sql && touch #{check_files}/created_civicrm_db_user"
	action :run
	not_if do ::File.exists?("#{check_files}/created_civicrm_db_user") end
end

script 'install_civicrm' do
	interpreter "bash"
	cwd '/tmp'
	code <<-EOH
		wget -O civicrm.tar.gz https://download.civicrm.org/civicrm-4.7.12-drupal.tar.gz
		mv civicrm.tar.gz #{drupal_home}/sites/all/modules/
		&& touch #{check_files}/civicrm_installed
	EOH
	not_if do ::File.exists?("#{check_files}/civicrm_installed") end
end

execute 'change_ownership_html' do
	command "chown -R www-data:www-data /var/www/html/"
	action :run
end
		
