#
# Cookbook Name:: compucorp
# Recipe:: httpd
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

package [ 'php7.0-fpm', 'php7.0-cli', 'php7.0-mysql', 'php7.0-gd', 'php7.0-curl', 'php7.0-xml' ] do
	action :install
end

package [ 'apache2', 'apache2-bin', 'apache2-data' ] do
	action :remove
end

package [ 'nginx', 'nginx-common', 'nginx-core' ]  do
	action :install
end

template '/etc/nginx/nginx.conf' do
	source 'nginx.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/nginx/fastcgi_params' do
	source 'fastcgi_params.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/fpm/php.ini' do
	source 'php.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/fpm/php-fpm.conf' do
	source 'php-fpm.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/nginx/sites-available/default' do
	source 'sites-available_default.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/json.ini' do
	source 'json.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/mysqli.ini' do
	source 'mysqli.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/mysql.ini' do
	source 'mysql.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/opcache.ini' do
	source 'opcache.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/pdo.ini' do
	source 'pdo.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/php/7.0/mods-available/pdo_mysql.ini' do
	source 'pdo_mysql.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

