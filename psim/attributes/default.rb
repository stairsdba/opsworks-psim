default['psim']['installer_url'] = "https://s3.amazonaws.com/chef-psim/PSIM.exe"
default['psim']['install_dir'] = "C:\\Program Files (x86)\\PrinterOn Corporation"
default['psim']['data_dir'] = "C:\\ProgramData\\PrinterOn Corporation\\PONData"

default['psim']['service']['hostname'] = "cps.tutorial.opsworks.pon.internal"
default['psim']['service']['domain_suffix'] = ".opsworks.pon.internal"

default['psim']['host']['serialnbr']['pas'] = "HMNJ-Y054-XWD6"
default['psim']['host']['serialnbr']['pds'] = "1YMW-0HDJ-3M2H"
default['psim']['host']['serialnbr']['pdh'] = "XHAK-20NV-Q5CR"

default['psim']['hostname'] = "host"

default['psim']['cps']['http_port'] = 80
default['psim']['cps']['https_port'] = 443
default['psim']['cps']['sslProtocols'] = "SSLv3,TLSv1,TLSv1.1,TLSv1.2"
default['psim']['cps']['keystoreSettings'] = 'keystoreFile="${pon.data.root}\KeyStore\keystore"  keystorePass="rz6KZSpMD7fy7Co6UfIBmw%3D%3D"'

default['psim']['pas']['processing']['layer'] = 'pas'
default['psim']['pas']['status']['layer'] = 'pas'
default['psim']['pas']['status']['hostname'] = 'pas.tutorial.opsworks.pon.internal'

default['psim']['s3']['bucket'] = "chef-psim"

