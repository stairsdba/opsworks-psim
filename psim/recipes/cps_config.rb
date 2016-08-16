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
template 'C:\Program Files (x86)\PrinterOn Corporation\Apache Tomcat\lib\cps-db.properties' do
  source 'cps-db.erb'
  variables({
    :connection_url => "jdbc:sqlserver://#{rds_db_instance['address']}:#{rds_db_instance['port']};instanceName=#{rds_db_instance['db_instance_identifier']};databaseName=cpsdb;",
    :db_user => "#{rds_db_instance['db_user']}",
    :db_password => "#{rds_db_instance['db_password']}"    
  })
end

template 'C:\Program Files (x86)\PrinterOn Corporation\Apache Tomcat\lib\imcas-db.properties' do
  source 'imcas-db.erb'
  variables({
    :connection_url => "jdbc:sqlserver://#{rds_db_instance['address']}:#{rds_db_instance['port']};instanceName=#{rds_db_instance['db_instance_identifier']};databaseName=imcas;",
    :db_user => "#{rds_db_instance['db_user']}",
    :db_password => "#{rds_db_instance['db_password']}"    
  })
  notifies :restart, 'windows_service[Tomcat8]', :immediately
end