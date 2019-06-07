# Define: stns_v1::server::users
# ===========================
#
# The stns_v1::server::users defined type is to configure STNS users.

define stns_v1::server::users (
  Integer $id,
  Integer $group_id,
  Variant[String, Array] $keys,
  Variant[String, Array] $link_users,
  String $directory = "/home/${title}",
  String $shell = '/bin/bash',
) {

  concat::fragment { "users_${title}":
    target  => '/etc/stns/stns.conf',
    content => template('stns_v1/users.conf.erb'),
    order   => '41';
  }

}
