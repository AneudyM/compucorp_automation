#
# Cookbook Name:: compucorp
# Recipe:: ssl_config
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

check_files = node['compucorp']['check_files']

script 'Create Self-Signed Certificate' do
	interpreter "bash"
	code <<-EOH
		openssl req -nodes -new -sha256 -newkey rsa:2048 -keyout /etc/nginx/ssl/server_name.key -out /etc/nginx/ssl/server_name.csr -subj "/C=US/ST=Michigan/L=Kalamazoo/O=Compucorp/OU=DevOps/CN=localhost"
		openssl x509 -req -sha256 -days 365 -in /etc/nginx/ssl/server_name.csr -signkey /etc/nginx/ssl/server_name.key -out /etc/nginx/ssl/server_name.crt
		openssl dhparam -out /etc/nginx/ssl/dhparams.pem 2048 \
		&& touch #{check_files}/created_self_signed_certificate
	EOH
	not_if do ::File.exists?("#{check_files}/created_self_signed_certificate") end
end
