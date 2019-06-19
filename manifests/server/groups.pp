# Define: stns::server::groups
# ===========================
#
# The stns::server::groups defined type allows to configure STNS groups.

define stns::server::groups (
  $id,
  $users,
  $link_groups,
) {

  concat::fragment { "groups_${title}":
    target  => '/etc/stns/server/stns.conf',
    content => template('stns/server/groups.conf.erb'),
    order   => '61',
  }

}
