# Class: stns_v2::server
# ===========================
#
# stns_v2::server is to install and configure stns.

class stns_v2::server (
  $port = 1104,
  $user = undef,
  $password = undef,
  $tokens = undef,
  $package_ensure = 'present',
) {

  require stns_v2::repo

  include stns_v2::server::install
  include stns_v2::server::config
  include stns_v2::server::service

  Class['stns_v2::repo']
  -> Class['stns_v2::server::install']
  -> Class['stns_v2::server::config']
  -> Class['stns_v2::server::service']

}
