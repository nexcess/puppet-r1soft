class r1soft::server::config {
  $hash = sha1($r1soft::server::admin_pass)

  file {"/usr/sbin/r1soft/conf/.puppet":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "# This file is used by the r1soft puppet module\n${hash}",
  }
  exec{'setting admin user password':
    command     => "/usr/bin/serverbackup-setup --user ${r1soft::server::admin_user} --pass ${r1soft::server::admin_pass}",
    subscribe   => File['/usr/sbin/r1soft/conf/.puppet'],
    notify      => Class['r1soft::server::service'],
    refreshonly => true,
  }
}
