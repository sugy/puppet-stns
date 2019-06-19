# Class: stns_v2::server::service
# ===========================
#
# stns_v2::server::service is to manage service of stns.

class stns_v2::server::service {

  service { 'stns':
    ensure => running,
    enable => true,
  }

}
