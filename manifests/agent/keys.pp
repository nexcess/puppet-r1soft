class r1soft::agent::keys {
  if ! empty($r1soft::agent::keys) {
    create_resources(r1soft::agent::key, $r1soft::agent::keys)
  }

  if $r1soft::agent::keys_purge_unmanaged {
    file { '/usr/sbin/r1soft/conf/server.allow/':
      ensure  => 'directory',
      purge   => true,
      force   => true,
      recurse => true,
    }
  }
}
