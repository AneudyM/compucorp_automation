#
# Cookbook Name:: compucorp
# Recipe:: drupal_backup
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

home_dir = node['compucorp']['home_dir']
drupal_backups = node['compucorp']['drupal_backups']

cookbook_file "#{home_dir}/scripts/drupal_backup.sh" do
	source 'drupal_backup.sh'
	owner 'root'
	group 'root'
	mode '0700'
	action :create
end

# Add cron entries for the periodical collection and transfer
cron 'create_drupal_backups' do
	minute '00'
	hour '*'
	day '*'
	weekday '*'
	command "#{home_dir}/scripts/drupal_backup.sh"
	action :create
end

cron 'send_backups_to_S3' do
	minute '02'
	hour '*'
	day '*'
	weekday '*'
	command "s3cmd --config=/etc/s3cmd/.s3cfg sync #{home_dir}/backups/drupal/ s3://#{drupal_backups}/ && rm #{home_dir}/backups/drupal/*"
	action :create
end

cron 'remove_local_backups' do
	minute '05'
	hour '*'
	day '*'
	weekday '*'
	command "rm #{home_dir}/backups/drupal/*"
	action :create
end
	
