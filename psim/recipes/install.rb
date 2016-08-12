#
# Cookbook Name:: psim
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['psim']['hostname'] = node['hostname']

cookbook_file 'license.txt' do
    source 'license.txt'
	action :create
end

include_recipe 'vc2013'

include_recipe 'ms_dotnet35'

remote_file 'PSIM.exe' do
   source node['psim']['installer_url']
   notifies :install, 'windows_package[psim]', :immediately
end

windows_package 'psim' do
    installer_type :custom
    source 'c:\PSIM.exe'
    options "\"Mode:Auto|InstallType:Install|ConfigFile:C:\\license.txt|UserName:#{node['hostname']}\\vagrant|Password:v@ngrAnt!|PASKey:#{node['psim'][node['psim']['hostname']]['serialnbr']['pas']}|PDSKey:#{node['psim'][node['psim']['hostname']]['serialnbr']['pds']}|PDHKey:#{node['psim'][node['psim']['hostname']]['serialnbr']['pdh']}\""
	#returns [3010, 0]
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
