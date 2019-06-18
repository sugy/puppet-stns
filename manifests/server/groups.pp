# Define: stns_v1::server::groups
# ===========================
#
# The stns_v1::server::groups defined type allows to configure STNS groups.

define stns_v1::server::groups (
  $id    = undef,
  $users = undef,
) {

  validate_integer($id)

  if !(is_string($users) or is_array($users)) {
    fail('$users must be either a string or an array.')
  }

  concat::fragment { "groups_${title}":
    target  => '/etc/stns/stns.conf',
    content => template('stns_v1/groups.conf.erb'),
    order   => '61',
  }

}
