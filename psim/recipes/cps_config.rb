windows_service 'Tomcat8' do
  supports :status => true
  action :start
end

windows_service 'Bonjour Service' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'Print Delivery Gateway' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'Print Delivery Station' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'PASPort' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'PrintAnywhere Processing Server' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'PrintAnywhere Processing Server' do
  action :stop
end

windows_service 'PrintAnywhere Server Agent' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'PrintAnywhere Status Server' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

windows_service 'SQL Agent' do
  supports :status => true
  action :stop
  action :configure_startup
  startup_type :disabled
end

# Configure cps to connect to the RDS database
rds_db_instance = search("aws_opsworks_rds_db_instance").first

template 'cps-db.properties' do
  source 'cps-db.erb'
  path "#{node['psim']['install_dir']}\\Apache Tomcat\\lib\\cps-db.properties"
  variables({
    :connection_url => "jdbc:sqlserver://#{rds_db_instance['address']}:#{rds_db_instance['port']};instanceName=#{rds_db_instance['db_instance_identifier']};databaseName=cpsdb;",
    :db_user => "#{rds_db_instance['db_user']}",
    :db_password => "#{rds_db_instance['db_password']}"    
  })
end

template 'imcas-db.properties' do
  source 'imcas-db.erb'
  path "#{node['psim']['install_dir']}\\Apache Tomcat\\lib\\imcas-db.properties"
  variables({
    :connection_url => "jdbc:sqlserver://#{rds_db_instance['address']}:#{rds_db_instance['port']};instanceName=#{rds_db_instance['db_instance_identifier']};databaseName=imcas;",
    :db_user => "#{rds_db_instance['db_user']}",
    :db_password => "#{rds_db_instance['db_password']}"    
  })
  
end

template 'server.xml' do
  source 'server.erb'
  path "#{node['psim']['install_dir']}\\Apache Tomcat\\Conf\\server.xml"
  variables({
    :cps_http_port => "#{node['psim']['cps']['http_port']}",
    :cps_https_port => "#{node['psim']['cps']['https_port']}",
    :cps_ssl_protocols => "#{node['psim']['cps']['sslProtocols']}",
    :cps_keystore_settings => "#{node['psim']['cps']['keystoreSettings']}"
  })
  notifies :restart, 'windows_service[Tomcat8]', :immediately
end

