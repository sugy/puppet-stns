# Define: stns_v2::server::groups
# ===========================
#
# The stns_v2::server::groups defined type allows to configure STNS groups.

define stns_v2::server::groups (
  $id,
  $users,
  $link_groups,
) {

  concat::fragment { "groups_${title}":
    target  => '/etc/stns/server/stns.conf',
    content => template('stns_v2/server/groups.conf.erb'),
    order   => '61',
  }

}
