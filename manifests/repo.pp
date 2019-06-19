# Class: stns_v2::repo
# ===========================
#
# stns_v2::repo is to setup repository.
class stns_v2::repo {

  $gpgkey_url = 'https://repo.stns.jp/gpg/GPG-KEY-stns'

  case $::osfamily {
    'RedHat': {
      yumrepo { 'stns':
        ensure   => present,
        descr    => 'stns',
        baseurl  => 'http://repo.stns.jp/centos/$basearch/$releasever',
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => $gpgkey_url,
      }
    }
    'Debian': {
      include ::apt
      require ::apt::update

      include stns_v2::repo::apt
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }

}
