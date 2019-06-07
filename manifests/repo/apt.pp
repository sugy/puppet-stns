class stns_v1::repo::apt {
  apt::source { 'stns':
    location => 'http://repo.stns.jp/debian/',
    release  => 'stns',
    key      => {
      id     => '6BACCE33697C7E568D5C162F018A7A21B2EC51BA',
      source => $::stns_v1::repo::gpgkey_url,
    }
  }
}
