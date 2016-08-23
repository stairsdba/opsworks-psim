# windows_service 'Bonjour Service' do
  # service_name 'Bonjour Service'
  # action [:stop, :configure_startup]
  # startup_type :disabled
# end

# windows_service 'Print Delivery Gateway' do
  # service_name 'Print Delivery Gateway'
  # action [:stop, :configure_startup]
  # startup_type :disabled
# end

# windows_service 'PASPort' do
  # service_name 'PASPort'
  # action [:start]
# end

# windows_service 'PrintAnywhere Processing Server' do
  # service_name 'PrintAnywhere Processing Server'
  # action [:start]
# end

# windows_service 'PrintAnywhere Server Agent' do
  # service_name 'PrintAnywhere Server Agent'
  # action [:start]
# end

# windows_service 'PrintAnywhere Status Server' do
  # service_name 'PrintAnywhere Status Server'
  # action [:start]
# end

# windows_service 'SQL Agent' do
  # service_name 'SQL Agent'
  # action [:stop, :configure_startup]
  # startup_type :disabled
# end

# windows_service 'PON S3' do
  # service_name 'PON S3'
  # action [:stop, :configure_startup]
  # startup_type :disabled
# end

# Get the list of servers in the Processing Server Layer
proc_layer = search("aws_opsworks_layer","shortname:#{node['psim']['pas']['processing']['layer']}").first
Chef::Log.info("********** The Processing layer's name is '#{proc_layer['name']}' **********")
Chef::Log.info("********** The Processing layer's shortname is '#{proc_layer['shortname']}' **********")

proc_servers = search("aws_opsworks_instance","layer_ids:#{proc_layer['layer_id']}")


# Get the list of servers in the Status Server Layer
status_layer = search("aws_opsworks_layer","shortname:#{node['psim']['pas']['status']['layer']}").first
Chef::Log.info("********** The Status layer's name is '#{status_layer['name']}' **********")
Chef::Log.info("********** The Status layer's shortname is '#{status_layer['shortname']}' **********")

status_servers = search("aws_opsworks_instance","layer_ids:#{status_layer['layer_id']}")

template 'StatusServerConfig.xml' do
    source 'pas/User/StatusServerConfig.erb'
    path "#{node['psim']['data_dir']}\\PrintAnywhere\\Config\\User\\StatusServerConfig.xml"
    variables({
      :proc_servers => proc_servers,
      :status_servers => status_servers,
	  :license_server => node['psim']['service']['hostname']
      :psim => node['psim']
    })
end

cookbook_file 'server.xml' do
    source 'pas\server.xml'
    path "#{node['psim']['install_dir']}\\Apache Tomcat\\Conf\\server.xml"
    action :create
end

template 'ProcessingServerConfig.xml' do
    source 'pas/User/ProcessingServerConfig.erb'
    path "#{node['psim']['data_dir']}\\PrintAnywhere\\Config\\User\\ProcessingServerConfig.xml"
end

