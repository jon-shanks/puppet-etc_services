# == Class: etc_services
#
# Module for handling and managing the /etc/services file, this uses a function create_augeas_format, which takes the YAML hash
# and creates the relevant format for augeas /etc/services
#
# === Parameters
# [*config*]
#   This is a hash structure of the data usually pulled in from hiera as a merge for all services the expected format is
#      {'service_key'=>{'name'=>'NAME_OF_SERVICE', 'port'=>'123456', 'protocol'=>'tcp', 'comment'=>'This service is a test'}}
#
# [*package*]
#   The package name that installs the services, (known as setup)
#
# === Variables
#
# === Examples
#
#  class { etc_services:
#    config => {'service_key'=>{'name'=>'NAME_OF_SERVICE', 'port'=>'123456', 'protocol'=>'tcp', 'comment'=>'This service is a test'}}
#  }
#
# === Authors
#
# Jonathan Shanks <jon.shanks@gmail.com>
#
# === Copyright
#
#
class etc_services( $package  = 'setup',
                    $config   = hiera_hash('etc_services::config', false) )
{

  class { 'etc_services::package':
    package   => $package
  }

  if $config and !empty($config) {
    create_resources(augeas, create_augeas_format($config))
  }

}
