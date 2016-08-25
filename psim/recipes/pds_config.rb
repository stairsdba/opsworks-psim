windows_service 'Tomcat8' do
  service_name 'Tomcat8'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'Bonjour Service' do
  service_name 'Bonjour Service'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'Print Delivery Gateway' do
  service_name 'Print Delivery Gateway'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'PASPort' do
  service_name 'PASPort'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'PrintAnywhere Processing Server' do
  service_name 'PrintAnywhere Processing Server'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'PrintAnywhere Server Agent' do
  service_name 'PrintAnywhere Server Agent'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'PrintAnywhere Status Server' do
  service_name 'PrintAnywhere Status Server'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'SQL Agent' do
  service_name 'SQL Agent'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'PON S3' do
  service_name 'PON S3'
  action [:stop, :configure_startup]
  startup_type :disabled
end

windows_service 'Print Delivery Station' do
  service_name 'Print Delivery Station'
  action :stop
end


s3_file 'Director.properties' do

    bucket node['psim']['s3']['bucket']
    aws_access_key_id node['psim']['custom_access_key']
    aws_secret_access_key node['psim']['custom_secret_key']
    remote_path "#{node['psim'][node['hostname']]['serialnbr']['pds']}/Director.properties"
    path "#{node['psim']['data_dir']}\\PDS\\client\\Director.properties"
    action :create
end

windows_service 'Print Delivery Station' do
  service_name 'Print Delivery Station'
  action :start
end
