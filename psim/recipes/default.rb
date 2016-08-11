#
# Cookbook Name:: psim
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file 'license.txt' do
    source 'license.txt'
	action :create
end

include_recipe 'vc2013'

include_recipe 'ms_dotnet35'

remote_file 'PSIM.exe' do
   source "http://dl.printeron.com/Archive/psim.3.2.4.1452/PSIM.exe"
   notifies :install, 'windows_package[psim]', :immediately
end

windows_package 'psim' do
    installer_type :custom
    source 'c:\PSIM.exe'
    options "\"Mode:Auto|InstallType:Install|ConfigFile:C:\\license.txt|UserName:#{node['hostname']}\\vagrant|Password:v@ngrAnt!|PASKey:HMNJ-Y054-XWD6|PDSKey:1YMW-0HDJ-3M2H|PDHKey:XHAK-20NV-Q5CR\""
	returns [3010, 0]
	timeout 7200
	notifies :create, 'directory[C:\ProgramData\PONData]', :immediately
	notifies :create, 'directory[C:\Program Files (x86)\PrinterOn Corporation]', :immediately
	notifies :create, 'directory[C:\Program Files\PrinterOn Corporation]', :immediately
    action :nothing
end

directory 'C:\ProgramData\PONData' do
    rights :full_control, ['Administrator', 'vagrant']
end

directory 'C:\Program Files (x86)\PrinterOn Corporation' do
	rights :full_control, ['Administrator', 'vagrant']
end

directory 'C:\Program Files\PrinterOn Corporation' do
	rights :full_control, ['Administrator', 'vagrant']
end

windows_service 'PON Configuration Manager' do
    service_name 'PON Configuration Manager'
    action :restart
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
