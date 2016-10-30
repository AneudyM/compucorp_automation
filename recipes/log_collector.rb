#
# Cookbook Name:: compucorp
# Recipe:: log_collector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home_dir = node['compucorp']['home_dir']
nginx_logs = node['compucorp']['nginx_logs']

cookbook_file "#{home_dir}/scripts/log_backup.sh" do
	source 'log_backup.sh'
	owner 'root'
	group 'root'
	mode '0700'
end

cron 'create_nginx_logs_backups' do
	minute '*/5'
	hour '*'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/log_backup.sh"
	action :create
end

cron 'send_nginx_logs_to_S3' do
	minute '*/6'
	hour '*'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/backups/nginx/ s3://#{nginx_logs}/"
	action :create
end

cron 'remove_local_nginx_logs' do
	minute '*/8'
	hour '*'
	day '*'
	weekday '*'
	command "rm #{home_dir}/backups/nginx/*"
	action :create
end
