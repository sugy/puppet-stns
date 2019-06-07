# Define: stns_v1::server::groups
# ===========================
#
# The stns_v1::server::groups defined type allows to configure STNS groups.

define stns_v1::server::groups (
  Integer $id,
  Variant[String, Array, Undef] $users,
) {

  concat::fragment { "groups_${title}":
    target  => '/etc/stns/stns.conf',
    content => template('stns_v1/groups.conf.erb'),
    order   => '61',
  }

}
