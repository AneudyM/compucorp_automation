#
# Cookbook Name:: compucorp
# Recipe:: default
#
# Copyright (c) 2016 Aneudy Mota, All Rights Reserved.

include_recipe 'compucorp::repositories'
include_recipe 'apt::default'
include_recipe 'compucorp::dir_struct'
include_recipe 'compucorp::git'
include_recipe 'compucorp::s3cmd'
include_recipe 'compucorp::httpd'
include_recipe 'compucorp::ssl_config'
include_recipe 'compucorp::mysql'
include_recipe 'compucorp::drush'
include_recipe 'compucorp::drupal'
include_recipe 'compucorp::civicrm'
#include_recipe 'compucorp::drupal_backup'
#include_recipe 'compucorp::db_backup'
#include_recipe 'compucorp::log_collector'

execute 'Restart NGINX' do
	command 'service nginx restart'
	action :run
end
