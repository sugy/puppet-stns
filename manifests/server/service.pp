# Class: stns_v1::server::service
# ===========================
#
# stns_v1::server::service is to manage service of stns.

class stns_v1::server::service {

  service { 'stns':
    ensure => running,
    enable => true,
  }

}
