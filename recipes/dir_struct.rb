#
# Cookbook Name:: compucorp
# Recipe:: dir_struct
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir =  node['compucorp']['home_dir']
check_files = node['compucorp']['check_files']
db_scripts = node['compucorp']['db_scripts']


directory "#{home_dir}" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}") end
end

directory "#{home_dir}/backups" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/backups") end
end

directory "#{home_dir}/backups/nginx" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/backups/nginx") end
end

directory "#{home_dir}/backups/mysql" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/backups/mysql") end
end

directory "#{home_dir}/backups/drupal" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/backups/drupal") end
end

directory "#{check_files}" do
	action :create
	not_if do ::Dir.exists?("#{check_files}") end
end

directory "#{db_scripts}" do
	action :create
	not_if do ::Dir.exists?("#{db_scripts}") end
end

directory "#{home_dir}/scripts" do
	action :create
	not_if do ::Dir.exists?("#{home_dir}/scripts") end
end

directory '/etc/s3cmd' do
	owner 'root'
	group 'root'
	action :create
end

directory "/var/www" do
	action :create
	owner 'root'
	group 'root'
	mode '0755'
	not_if do ::Dir.exists?("/var/www") end
end

directory '/etc/nginx/ssl' do
	recursive true
	action :create
	not_if do ::Dir.exists?('/etc/nginx/ssl') end
end
