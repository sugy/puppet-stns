# Class: stns_v1::client::install
# ===========================
#
# stns_v1::client::install is to install libnss-stns and libpam-stns files.

class stns_v1::client::install(
  $package_ensure     = $stns_v1::client::package_ensure,
  $libnss_stns_ensure = $stns_v1::client::libnss_stns_ensure,
  $libpam_stns_ensure = $stns_v1::client::libpam_stns_ensure,
) {

  if $package_ensure != undef {
    warning('$package_ensure is deprecated and will be removed. Please use $libnss_stns_ensure and $libpam_stns_ensure instead.')
  }

  case $package_ensure {
    'present', 'latest', 'absent': {
      $_libnss_stns_ensure = $package_ensure
      $_libpam_stns_ensure = $package_ensure
    }
    default: {
      $_libnss_stns_ensure = $libnss_stns_ensure
      $_libpam_stns_ensure = $libpam_stns_ensure
    }
  }

  package {
    'libnss-stns':
      ensure => $_libnss_stns_ensure;

    'libpam-stns':
      ensure => $_libpam_stns_ensure;
  }

}
