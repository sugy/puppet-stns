# Class: stns_v2::client::config
# ===========================
#
# stns_v2::client::config is to configure libnss-stns.

class stns_v2::client::config (
  $api_end_point     = $stns_v2::client::api_end_point,
  $auth_token        = $stns_v2::client::auth_token,
  $user              = $stns_v2::client::user,
  $password          = $stns_v2::client::password,
  $wrapper_path      = $stns_v2::client::wrapper_path,
  $chain_ssh_wrapper = $stns_v2::client::chain_ssh_wrapper,
  $ssl_verify        = $stns_v2::client::ssl_verify,
  $request_timeout   = $stns_v2::client::request_timeout,
  $request_retry     = $stns_v2::client::request_retry,
  $http_proxy        = $stns_v2::client::http_proxy,
  $uid_shift         = $stns_v2::client::uid_shift,
  $gid_shift         = $stns_v2::client::gid_shift,
){

  file { '/etc/stns/client/stns.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('stns/client/stns.conf.erb'),
  }

}
