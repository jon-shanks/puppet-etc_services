# == Class: etc_services::package
# 
# Module for handling the package installation of /etc/services, although this is part of base it is standard process
#
# === Parameters
#
# [*package*]
#   Name of the package, defaults to setup
#
# === Variables
#
# === Examples
#
#  class { 'etc_services::package':
#    package => 'setup'
#  }
#
# === Authors
#
# Jonathan Shanks <jon.shanks@gmail.com>
#
# === Copyright
#
#
class etc_services::package($package = 'setup') 
{

  package { $package:
    ensure  => installed,
  }

}
