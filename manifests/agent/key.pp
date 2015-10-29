define r1soft::agent::key ($ensure = 'present', $key = undef) {
  file { "/usr/sbin/r1soft/conf/server.allow/${name}":
    ensure  => $ensure,
    content => $key,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
}
