class r1soft::server::config {

  # it would be nice if r1soft just stored the admin password hash in a file I
  # can easily read but it doesn't so this is the work around.
  $hash = sha1($r1soft::server::admin_pass)

  file {'/usr/sbin/r1soft/conf/.puppet_admin_pass':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => "# This file is used by the r1soft puppet module\n${hash}",
  }
  exec{'setting admin user password':
    command     => "/usr/bin/serverbackup-setup --user ${r1soft::server::admin_user} --pass ${r1soft::server::admin_pass}",
    subscribe   => File['/usr/sbin/r1soft/conf/.puppet_admin_pass'],
    notify      => Class['r1soft::server::service'],
    refreshonly => true,
  }

  # there's no "--get-max-mem" like there is with the http ports so this is the
  # work around
  if $r1soft::server::max_mem {
    file {'/usr/sbin/r1soft/conf/.puppet_max_mem':
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => "# This file is used by the r1soft puppet module\n${r1soft::server::max_mem}",
    }
    exec{"setting max-mem ${r1soft::server::max_mem}":
      command     => "/usr/bin/serverbackup-setup --set-max-mem ${r1soft::server::max_mem}",
      subscribe   => File['/usr/sbin/r1soft/conf/.puppet_max_mem'],
      refreshonly => true,
    }
  }

  exec{"setting http_port ${r1soft::server::http_port}":
    command => "/usr/bin/serverbackup-setup --http-port ${r1soft::server::http_port}",
    unless  => "/usr/bin/serverbackup-setup --get-http-port | grep -q '^Server HTTP Port: ${r1soft::server::http_port}$'",
    notify  => Class['r1soft::server::service'],
  }
  exec{"setting https_port ${r1soft::server::https_port}":
    command => "/usr/bin/serverbackup-setup --https-port ${r1soft::server::https_port}",
    unless  => "/usr/bin/serverbackup-setup --get-https-port | grep -q '^Server HTTPS Port: ${r1soft::server::https_port}$'",
    notify  => Class['r1soft::server::service'],

  }
}

