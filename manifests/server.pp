# Class: stns_v1::server
# ===========================
#
# stns_v1::server is to install and configure stns.

class stns_v1::server (
  $port           = 1104,
  $user           = undef,
  $password       = undef,
  $package_ensure = present,
) {

  validate_integer($port)
  validate_string($user)
  validate_string($password)
  validate_string($package_ensure)

  require stns_v1::repo

  include stns_v1::server::install
  include stns_v1::server::config
  include stns_v1::server::service

  Class['stns_v1::repo']
  -> Class['stns_v1::server::install']
  -> Class['stns_v1::server::config']
  -> Class['stns_v1::server::service']

}
