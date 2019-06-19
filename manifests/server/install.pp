# Class: stns_v2::server::install
# ===========================
#
# stns_v2::server::install is to install stns.

class stns_v2::server::install (
  $_ensure = $stns_v2::server::package_ensure,
){

  package { 'stns-v2':
    ensure => $_ensure,
  }

  file { '/etc/stns/conf.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
