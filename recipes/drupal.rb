#
# Cookbook Name:: compucorp
# Recipe:: drupal
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

test_password = node['compucorp']['test_password']
check_files = node['compucorp']['check_files']
user_home = "/home/#{node['compucorp']['user']}"
user = node['compucorp']['user']

script 'install_drupal' do
	interpreter "bash"
	user user
	cwd user_home
	code <<-EOH
		wget -O drupal.tar.gz https://ftp.drupal.org/files/projects/drupal-7.51.tar.gz
		tar -zxf drupal.tar.gz -C /var/www/html/ --strip-components 1
		cd /var/www/html/
		sudo yes | drush site-install \
				--account-name=admin \
				--account-pass=#{test_password} \
				--db-su=root \
				--db-su-pw=#{test_password} \
				--db-url="mysql://drupal:#{test_password}@localhost/drupal" \
				--site-name="Compucorp Project" \
				--clean-url=0
		sudo mkdir /var/www/html/sites/default/custom_ext
		sudo chown -R www-data:www-data /var/www/html/ \
		&& sudo touch #{check_files}/drupal_installed
	EOH
	not_if do ::File.exists?("#{check_files}/drupal_installed") end
end
 
