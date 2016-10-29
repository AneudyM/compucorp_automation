#
# Cookbook Name:: compucorp
# Recipe:: mysql
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

test_password = node['compucorp']['test_password']
host = node['compucorp']['host']
check_files = node['compucorp']['check_files']
db_scripts = node['compucorp']['db_scripts']
home_dir = node['compucorp']['home_dir']

ENV['DEBIAN_FRONTEND'] = 'noninteractive'

script 'Install MySQL' do
	interpreter 'sh'
	code <<-EOH
		echo "mysql-server mysql-server/root_password password #{test_password}" | sudo debconf-set-selections
		echo "mysql-server mysql-server/root_password_again password #{test_password}" | sudo debconf-set-selections
		apt-get -y install mysql-client mysql-server
	EOH
end


