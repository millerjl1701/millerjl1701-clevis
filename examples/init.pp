node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'clevis':
    require => Notify['enduser-before'],
    before  => Notify['enduser-after'],
  }

}
