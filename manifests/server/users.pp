# Define: stns::server::users
# ===========================
#
# The stns::server::users defined type is to configure STNS users.

define stns::server::users (
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
    content => template('stns/server/users.conf.erb'),
    order   => '41';
  }

}
