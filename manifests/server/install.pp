# Class: stns_v1::server::install
# ===========================
#
# stns_v1::server::install is to install stns.

class stns_v1::server::install (
  $ensure = $stns_v1::server::package_ensure,
) {

  package { 'stns':
    ensure => $ensure,
  }

  file { '/etc/stns/conf.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
