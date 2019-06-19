# Class: stns_v2::client::install
# ===========================
#
# stns_v2::client::install is to install libnss-stns files.

class stns_v2::client::install (
  $libnss_stns_ensure = $stns_v2::client::libnss_stns_ensure,
){

  package { 'libnss-stns-v2':
    ensure => $libnss_stns_ensure,
  }

}
