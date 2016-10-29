#
# Cookbook Name:: compucorp
# Recipe:: repositories
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.


apt_repository	'php' do
	uri		'ppa:ondrej/php'
	distribution 	node['lsb']['codename']
end
