#
# Cookbook Name:: compucorp
# Recipe:: ssl_config
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

check_files = node['compucorp']['check_files']

script 'Create Self-Signed Certificate' do
	interpreter "bash"
	code <<-EOH
		openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=US/ST=Michigan/L=Kalamazoo/O=Compucorp/OU=DevOps/CN=compucorptasks.com"
		openssl dhparam -out /etc/nginx/ssl/dhparam.pem 512 \
		&& touch #{check_files}/created_slef_signed_certificate
	EOH
	not_if do ::File.exists?("#{check_files}/created_self_signed_certificate") end
end
