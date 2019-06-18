# Class: stns_v1::client::config
# ===========================
#
# stns_v1::client::config is to configure libnss-stns.

class stns_v1::client::config (
  $api_end_point     = $stns_v1::client::api_end_point,
  $user              = $stns_v1::client::user,
  $password          = $stns_v1::client::password,
  $wrapper_path      = $stns_v1::client::wrapper_path,
  $chain_ssh_wrapper = $stns_v1::client::chain_ssh_wrapper,
  $ssl_verify        = $stns_v1::client::ssl_verify,
  $request_timeout   = $stns_v1::client::request_timeout,
  $http_proxy        = $stns_v1::client::http_proxy,
  $request_header    = $stns_v1::client::request_header,
  $uid_shift         = $stns_v1::client::uid_shift,
  $gid_shift         = $stns_v1::client::gid_shift,
){

  if $request_header != undef {
    validate_hash($request_header)
  }

  file { '/etc/stns/libnss_stns.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('stns_v1/libnss_stns.conf.erb'),
  }

}
