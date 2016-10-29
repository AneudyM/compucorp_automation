#
# Cookbook Name:: compucorp
# Recipe:: s3cmd
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

template '/etc/s3cmd/.s3cfg' do
	source 's3cfg.erb'
	owner 'root'
	group 'root'
	mode '0600'
end

# install the s3cmd tool
package 's3cmd' do
	action :install
end
