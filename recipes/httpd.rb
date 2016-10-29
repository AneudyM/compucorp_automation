#
# Cookbook Name:: compucorp
# Recipe:: httpd
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

php_version = node['compucorp']['php_version']

package [ "php#{php_version}-fpm", "php#{php_version}-cli", "php#{php_version}-mysql", "php#{php_version}-gd", "php#{php_version}-curl", "php#{php_version}-xml" ] do
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

template "/etc/php/#{php_version}/fpm/php.ini" do
	source 'php.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/fpm/php-fpm.conf" do
	source 'php-fpm.conf.erb'
	owner 'root'
	group 'root'
	mode '0644'
	variables ({ :php_version => "#{php_version}" })
end

template '/etc/nginx/sites-available/default' do
	source 'sites-available_default.erb'
	owner 'root'
	group 'root'
	mode '0644'
	variables ({ :php_version => "#{php_version}" })
end

template "/etc/php/#{php_version}/mods-available/json.ini" do
	source 'json.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/mods-available/mysqli.ini" do
	source 'mysqli.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/mods-available/mysql.ini" do
	source 'mysql.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/mods-available/opcache.ini" do
	source 'opcache.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/mods-available/pdo.ini" do
	source 'pdo.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template "/etc/php/#{php_version}/mods-available/pdo_mysql.ini" do
	source 'pdo_mysql.ini.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

