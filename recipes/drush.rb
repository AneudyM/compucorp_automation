#
# Cookbook Name:: compucorp
# Recipe:: drush
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

user_home = "/home/#{node['compucorp']['user']}"
check_files = node['compucorp']['check_files']
user = node['compucorp']['user']
home_dir = node['compucorp']['home_dir']

script 'install_composer' do
	interpreter "bash"
	cwd user_home
	code <<-EOH
		wget -O composer https://getcomposer.org/download/1.2.1/composer.phar
		chmod 0755 composer 
		mv composer /usr/local/bin/ \
		&& touch #{check_files}/composer_installed
	EOH
	not_if do ::File.exists?("#{check_files}/composer_installed") end
end

script 'install_drush' do
	interpreter "bash"
	cwd user_home
	user user
	code <<-EOH
		git clone https://github.com/drush-ops/drush.git
		sudo ln -s #{user_home}/drush/drush /usr/local/lib/drush
		cd drush/
		composer install \
		&& sudo touch #{check_files}/drush_civicrm_support_installed
	EOH
	not_if do ::File.exists?("#{check_files}/drush_civicrm_support_installed") end
end
