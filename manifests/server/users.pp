# Define: stns_v2::server::users
# ===========================
#
# The stns_v2::server::users defined type is to configure STNS users.

define stns_v2::server::users (
  $id,
  $group_id,
  $keys,
  $link_users,
  $directory = "/home/${title}",
  $shell = '/bin/bash',
  $gecos,
  $password,
) {

  concat::fragment { "users_${title}":
    target  => '/etc/stns/server/stns.conf',
    content => template('stns_v2/server/users.conf.erb'),
    order   => '41';
  }

}
