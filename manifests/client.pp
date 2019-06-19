# Class: stns_v2::client
# ===========================
#
# stns_v2::client is to install and configure libnss-stns.
class stns_v2::client (
  $api_end_point = undef,
  $auth_token = undef,
  $user = undef,
  $password = undef,
  $wrapper_path = undef,
  $chain_ssh_wrapper = undef,
  $ssl_verify = undef,
  $request_timeout = undef,
  $request_retry = undef,
  $http_proxy = undef,
  $uid_shift = undef,
  $gid_shift = undef,
  $libnss_stns_ensure = 'present',
  $handle_nsswitch    = false,
  $handle_sshd_config = false,
) {

  require stns_v2::repo

  include stns_v2::client::install
  include stns_v2::client::config

  Class['stns_v2::repo']
  -> Class['stns_v2::client::install']
  -> Class['stns_v2::client::config']

  if $handle_nsswitch {
    augeas { 'nsswitch stns':
      context => '/files/etc/nsswitch.conf',
      changes => [
        "set *[self::database = 'passwd']/service[1] files",
        "set *[self::database = 'passwd']/service[2] stns",
        "set *[self::database = 'shadow']/service[1] files",
        "set *[self::database = 'shadow']/service[2] stns",
        "set *[self::database = 'group']/service[1] files",
        "set *[self::database = 'group']/service[2] stns",
      ],
    }
  }

  if $handle_sshd_config {
    if ($::osfamily == 'RedHat' and $::operatingsystemmajrelease != '7') {
      $cmd_user = 'AuthorizedKeysCommandRunAs'
    } else {
      $cmd_user = 'AuthorizedKeysCommandUser'
    }

    $ssh_service = $::osfamily ? {
      'RedHat' => 'sshd',
      'Debian' => 'ssh',
    }

    augeas {'sshd_config with stns':
      context => '/files/etc/ssh/sshd_config',
      changes => [
        'set PubkeyAuthentication yes',
        'set AuthorizedKeysCommand /usr/lib/stns/stns-key-wrapper',
        "set ${cmd_user} root",
      ],
      require => Package['openssh-server'],
      notify  => Service[$ssh_service],
    }
  }

}
