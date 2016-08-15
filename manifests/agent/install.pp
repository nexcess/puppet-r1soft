class r1soft::agent::install {
  package { $r1soft::agent::package_name:
    ensure => $r1soft::agent::package_version,
  }
}
