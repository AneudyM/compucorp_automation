#
# Cookbook Name:: compucorp
# Recipe:: db_backup
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['compucorp']['home_dir']
backupsbucket = node['compucorp']['backupsbucket']

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
	minute '55'
	hour '18'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/mysql_backup.sh"
	action :create
end

cron 'send_backups_to_S3' do
	minute '00'
	hour '19'
	day '*'
	weekday '*'
	command "s3cmd --config=#{home_dir}/etc/.s3cfg sync #{home_dir}/backups/mysql/ s3://#{backupsbucket}"
	action :create
end
