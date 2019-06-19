# Class: stns::server
# ===========================
#
# stns::server is to install and configure stns.

class stns::server (
  $port = 1104,
  $user = undef,
  $password = undef,
  $tokens = undef,
  $package_ensure = 'present',
) {

  require stns::repo

  include stns::server::install
  include stns::server::config
  include stns::server::service

  Class['stns::repo']
  -> Class['stns::server::install']
  -> Class['stns::server::config']
  -> Class['stns::server::service']

}
