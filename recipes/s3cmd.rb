#
# Cookbook Name:: compucorp
# Recipe:: s3cmd
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

aws_access_key = node['compucorp']['aws_access_key']
aws_secret_key = node['compucorp']['aws_secret_key']

template '/etc/s3cmd/.s3cfg' do
	source 's3cfg.erb'
	owner 'root'
	group 'root'
	mode '0600'
	variables ({ :access_key => "#{aws_access_key}",
				 :secret_key => "#{aws_secret_key}"
	})
end

# Install s3cmd
package 's3cmd' do
	action :install
end
