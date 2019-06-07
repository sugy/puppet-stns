# Class: stns_v1::client::install
# ===========================
#
# stns_v1::client::install is to install libnss-stns and libpam-stns files.

class stns_v1::client::install (
  $libnss_stns_ensure = $stns_v1::client::libnss_stns_ensure,
  $libpam_stns_ensure = $stns_v1::client::libpam_stns_ensure,
){

  package {
    'libnss-stns':
      ensure => $libnss_stns_ensure;

    'libpam-stns':
      ensure => $libpam_stns_ensure;
  }

}
