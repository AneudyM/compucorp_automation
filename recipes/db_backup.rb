#
# Cookbook Name:: compucorp
# Recipe:: db_backup
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['compucorp']['home_dir']
mysql_backups = node['compucorp']['mysql_backups']

cookbook_file "#{home_dir}/scripts/mysql_backup.sh" do
	source 'mysql_backup.sh'
	owner 'root'
	group 'root'
	mode '0700'
	action :create
end

# Add cron entries for the periodical collection and transference of 
# backups.
cron 'create_mysql_backups' do
	minute '*/5'
	hour '*'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/mysql_backup.sh"
	action :create
end

cron 'send_backups_to_S3' do
	minute '*/6'
	hour '*'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/backups/mysql/ s3://#{mysql_backups}/"
	action :create
end

cron 'remove_local_backups' do
	minute '*/8'
	hour '*'
	day '*'
	weekday '*'
	command "rm #{home_dir}/backups/mysql/*"
	action :create
end
