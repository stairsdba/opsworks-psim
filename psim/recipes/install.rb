#
# Cookbook Name:: psim
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file 'license.txt' do
    source 'license.txt'
	action :create
end

user 'vagrant' do
   username 'vagrant'
   password 'v@ngrAnt!'
   action :create
end

group 'Administrators' do
  members ["#{node['hostname']}\\vagrant"]
  append true
  action :modify
end

include_recipe 'vc2013'

include_recipe 'ms_dotnet35'

remote_file 'PSIM.exe' do
   source "https://s3.amazonaws.com/chef-psim/PSIM.exe"
   notifies :install, 'windows_package[psim]', :immediately
end

windows_package 'psim' do
    installer_type :custom
    source 'c:\PSIM.exe'
    options "\"Mode:Auto|InstallType:Install|ConfigFile:C:\\license.txt|UserName:#{node['hostname']}\\vagrant|Password:v@ngrAnt!|PASKey:HMNJ-Y054-XWD6|PDSKey:1YMW-0HDJ-3M2H|PDHKey:XHAK-20NV-Q5CR\""
    timeout 7200
    action :nothing
end

windows_service 'Tomcat8' do
    service_name 'Tomcat8'
    action :restart
end

windows_service 'StatusServer' do
    service_name 'PrintAnywhere Status Server'
    action :start
end

windows_service 'ProcessingServer' do
    service_name 'PrintAnywhere Processing Server'
    action :start
end

windows_service 'Print Delivery Station' do
    service_name 'Print Delivery Station'
    action :start
end
