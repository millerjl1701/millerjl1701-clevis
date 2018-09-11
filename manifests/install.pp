# @api private
#
# This class is called from the main clevis class for install.
#
class clevis::install {
  assert_private('clevis::install is a private class')

  package { $::clevis::package_name:
    ensure => $::clevis::package_ensure,
  }
}
