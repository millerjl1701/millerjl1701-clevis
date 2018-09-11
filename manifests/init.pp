# Class: clevis
# ===========================
#
# Main class that includes all other classes for the clevis module.
#
# @param package_ensure Whether to install the clevis package, and/or what version. Values: 'present', 'latest', or a specific version number. Default value: present.
# @param package_name Specifies the name of the package to install. Default value: 'clevis'.
# @param service_enable Whether to enable the clevis service at boot. Default value: true.
# @param service_ensure Whether the clevis service should be running. Default value: 'running'.
# @param service_name Specifies the name of the service to manage. Default value: 'clevis'.
#
class clevis (
  String                     $package_ensure = 'present',
  String                     $package_name   = 'clevis',
  Boolean                    $service_enable = true,
  Enum['running', 'stopped'] $service_ensure = 'running',
  String                     $service_name   = 'clevis',
  ) {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      contain clevis::install
      contain clevis::config
      contain clevis::service

      Class['clevis::install']
      -> Class['clevis::config']
      ~> Class['clevis::service']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
