define r1soft::agent::key ($ensure, $key) {
  file { "/usr/sbin/r1soft/conf/server.allow/${name}":
    ensure  => $ensure,
    content => $key,
    mode    => '0644',
    owner   => 0,
    group   => 0
  }
}
