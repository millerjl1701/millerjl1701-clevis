# @api private
#
# This class is meant to be called from clevis to manage the clevis service.
#
class clevis::service {
  assert_private('clevis::service is a private class')

  service { $::clevis::service_name:
    ensure     => $::clevis::service_ensure,
    enable     => $::clevis::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
