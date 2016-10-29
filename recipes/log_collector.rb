#
# Cookbook Name:: compucorp
# Recipe:: log_collector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

home_dir = node['compucorp']['home_dir']
logsbucket = node['compucorp']['logsbucket']

cookbook_file "#{home_dir}/scripts/log_backup.sh" do
	source 'log_backup.sh'
	owner 'root'
	group 'root'
	mode '0700'
end

cron 'create_container_logs' do
	minute '55'
	hour '18'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/log_backup.sh"
	action :create
end

cron 'send_logs_to_S3' do
	minute '00'
	hour '19'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/backups/nginx/ s3://#{logsbucket}"
	action :create
end
