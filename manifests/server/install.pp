class r1soft::server::install {
  package { $r1soft::server::package_name :
    ensure => $r1soft::server::package_version,
  }
}
